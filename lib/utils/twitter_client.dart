import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:tweet_separator/models/twitter_status.dart';
import 'package:twitter_1user/twitter_1user.dart';

// ignore: constant_identifier_names
enum KeyStoreStatus { Exist, NotExist, Unknown }

class TwitterClient extends ChangeNotifier {
  TwitterClient() {
    _apiKey = DotEnv().env['TWITTER_API_KEY'];
    _apiSecret = DotEnv().env['TWITTER_API_SECRET'];
    twitterLogin = TwitterLogin(
      consumerKey: _apiKey,
      consumerSecret: _apiSecret,
    );

    final readToken = storage.read(key: 'TWITTER_ACCESS_TOKEN');
    final readSecret = storage.read(key: 'TWITTER_ACCESS_SECRET');

    Future.wait([readToken, readSecret]).then((results) {
      _accessToken = results[0];
      _accessSecret = results[1];
    }).whenComplete(() {
      isStorageAccessed = true;
      twitter = Twitter(apiKey, apiSecret, accessToken, accessSecret);
      notifyListeners();
    });
  }

  String _apiKey = '';
  String _apiSecret = '';
  String _accessToken = '';
  String _accessSecret = '';
  TwitterLogin twitterLogin;
  bool isStorageAccessed = false;
  Twitter twitter;

  String get apiKey => _apiKey;
  String get apiSecret => _apiSecret;
  String get accessToken => _accessToken;
  String get accessSecret => _accessSecret;

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final HtmlUnescape unescape = HtmlUnescape();

  KeyStoreStatus get status {
    if (!isStorageAccessed) {
      return KeyStoreStatus.Unknown;
    }

    return _accessToken == null || _accessSecret == null
        ? KeyStoreStatus.NotExist
        : KeyStoreStatus.Exist;
  }

  Future login() async {
    final result = await twitterLogin.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        _accessToken = result.session.token;
        _accessSecret = result.session.secret;
        twitter = Twitter(apiKey, apiSecret, accessToken, accessSecret);
        await storage.write(key: 'TWITTER_ACCESS_TOKEN', value: _accessToken);
        await storage.write(key: 'TWITTER_ACCESS_SECRET', value: _accessSecret);
        notifyListeners();
        await Fluttertoast.showToast(msg: 'ログインしました！');
        break;

      case TwitterLoginStatus.cancelledByUser:
        await Fluttertoast.showToast(msg: 'キャンセルされました。');
        break;

      case TwitterLoginStatus.error:
        await Fluttertoast.showToast(msg: 'エラーが発生しました。');
        break;
    }
  }

  Future<List<TwitterStatus>> fetchRecentTweets() async {
    if (twitter == null) {
      return [];
    }

    try {
      final response = await twitter.request(
        'get',
        'statuses/home_timeline.json',
        {'trim_user': 'true', 'exclude_replies': 'true'},
      );
      final tweets = jsonDecode(unescape.convert(response)) as List<dynamic>;
      return tweets
          .map((dynamic e) => TwitterStatus.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception catch (error) {
      print(error);
      return [];
    }
  }

  Future<List<UserDetail>> fetchUsersByIdList(List<String> ids) async {
    if (twitter == null) {
      return [];
    }

    try {
      final response = await twitter.request(
        'get',
        'users/lookup.json',
        {'user_id': ids.join(',')},
      );
      final users = jsonDecode(unescape.convert(response)) as List<dynamic>;
      return users
          .map((dynamic e) => UserDetail.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception catch (error) {
      print(error);
      return [];
    }
  }
}

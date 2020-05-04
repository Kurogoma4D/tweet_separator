import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

// ignore: constant_identifier_names
enum KeyStoreStatus { Exist, NotExist, Unknown }

class TwitterLoginHelper extends ChangeNotifier {
  TwitterLoginHelper() {
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
      notifyListeners();
    });
  }

  String _apiKey = '';
  String _apiSecret = '';
  String _accessToken = '';
  String _accessSecret = '';
  TwitterLogin twitterLogin;
  bool isStorageAccessed = false;

  String get apiKey => _apiKey;
  String get apiSecret => _apiSecret;
  String get accessToken => _accessToken;
  String get accessSecret => _accessSecret;

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  KeyStoreStatus get status {
    if (!isStorageAccessed) {
      return KeyStoreStatus.Unknown;
    }

    return _accessToken == null || _accessSecret == null
        ? KeyStoreStatus.NotExist
        : KeyStoreStatus.Exist;
  }

  Future<void> login(BuildContext context) async {
    final result = await twitterLogin.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        const snackBar = SnackBar(content: Text('ログインしました！'));
        _accessToken = result.session.token;
        _accessSecret = result.session.secret;
        await storage.write(key: 'TWITTER_ACCESS_TOKEN', value: _accessToken);
        await storage.write(key: 'TWITTER_ACCESS_SECRET', value: _accessSecret);
        notifyListeners();
        Scaffold.of(context).showSnackBar(snackBar);
        break;

      case TwitterLoginStatus.cancelledByUser:
        const snackBar = SnackBar(content: Text('キャンセルされました。'));
        Scaffold.of(context).showSnackBar(snackBar);
        break;
      case TwitterLoginStatus.error:
        const snackBar = SnackBar(content: Text('エラーが発生しました。'));
        Scaffold.of(context).showSnackBar(snackBar);
        break;
    }
  }
}

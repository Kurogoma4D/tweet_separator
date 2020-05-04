import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tweet_separator/models/judged_tweet.dart';
import 'package:tweet_separator/models/twitter_status.dart';
import 'package:twitter_1user/twitter_1user.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    String apiKey,
    String apiSecret,
    String accessToken,
    String accessSecret,
  }) {
    twitter = Twitter(apiKey, apiSecret, accessToken, accessSecret);
    initPage();
  }

  Twitter twitter;
  List<TwitterStatus> recentTweets = [];
  final JudgedStoreHelper dbHelper = JudgedStoreHelper();
  List<JudgedTweet> judgedData = [];

  Future initPage() async {
    await getRecentTweets();
    final userIds = recentTweets
        .map((t) => t.id)
        .toSet()
        .toString()
        .replaceAll(RegExp(r'[{}]'), '');
    judgedData.addAll(await dbHelper.getExistUsers(userIds));
    notifyListeners();
  }

  Future getRecentTweets() async {
    final response = await twitter.request(
      'get',
      'statuses/home_timeline.json',
      {'trim_user': 'true', 'exclude_replies': 'true'},
    );
    final tweets = jsonDecode(response) as List<dynamic>;

    for (final tweet in tweets) {
      recentTweets.add(TwitterStatus.fromJson(tweet as Map<String, dynamic>));
    }
  }

  void onDismissedTweet(int index, DismissDirection direction) {
    if (direction == DismissDirection.endToStart) {
      /// 左から右
    } else {
      /// 右から左
    }

    recentTweets.removeAt(index);
    notifyListeners();
  }

  @override
  void dispose() {
    print('bye');
    dbHelper.close();
    super.dispose();
  }
}

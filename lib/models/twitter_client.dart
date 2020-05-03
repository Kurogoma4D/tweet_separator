import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tweet_separator/models/twitter_status.dart';
import 'package:twitter_1user/twitter_1user.dart';

class TwitterClient extends ChangeNotifier {
  TwitterClient(
      {String apiKey,
      String apiSecret,
      String accessToken,
      String accessSecret}) {
    twitter = Twitter(apiKey, apiSecret, accessToken, accessSecret);
    getRecentTweets();
  }

  Twitter twitter;
  List<TwitterStatus> recentTweets = [];

  void getRecentTweets() async {
    final response = await twitter.request(
      'get',
      'statuses/home_timeline.json',
      {'trim_user': 'true', 'exclude_replies': 'true'},
    );
    final tweets = jsonDecode(response);

    for (final tweet in tweets) {
      recentTweets.add(TwitterStatus.fromJson(tweet));
    }
    notifyListeners();
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
}

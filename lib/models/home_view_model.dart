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
    final userIds = recentTweets.map((t) => t.user.id).toSet();
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
    final userId = recentTweets[index].user.id;
    final judgedUserId =
        judgedData.indexWhere((element) => element.id == userId);

    final assignedId =
        judgedUserId != -1 ? judgedUserId : _addNewJudgeUser(userId);

    if (direction == DismissDirection.endToStart) {
      /// 左から右
      judgedData[assignedId].disagreed++;
    } else {
      /// 右から左
      judgedData[assignedId].agreed++;
    }

    dbHelper.setJudgement(judgedData[assignedId]);
    recentTweets.removeAt(index);
    notifyListeners();
  }

  int _addNewJudgeUser(int userId) {
    final newJudge = JudgedTweet(id: userId);
    judgedData.add(newJudge);
    return judgedData.length - 1;
  }

  @override
  void dispose() {
    dbHelper.close();
    super.dispose();
  }
}

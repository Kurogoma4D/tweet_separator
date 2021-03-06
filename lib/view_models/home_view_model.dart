import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweet_separator/utils/judged_tweet.dart';
import 'package:tweet_separator/models/twitter_status.dart';
import 'package:tweet_separator/utils/twitter_client.dart';
import 'package:tweet_separator/view/pages/organize_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    this.twitterClient,
    this.dbHelper,
  }) {
    initPage();
  }

  List<TwitterStatus> recentTweets = [];
  final JudgedStoreHelper dbHelper;
  final TwitterClient twitterClient;
  List<JudgedTweet> judgedData = [];
  bool isPrepared = false;
  final DateFormat dateFormatter = DateFormat('yyyyMMdd', 'ja_JP');
  SharedPreferences sharedPref;

  Future initPage() async {
    if (twitterClient.status != KeyStoreStatus.Exist) {
      return;
    }
    initializeDateFormatting('ja_JP');

    sharedPref = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final timeStamp = dateFormatter.format(today);
    final lastStored = sharedPref.getString('timestamp') ?? '0';

    if (int.tryParse(timeStamp) > int.tryParse(lastStored)) {
      recentTweets = await twitterClient.fetchRecentTweets();
      final userIds = recentTweets.map((t) => t.user.id).toSet();
      judgedData.addAll(await dbHelper.getExistUsers(userIds));
    }
    isPrepared = true;
    notifyListeners();
  }

  void onDismissedTweet(
      int index, DismissDirection direction, BuildContext context) {
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

    if (recentTweets.isEmpty) {
      storeTimeStamp(context);
    }
    notifyListeners();
  }

  int _addNewJudgeUser(int userId) {
    final newJudge = JudgedTweet(id: userId);
    judgedData.add(newJudge);
    return judgedData.length - 1;
  }

  Future storeTimeStamp(BuildContext context) async {
    final today = DateTime.now();
    final timeStamp = dateFormatter.format(today);

    final dailyCount = sharedPref.getInt('daily_count') ?? 0;
    if (dailyCount >= 7) {
      Navigator.of(context).pushNamed(OrganizePage.routeName);
      await sharedPref.setInt('daily_count', 0);
    }
    await sharedPref.setString('timestamp', timeStamp);
    await sharedPref.setInt('daily_count', dailyCount + 1);
  }
}

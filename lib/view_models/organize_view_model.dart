import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tweet_separator/models/twitter_status.dart';
import 'package:tweet_separator/utils/judged_tweet.dart';
import 'package:tweet_separator/utils/twitter_client.dart';

class OrganizeViewModel extends ChangeNotifier {
  OrganizeViewModel({
    this.twitterClient,
    this.dbHelper,
  }) {
    initPage();
  }

  final TwitterClient twitterClient;
  final JudgedStoreHelper dbHelper;
  List<UserDetail> organizableUsers = [];

  Future initPage() async {
    final organizable = await dbHelper.getOrganizableUser();
    organizableUsers
        .addAll(await twitterClient.fetchUsersByIdList(organizable));
    notifyListeners();
  }

  void onDone(BuildContext context) {
    Navigator.pop(context);
  }
}

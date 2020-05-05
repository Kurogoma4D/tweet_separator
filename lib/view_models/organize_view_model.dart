import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:tweet_separator/models/twitter_status.dart';
import 'package:tweet_separator/utils/judged_tweet.dart';
import 'package:tweet_separator/utils/twitter_client.dart';
import 'package:tweet_separator/view/pages/root_page.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  bool get isScrollUp {
    if (!_scrollController.hasClients) {
      return false;
    }

    return _scrollController.position.pixels <= 10;
  }

  Future initPage() async {
    final organizable = await dbHelper.getOrganizableUser();
    organizableUsers
        .addAll(await twitterClient.fetchUsersByIdList(organizable));
    notifyListeners();
  }

  void onDone(BuildContext context) {
    Navigator.pushNamed(context, RootPage.routeName);
  }

  Future onPressUser(String screenName) async {
    await launch('https://twitter.com/$screenName');
  }

  bool onScroll(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

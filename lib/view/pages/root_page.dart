import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/utils/twitter_util.dart';
import 'package:tweet_separator/view/widgets/login_view.dart';

import 'home_page.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final twitterUtil = Provider.of<TwitterUtil>(context);

    return Scaffold(
      body: _buildBody(twitterUtil),
    );
  }

  Widget _buildBody(TwitterUtil twitterUtil) {
    switch (twitterUtil.status) {
      case KeyStoreStatus.Exist:
        return HomePage();
      case KeyStoreStatus.NotExist:
        return LoginView();
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}

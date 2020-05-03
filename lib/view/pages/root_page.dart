import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/models/twitter_login_helper.dart';
import 'package:tweet_separator/view/widgets/login_view.dart';

import 'home_page.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginHelper = Provider.of<TwitterLoginHelper>(context);

    return Scaffold(
      body: _buildBody(loginHelper),
    );
  }

  Widget _buildBody(TwitterLoginHelper loginHelper) {
    switch (loginHelper.status) {
      case KeyStoreStatus.Exist:
        return HomePage();
      case KeyStoreStatus.NotExist:
        return LoginView();
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}

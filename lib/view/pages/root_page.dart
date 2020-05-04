import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/utils/twitter_client.dart';
import 'package:tweet_separator/view/widgets/login_view.dart';

import 'home_page.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<TwitterClient>(context);

    return SafeArea(
      child: Scaffold(
        body: _buildBody(client),
      ),
    );
  }

  Widget _buildBody(TwitterClient client) {
    switch (client.status) {
      case KeyStoreStatus.Exist:
        return HomePage();
      case KeyStoreStatus.NotExist:
        return LoginView();
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}

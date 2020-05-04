import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/models/twitter_login_helper.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginHelper = Provider.of<TwitterLoginHelper>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('ログインが必要です。'),
          RaisedButton(
            onPressed: () => loginHelper.login(context),
            child: const Text('ログイン'),
          )
        ],
      ),
    );
  }
}

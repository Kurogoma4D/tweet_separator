import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/utils/twitter_client.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginHelper = Provider.of<TwitterClient>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('ログインが必要です。'),
          RaisedButton(
            onPressed: loginHelper.login,
            child: const Text('ログイン'),
          )
        ],
      ),
    );
  }
}

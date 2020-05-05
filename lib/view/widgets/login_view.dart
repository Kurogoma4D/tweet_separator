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
          const Text(
            'ログインが必要です。',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          RaisedButton(
            onPressed: loginHelper.login,
            child: const Text('ログイン'),
          )
        ],
      ),
    );
  }
}

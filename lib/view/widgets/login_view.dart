import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/utils/twitter_util.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final twitterUtil = Provider.of<TwitterUtil>(context);
    return Center(
      child: Column(
        children: <Widget>[
          Text('ログインが必要です。'),
          RaisedButton(
            onPressed: () => twitterUtil.login(context),
            child: Text('ログイン'),
          )
        ],
      ),
    );
  }
}

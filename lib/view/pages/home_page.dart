import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/models/twitter_client.dart';
import 'package:tweet_separator/models/twitter_login_helper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginHelper = Provider.of<TwitterLoginHelper>(context);
    return ChangeNotifierProvider(
      lazy: false,
      create: (_) => TwitterClient(
        apiKey: loginHelper.apiKey,
        apiSecret: loginHelper.apiSecret,
        accessToken: loginHelper.accessToken,
        accessSecret: loginHelper.accessSecret,
      ),
      child: const _TweetList(),
    );
  }
}

class _TweetList extends StatelessWidget {
  const _TweetList();

  @override
  Widget build(BuildContext context) {
    final tweets = Provider.of<TwitterClient>(context).recentTweets;
    return Center(child: Text('home page'));
  }
}

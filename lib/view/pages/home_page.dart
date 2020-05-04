import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/models/twitter_client.dart';
import 'package:tweet_separator/models/twitter_login_helper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginHelper = Provider.of<TwitterLoginHelper>(context);
    return ChangeNotifierProvider(
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
    final client = Provider.of<TwitterClient>(context);
    return ListView.separated(
      itemCount: client.recentTweets.length,
      separatorBuilder: (_, index) => const SizedBox(
        height: 24,
      ),
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(client.recentTweets[index].id),
          onDismissed: (direction) => client.onDismissedTweet(index, direction),
          background: Container(color: Colors.red),
          secondaryBackground: Container(color: Colors.green),
          child: Card(
            child: Text(client.recentTweets[index].text),
          ),
        );
      },
    );
  }
}

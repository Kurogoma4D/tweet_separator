import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/models/home_view_model.dart';
import 'package:tweet_separator/models/twitter_login_helper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginHelper = Provider.of<TwitterLoginHelper>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(
            apiKey: loginHelper.apiKey,
            apiSecret: loginHelper.apiSecret,
            accessToken: loginHelper.accessToken,
            accessSecret: loginHelper.accessSecret,
          ),
        ),
      ],
      child: const _TweetList(),
    );
  }
}

class _TweetList extends StatelessWidget {
  const _TweetList();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return ListView.separated(
      itemCount: viewModel.recentTweets.length,
      separatorBuilder: (_, index) => const SizedBox(
        height: 24,
      ),
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(viewModel.recentTweets[index].id),
          onDismissed: (direction) =>
              viewModel.onDismissedTweet(index, direction),
          background: Container(color: Colors.red),
          secondaryBackground: Container(color: Colors.green),
          child: Card(
            child: Text(viewModel.recentTweets[index].text),
          ),
        );
      },
    );
  }
}

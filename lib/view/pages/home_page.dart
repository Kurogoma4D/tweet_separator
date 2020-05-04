import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/utils/twitter_client.dart';
import 'package:tweet_separator/view_models/home_view_model.dart';
import 'package:tweet_separator/utils/judged_tweet.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(
        twitterClient: Provider.of<TwitterClient>(context, listen: false),
        dbHelper: Provider.of<JudgedStoreHelper>(context, listen: false),
      ),
      child: const _TweetList(),
    );
  }
}

class _TweetList extends StatelessWidget {
  const _TweetList();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return !viewModel.isPrepared
        ? const Center(child: CircularProgressIndicator())
        : _buildTweets(viewModel);
  }

  Widget _buildTweets(HomeViewModel viewModel) {
    return ListView.separated(
      itemCount: viewModel.recentTweets.length,
      separatorBuilder: (_, index) => const SizedBox(
        height: 24,
      ),
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(viewModel.recentTweets[index].id),
          onDismissed: (direction) =>
              viewModel.onDismissedTweet(index, direction, context),
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

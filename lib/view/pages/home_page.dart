import 'package:flare_flutter/flare_actor.dart';
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

    if (!viewModel.isPrepared) {
      return const Center(child: CircularProgressIndicator());
    }

    return viewModel.recentTweets.length == 0
        ? _buildEmpty()
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

  Widget _buildEmpty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 240,
                height: 300,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: const FlareActor(
                'assets/mr_trash.flr',
                animation: 'open_close',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        const Spacer(),
        const Text('今日の分の断捨離は\n終わりました。'),
        const Text('一日を楽しみましょう！'),
        const Spacer(
          flex: 3,
        )
      ],
    );
  }
}

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/models/twitter_status.dart';
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
    final headerStyle = Theme.of(context).textTheme.headline5.copyWith(
          color: Colors.white,
          height: 2,
          fontWeight: FontWeight.bold,
        );

    if (!viewModel.isPrepared) {
      return const Center(child: CircularProgressIndicator());
    }

    return viewModel.recentTweets.isEmpty
        ? _buildEmpty(context)
        : _buildHeader(viewModel, headerStyle);
  }

  Widget _buildHeader(HomeViewModel viewModel, TextStyle headerStyle) {
    return Column(
      children: [
        SizedBox(
          height: 56,
          child: Text(
            '最近のタイムライン',
            style: headerStyle,
          ),
        ),
        Expanded(
          child: _buildTweets(viewModel),
        ),
      ],
    );
  }

  Widget _buildTweets(HomeViewModel viewModel) {
    return ListView.builder(
//      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.recentTweets.length,
      itemBuilder: (context, index) {
        return AbsorbPointer(
          absorbing: index > 0,
          child: Dismissible(
            key: ValueKey(viewModel.recentTweets[index].id),
            onDismissed: (direction) =>
                viewModel.onDismissedTweet(index, direction, context),
            background: _buildBackground(false),
            secondaryBackground: _buildBackground(true),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(24),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        viewModel.recentTweets[index].text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    _buildImageGrid(viewModel.recentTweets[index]),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageGrid(TwitterStatus status) {
    return status.entities.media == null
        ? const SizedBox.shrink()
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: status.entities.media.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) => AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  status.entities.media[index].mediaUrlHttps,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }

  Widget _buildEmpty(BuildContext context) {
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
        Text(
          '今日の分の断捨離は\n終わりました。',
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        Text(
          '一日を楽しみましょう！',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                height: 2,
              ),
          textAlign: TextAlign.center,
        ),
        const Spacer(
          flex: 3,
        )
      ],
    );
  }

  Widget _buildBackground(bool isNecessary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Align(
        alignment: isNecessary ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8)
            ..copyWith(right: 28),
          decoration: BoxDecoration(
            color:
                isNecessary ? const Color(0xff588C8C) : const Color(0xffD9042B),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Text(
            isNecessary ? '😆 必要' : '😢 不要',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}

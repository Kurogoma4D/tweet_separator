import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/utils/judged_tweet.dart';
import 'package:tweet_separator/utils/twitter_client.dart';
import 'package:tweet_separator/view_models/organize_view_model.dart';

class OrganizePage extends StatelessWidget {
  const OrganizePage({Key key}) : super(key: key);

  static const routeName = '/organize_page';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrganizeViewModel(
        twitterClient: Provider.of<TwitterClient>(context),
        dbHelper: Provider.of<JudgedStoreHelper>(context),
      ),
      child: SafeArea(
        child: Scaffold(
          body: _OrganizableList(),
        ),
      ),
    );
  }
}

class _OrganizableList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OrganizeViewModel>(context);
    return ListView.separated(
      itemCount: viewModel.organizableUsers.length,
      separatorBuilder: (_, index) => const SizedBox(
        height: 24,
      ),
      itemBuilder: (context, index) {
        return Card(
          child: Text(viewModel.organizableUsers[index].name),
        );
      },
    );
  }
}

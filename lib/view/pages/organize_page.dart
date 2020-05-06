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
    final headerStyle = Theme.of(context).textTheme.headline5.copyWith(
          color: Colors.white,
          height: 2,
          fontWeight: FontWeight.bold,
        );
    return Stack(
      children: <Widget>[
        Column(
          children: [
            SizedBox(
              height: 56,
              child: Text(
                '不要な情報が多かったかも？',
                style: headerStyle,
              ),
            ),
            Expanded(
              child: _buildUsers(viewModel),
            ),
          ],
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          bottom: viewModel.isScrollUp ? 20 : -64,
          left: MediaQuery.of(context).size.width * 0.1,
          child: Material(
            elevation: 16,
            shadowColor: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(32),
            color: const Color(0xff588C8C),
            child: InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: () => viewModel.onDone(context),
              child: SizedBox(
                height: 64,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  '完了',
                  style: headerStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsers(OrganizeViewModel viewModel) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) =>
          viewModel.onScroll(scrollNotification),
      child: ListView.builder(
        controller: viewModel.scrollController,
        itemCount: viewModel.organizableUsers.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: ClipOval(
                    child: Image.network(
                      viewModel.organizableUsers[index].profileImageUrlHttps,
                    ),
                  ),
                  title: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 22),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        viewModel.organizableUsers[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  subtitle: Text(
                    '@${viewModel.organizableUsers[index].screenName}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ),
                RaisedButton(
                  elevation: 0,
                  highlightElevation: 0,
                  onPressed: () => viewModel.onPressUser(
                      viewModel.organizableUsers[index].screenName),
                  child: const Text(
                    'Twitterで確認',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: const Color(0xffAC2F33),
                ),
                const SizedBox(height: 8),
              ],
            ),
            margin: Theme.of(context).cardTheme.margin.add(
                  const EdgeInsets.only(bottom: -16),
                ),
          );
        },
      ),
    );
  }
}

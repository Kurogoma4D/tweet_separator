import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/view/pages/root_page.dart';
import 'package:tweet_separator/utils/twitter_util.dart';

class App extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tweet Separator',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: navigatorKey,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => TwitterUtil(),
          )
        ],
        child: RootPage(),
      ),
    );
  }
}

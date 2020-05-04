import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/view/pages/root_page.dart';
import 'package:tweet_separator/models/twitter_login_helper.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
            create: (_) => TwitterLoginHelper(),
          )
        ],
        child: RootPage(),
      ),
    );
  }
}

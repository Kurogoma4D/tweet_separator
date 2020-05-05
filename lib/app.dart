import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_separator/utils/custom_theme_data.dart';
import 'package:tweet_separator/utils/judged_tweet.dart';
import 'package:tweet_separator/utils/twitter_client.dart';
import 'package:tweet_separator/view/pages/organize_page.dart';
import 'package:tweet_separator/view/pages/root_page.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TwitterClient(),
        ),
        Provider<JudgedStoreHelper>(
          create: (_) => JudgedStoreHelper(),
        ),
      ],
      child: MaterialApp(
        locale: const Locale('ja', 'JP'),
        title: 'Tweet Separator',
        theme: customThemeData,
        navigatorKey: navigatorKey,
        home: const RootPage(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case OrganizePage.routeName:
              return PageRouteBuilder<dynamic>(
                pageBuilder: (context, _, __) => const OrganizePage(),
                transitionsBuilder: (context, animation, _, child) {
                  const begin = Offset(1, 0);
                  const end = Offset.zero;
                  const curve = Curves.easeOut;
                  final tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 250),
              );
          }

          return MaterialPageRoute<dynamic>(builder: (context) => RootPage());
        },
        routes: {
          OrganizePage.routeName: (context) => const OrganizePage(),
        },
      ),
    );
  }
}

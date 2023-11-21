import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:hockey_news/news/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';
import 'on_boarding_screen.dart';
import 'news/fb_options.dart';
import 'news/hockey_news_data_source.dart';
import 'presentation/hockey_matches/data/hockey_repository.dart';
import 'presentation/hockey_matches/show_screen.dart';
import 'presentation/notification_fb.dart';

late SharedPreferences prefs;
final remoteConfig = FirebaseRemoteConfig.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 7),
    minimumFetchInterval: const Duration(seconds: 7),
  ));
  await NotificationServiceFb().activate();
  final bool showing = await checkMatchesData();
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    showMatches: showing,
  ));
}

class MyApp extends StatelessWidget {
  final bool showMatches;
  const MyApp({super.key, required this.showMatches});

  @override
  Widget build(BuildContext context) {
    if (showMatches && isMatchesShow != '') {
      return ShowScreen(
        show: isMatchesShow,
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF060606),
      ),
      home: FutureBuilder<bool>(
        future: gettingdataForOnBoarding(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else {
            final bool boolValue = snapshot.data ?? false;
            if (boolValue) {
              return const MainScreen();
            } else {
              return const OnboardingScreen();
            }
          }
        },
      ),
    );
  }

  Future<bool> gettingdataForOnBoarding() async {
    final bool value = prefs.getBool('onBoarded') ?? false;

    await Future.delayed(const Duration(seconds: 3));

    return value;
  }
}

// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hockey_news/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _contrl = PageController();
  int currentPageIndex = 0;
  bool onBoarded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _contrl,
          children: [
            OnboardingPage(
              onButtonTap: () => _contrl.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              ),
              title: "Let's dive into the world of hockey!",
              description:
                  "Welcome to the app that will redefine your hockey match forecasting experience. Get ready for an immersive journey where accurate predictions meet the thrill of the game!",
              child: Image.asset(
                'assets/hockey_man.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
            OnboardingPage(
              onButtonTap: () async {
                final SharedPreferences pref =
                    await SharedPreferences.getInstance();
                await pref.setBool('onBoarded', true);
                if (!context.mounted) {
                  return;
                }
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                );
              },
              title: 'We value your feedback',
              description:
                  'Every day we are getting better due to your ratings and reviews — that helps us protect your accounts.',
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Image.asset(
                  'assets/card.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;
  final VoidCallback onButtonTap;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.child,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(child: child),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF545560),
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: onButtonTap,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 60,
                    alignment: Alignment.center,
                    color: const Color(0xFFd51315),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Text(
                  'Terms of use   Privacy Policy',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: const Color(0xFFbdbdbd),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

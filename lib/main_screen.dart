// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'news/news_screen.dart';
import 'presentation/profile/profile_screen.dart';
import 'presentation/hockey_matches/view/hockey_matches_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HockeyMatchesScreen(),
    const NewsScreen(),
    CalendarScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: const Color(0xFF272727),
        activeColor: const Color(0xFFD41414),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/washer.svg'),
            label: 'Matches',
            activeIcon: SvgPicture.asset('assets/washer_active.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/news.svg'),
            activeIcon: SvgPicture.asset('assets/news_active.svg'),
            label: 'Sport News',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/profile.svg'),
            activeIcon: SvgPicture.asset('assets/profile_active.svg'),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/settings.svg'),
            activeIcon: SvgPicture.asset('assets/settings_active.svg'),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return _pages[index];
          },
        );
      },
    );
  }
}

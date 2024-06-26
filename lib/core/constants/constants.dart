import 'package:ai_shapers/features/home/screens/main_screen.dart';
import 'package:ai_shapers/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class Constants {
  static const avatarDefault =
      'https://cdn.cloudflare.steamstatic.com/steamcommunity/public/images/avatars/89/89496ab402ac222c0ddaed7add5d9eb6deb759f9_full.jpg';

  static const tabWidgets = [
    MainScreen(),
    UserProfileScreen(),
    Scaffold(),
  ];
}

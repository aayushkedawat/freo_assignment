import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freo_assignment/core/constants/assets.dart';
import 'package:freo_assignment/core/constants/strings.dart';
import 'package:freo_assignment/core/util/connectivity_check.dart';
import 'package:freo_assignment/features/wiki/presentation/pages/home/wiki_search.dart';
import 'package:freo_assignment/features/wiki/presentation/pages/local/saved_pages.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToScreen();
  }

  void navigateToScreen() async {
    Widget screenToNavigate = const WikiSearchScreen();
    if (!(await ConnectivityCheck.isConnected())) {
      screenToNavigate = const SavedPagesScreen();
    }
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => screenToNavigate,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(Assets.splashAnimationLottie),
          Text(Strings.splashScreenWelcomeMessage),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fresh_shelf/core/shared_preferences/shared_preferences_instance.dart';
import 'package:fresh_shelf/core/shared_preferences/shared_preferences_key.dart';
import 'package:provider/provider.dart';

import '../../../../core/app/state/app_state.dart';
import '../../../../core/configuration/assets.dart';
import '../../../../core/configuration/styles.dart';
import '../../../../core/routing/route_path.dart';
import '../../../../core/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _navigateAfterDelay();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = ColorTween(
      begin: Styles.colorPrimary,
      end: Styles.backgroundColor,
    ).animate(_animationController);

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    final user =
        SharedPreferencesInstance.pref.getInt(SharedPreferencesKeys.USER_ID);

    if (user != null) {
      _navigateBasedOnUserProfile();
    } else {
      _navigateBasedOnFirstTime();
    }
  }

  void _navigateBasedOnUserProfile() async {
    await Provider.of<AppState>(context, listen: false).init();
    _navigateTo(RoutePaths.Home);
  }

  void _navigateBasedOnFirstTime() {
    _navigateTo(RoutePaths.LogIn);
  }

  void _navigateTo(String route) {
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: _animation.value,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsLink.APP_LOGO,
              width: 100,
              height: 100,
            ),
            Text(
              "Daily Basket",
              style: TextStyle(
                  color: Color(0XFF2d7283),
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

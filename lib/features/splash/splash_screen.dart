import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/local_storage/local_storage.dart';
import '../../core/constant/app_assets.dart';
import '../../core/router/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final hive = HiveServiceImpl.instance;

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      if (!hive.isOnboardingVisited()) {
        context.go(Routes.onboarding);
      } else if (hive.getAccessToken() == null) {
        // context.go(Routes.onboarding);

        context.go(Routes.login);
      } else {
        context.go(Routes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image.asset(
          //   AppAssets.splashGif,
          //   fit: BoxFit.cover,
          //   height: double.infinity,
          //   width: double.infinity,
          // ),
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 4),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: Transform.scale(scale: value, child: child),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  AppAssets.appLogo,
                  height: 130,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

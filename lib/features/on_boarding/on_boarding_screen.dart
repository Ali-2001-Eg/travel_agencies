part of 'on_boarding.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FluidCarousel(
            onComplete: () {
              HiveServiceImpl.instance.saveOnboardingVisited(true);
              context.go(Routes.login);
            },
            terminalWidget: Container(
              color: context.isDarkMode
                  ? const Color(0xFF1A1A2E)
                  : const Color(0xFFF5F7FA),
            ),
            children: <Widget>[
              FluidCard(
                color: 'Red',
                altColor: const Color(0xFF4259B2),
                title: LocaleKeys.onboarding_title_1.tr(),
                subtitle: LocaleKeys.onboarding_subtitle_1.tr(),
              ),
              FluidCard(
                color: 'Yellow',
                altColor: const Color(0xFF904E93),
                title: LocaleKeys.onboarding_title_2.tr(),
                subtitle: LocaleKeys.onboarding_subtitle_2.tr(),
              ),
              FluidCard(
                color: 'Blue',
                altColor: const Color(0xFFFFB138),
                title: LocaleKeys.onboarding_title_3.tr(),
                subtitle: LocaleKeys.onboarding_subtitle_3.tr(),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                HiveServiceImpl.instance.saveOnboardingVisited(true);
                context.go(Routes.login);
              },
              child: Text(
                LocaleKeys.skip.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

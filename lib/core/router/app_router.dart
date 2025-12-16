part of 'router.dart';

abstract interface class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: Routes.initial,
    routes: [
      GoRoute(
        path: Routes.initial,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: Routes.otp,
        builder: (context, state) {
          final phoneNumber = state.extra as String;
          return  OtpScreen(phoneNumber: phoneNumber,);
        },
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );

  static Widget getRootApp({
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  }) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          routerConfig: router,
          title: 'Flutter Demo',
          theme: AppThemeData.light(context),
          darkTheme: AppThemeData.dark(context),
          themeMode: themeState.themeMode,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}

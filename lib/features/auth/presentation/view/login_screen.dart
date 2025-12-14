part of '../../auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // Tablet Layout
    if (context.isTablet) {
      return AuthResponsiveScaffold(
        header: const LoginHeader(),
        card: const LoginCard(),
        brandingIcon: Icons.travel_explore,
        brandingTitle: LocaleKeys.discover_egypt.tr(),
        brandingSubtitle: LocaleKeys.book_amazing_activities.tr(),
      );
    }

    // Mobile Layout
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? const Color(0xFF1A1A2E)
          : const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            // Header with language and theme toggles
            SafeArea(child: const LoginHeader()),

            Gaps.v(40),

            // Main login card
            const LoginCard(),
          ],
        ),
      ),
    );
  }
}

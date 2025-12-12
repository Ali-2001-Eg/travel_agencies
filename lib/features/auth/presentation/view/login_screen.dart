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
      return Scaffold(
        backgroundColor: context.isDarkMode
            ? const Color(0xFF1A1A2E)
            : const Color(0xFFF5F7FA),
        body: Row(
          children: [
            // Left Side: Branding/Welcome
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: context.isDarkMode
                        ? [const Color(0xFF2A2A3E), const Color(0xFF151523)]
                        : [Colors.blue.shade400, Colors.blue.shade800],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.travel_explore,
                      size: 100,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      LocaleKeys.discover_egypt.tr(),
                      style: context.textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      LocaleKeys.book_amazing_activities.tr(),
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Right Side: Login Form
            Expanded(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: LoginHeader(),
                    ),
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 48),
                          child: const LoginCard(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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

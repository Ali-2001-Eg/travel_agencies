part of '../../auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                      Icons.person_add_alt_1,
                      size: 100,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      LocaleKeys.create_account.tr(),
                      style: context.textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      LocaleKeys.create_account_to_get_started.tr(),
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Right Side: Register Form
            Expanded(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 24),
                    child: Column(
                      children: [
                        const RegisterHeader(),
                        Gaps.v(40),
                        const RegisterCard(),
                      ],
                    ),
                  ),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header with back button and toggles
              const RegisterHeader(),

              Gaps.v(40),

              // Main register card
              const RegisterCard(),
            ],
          ),
        ),
      ),
    );
  }
}

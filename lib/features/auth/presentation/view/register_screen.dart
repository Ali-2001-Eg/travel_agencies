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
      return AuthResponsiveScaffold(
        header: const RegisterHeader(),
        card: const RegisterCard(),
        brandingIcon: Icons.person_add_alt_1,
        brandingTitle: LocaleKeys.create_account.tr(),
        brandingSubtitle: LocaleKeys.create_account_to_get_started.tr(),
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

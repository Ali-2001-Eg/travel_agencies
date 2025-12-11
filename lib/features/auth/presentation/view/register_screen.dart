part of '../../auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
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

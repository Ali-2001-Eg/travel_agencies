part of '../../auth.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with language and theme toggles
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Language dropdown
            const LocaleDropdown(),
            Gaps.h10(),
            // Theme toggle
            const ThemeToggleButton(),
          ],
        ),

      ],
    );
  }
}

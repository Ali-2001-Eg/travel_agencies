part of '../../auth.dart';

class LoginPrompt extends StatelessWidget {
  const LoginPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        LocalizedLabel(
          text: LocaleKeys.already_have_account,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigate to login
            context.pop();
          },
          child: LocalizedLabel(
            text: LocaleKeys.login_here,
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF00BFA5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

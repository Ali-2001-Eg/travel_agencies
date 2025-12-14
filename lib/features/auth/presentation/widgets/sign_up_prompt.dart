part of '../../auth.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Wrap(

        // crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          LocalizedLabel(
            text: LocaleKeys.dont_have_account,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
          TextButton(
            onPressed: () {
              context.push(Routes.register);
            },
            child: LocalizedLabel(
              text: LocaleKeys.register_now,
              style: context.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF00BFA5),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

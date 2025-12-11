part of '../../auth.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Google button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton.icon(
            onPressed: () {
              // Google sign in logic
            },
            icon: const Icon(Icons.search, color: Colors.black54),
            label: LocalizedLabel(
              text: LocaleKeys.continue_with_google,
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(
                color: context.isDarkMode ? Colors.white30 : Colors.black12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        Gaps.v18(),

        // Apple button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {
              // Apple sign in logic
            },
            icon: const Icon(Icons.apple, color: Colors.white),
            label: LocalizedLabel(
              text: LocaleKeys.continue_with_apple,
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

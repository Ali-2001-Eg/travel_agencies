part of '../../auth.dart';

class RegisterCard extends StatelessWidget {
  const RegisterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // User icon
          const UserAvatarIcon(),

          Gaps.v25(),

          // Register as Customer title
          LocalizedLabel(
            text: LocaleKeys.register_as_customer,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.isDarkMode ? Colors.white : Colors.black87,
            ),
          ),

          Gaps.v10(),

          // Subtitle
          LocalizedLabel(
            text: LocaleKeys.create_account_to_get_started,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.isDarkMode ? Colors.white60 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),

          Gaps.v(32),

          // Social login buttons
          const SocialLoginButtons(),

          Gaps.v(32),

          // Or register with email
          LocalizedLabel(
            text: LocaleKeys.or_register_with_email,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.isDarkMode ? Colors.white60 : Colors.black54,
            ),
          ),

          Gaps.v(32),

          // Register form
          const RegisterForm(),

          Gaps.v(24),

          // Already have account
          const LoginPrompt(),
        ],
      ),
    );
  }
}

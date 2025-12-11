part of '../../auth.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Full Name field
        CustomTextField(
          labelText: LocaleKeys.full_name,
          hintText: LocaleKeys.full_name_placeholder,
          controller: _fullNameController,
          keyboardType: TextInputType.name,
          prefixIcon: Icon(
            Icons.person_outline,
            color: context.isDarkMode ? Colors.white60 : Colors.black54,
          ),
          fillColor: context.isDarkMode
              ? const Color(0xFF3A3A4E)
              : Colors.grey.shade50,
        ),

        Gaps.v18(),

        // Email field
        CustomTextField(
          labelText: LocaleKeys.email_address,
          hintText: LocaleKeys.email_placeholder,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icon(
            Icons.email_outlined,
            color: context.isDarkMode ? Colors.white60 : Colors.black54,
          ),
          fillColor: context.isDarkMode
              ? const Color(0xFF3A3A4E)
              : Colors.grey.shade50,
        ),

        Gaps.v18(),

        // Phone field
        CustomTextField(
          labelText: LocaleKeys.phone_number,
          hintText: LocaleKeys.phone_placeholder,
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          prefixIcon: Icon(
            Icons.phone_outlined,
            color: context.isDarkMode ? Colors.white60 : Colors.black54,
          ),
          fillColor: context.isDarkMode
              ? const Color(0xFF3A3A4E)
              : Colors.grey.shade50,
        ),

        Gaps.v18(),

        // Password field
        CustomTextField(
          labelText: LocaleKeys.password,
          hintText: LocaleKeys.password_placeholder,
          controller: _passwordController,
          obscureText: true,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: context.isDarkMode ? Colors.white60 : Colors.black54,
          ),
          fillColor: context.isDarkMode
              ? const Color(0xFF3A3A4E)
              : Colors.grey.shade50,
        ),

        Gaps.v18(),

        // Confirm Password field
        CustomTextField(
          labelText: LocaleKeys.confirm_password,
          hintText: LocaleKeys.confirm_password_placeholder,
          controller: _confirmPasswordController,
          obscureText: true,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: context.isDarkMode ? Colors.white60 : Colors.black54,
          ),
          fillColor: context.isDarkMode
              ? const Color(0xFF3A3A4E)
              : Colors.grey.shade50,
        ),

        Gaps.v18(),

        // Terms and conditions checkbox
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: _agreeToTerms,
              onChanged: (value) {
                setState(() {
                  _agreeToTerms = value ?? false;
                });
              },
              activeColor: const Color(0xFF00BFA5),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: RichText(
                  text: TextSpan(
                    style: context.textTheme.bodyMedium?.copyWith(
                      color:
                          context.isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                    children: [
                      TextSpan(text: LocaleKeys.i_agree_to_the.tr()),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: LocaleKeys.terms_of_service.tr(),
                        style: const TextStyle(
                          color: Color(0xFF00BFA5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(text: ' ${LocaleKeys.and.tr()} '),
                      TextSpan(
                        text: LocaleKeys.privacy_policy.tr(),
                        style: const TextStyle(
                          color: Color(0xFF00BFA5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        Gaps.v(32),

        // Create Account button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _agreeToTerms
                ? () {
                    // Register logic
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BFA5),
              disabledBackgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: LocalizedLabel(
              text: LocaleKeys.create_account,
              style: context.textTheme.bodyLarge?.copyWith(
                color: _agreeToTerms ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

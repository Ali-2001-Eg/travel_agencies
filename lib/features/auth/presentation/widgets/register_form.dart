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
    return BlocProvider(
      create: (context)=>getIt<RegisterBloc>(),
      child: BlocConsumer<RegisterBloc, BaseState<void>>(
        // Wrapped in BlocConsumer to handle navigation
        listener: (context, state) {
          if (state.isSuccess) {
            context.push(Routes.otp,extra: _phoneController.text.trim()); // Push to OTP screen
          }
          if (state.isFailure) {
            context.showTopSnackBar(
              message: state.errorMessage!,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
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

              // Phone field with IntlPhoneField
              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: IntlPhoneField(
                  textAlign: TextAlign.center,
                  dropdownTextStyle: context.textTheme.headlineMedium?.copyWith(
                      color: context.isDarkMode ? HexColor.white : Colors.black),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  pickerDialogStyle: PickerDialogStyle(
                    countryCodeStyle: context.textTheme.headlineSmall?.copyWith(
                        color:
                            context.isDarkMode ? HexColor.white : Colors.black),
                    searchFieldInputDecoration: InputDecoration(
                      hintText: LocaleKeys.search_country.tr(),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              context.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              context.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: context.colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: context.colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                  style: context.textTheme.headlineMedium?.copyWith(
                      color: context.isDarkMode ? HexColor.white : Colors.black),
                  decoration: InputDecoration(
                    hintText: LocaleKeys.phone_number.tr(),
                    counterStyle: context.textTheme.titleSmall
                        ?.copyWith(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'EG',
                  onChanged: (phone) {
                    _phoneController.text = phone.completeNumber;
                  },
                  onCountryChanged: (country) {
                    // Optionally handle country change
                  },
                  validator: (value) {
                    if (value == null || value.number.isEmpty) {
                      return LocaleKeys.phone_number_required.tr();
                    }
                    try {
                      if (!value.isValidNumber()) {
                        return LocaleKeys.phone_number_invalid.tr();
                      }
                    } catch (e) {
                      return LocaleKeys.phone_number_invalid.tr();
                    }
                    return null;
                  },
                ),
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
                            color: context.isDarkMode
                                ? Colors.white70
                                : Colors.black87,
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
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : ElevatedButton(
                        onPressed: _agreeToTerms
                            ? () {
                                context.read<RegisterBloc>().add(RegisterEvent(
                                      name: _fullNameController.text,
                                      email: _emailController.text,
                                      phone: _phoneController.text,
                                      password: _passwordController.text,
                                      confirmPassword:
                                          _confirmPasswordController.text,
                                    ));
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
                            color: _agreeToTerms
                                ? Colors.white
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

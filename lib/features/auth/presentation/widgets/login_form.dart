part of '../../auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Email field
          CustomTextField(
            labelText: LocaleKeys.email_address,
            hintText: LocaleKeys.email_placeholder,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.email_required.tr();
              }
              if (!isValidEmail(value)) {
                return LocaleKeys.email_invalid.tr();
              }
              return null;
            },
            prefixIcon: Icon(
              Icons.email_outlined,
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.password_required.tr();
              }
              if (value.length < 6) {
                return LocaleKeys.password_length_error.tr();
              }
              return null;
            },
            prefixIcon: Icon(
              Icons.lock_outline,
              color: context.isDarkMode ? Colors.white60 : Colors.black54,
            ),
            fillColor: context.isDarkMode
                ? const Color(0xFF3A3A4E)
                : Colors.grey.shade50,
          ),

          Gaps.v18(),

          // Remember me and forgot password
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      activeColor: const Color(0xFF00BFA5),
                    ),
                    LocalizedLabel(
                      text: LocaleKeys.remember_me,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.isDarkMode
                            ? Colors.white70
                            : Colors.black87,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // Forgot password logic
                  },
                  child: LocalizedLabel(
                    text: LocaleKeys.forgot_password,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF00BFA5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Gaps.v(32),

          // Login button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: BlocProvider(
              create: (context) => getIt<LoginBloc>(),
              child: BlocConsumer<LoginBloc, BaseState<void>>(
                listener: (context, state) {
                  if (state.isSuccess) {
                    context.go(Routes.home);
                  }
                  if (state.isFailure) {
                    context.showTopSnackBar(
                        message: state.errorMessage!, type: SnackBarType.error);
                  }
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return CircularProgressIndicator.adaptive();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(LoginEvent(
                            _emailController.text, _passwordController.text));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BFA5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: LocalizedLabel(
                      text: LocaleKeys.login,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isValidEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }
}

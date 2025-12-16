part of '../../auth.dart';

class OtpForm extends StatefulWidget {
  final String phoneNumber;
  const OtpForm({super.key, required this.phoneNumber});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text(
            LocaleKeys.otp_subtitle.tr(),
            style: context.textTheme.bodyLarge?.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          Gaps.v(32),
          Directionality(
            textDirection: ui.TextDirection.ltr,
            child: PinCodeTextField(
              appContext: context,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.otp_invalid.tr();
                }
                if (value.length != 4) {
                  return LocaleKeys.otp_invalid.tr();
                }
                return null;
              },
              mainAxisAlignment: MainAxisAlignment.center,
              separatorBuilder: (context, index) => Gaps.h25(),
              length: 4,
              controller: _otpController,
              obscureText: false,
              animationType: AnimationType.fade,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              pinTheme: PinTheme(
                errorBorderColor: HexColor.red,

                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 80,
                fieldWidth: 60,
                activeFillColor:
                context.isDarkMode ? const Color(0xFF3A3A4E) : Colors.white,
                inactiveFillColor: context.isDarkMode
                    ? const Color(0xFF3A3A4E)
                    : Colors.grey.shade50,
                selectedFillColor:
                context.isDarkMode ? const Color(0xFF3A3A4E) : Colors.white,
                activeColor: context.colorScheme.primary,
                inactiveColor: Colors.grey.shade300,
                selectedColor: context.colorScheme.primary,
                borderWidth: 1,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              onCompleted: (v) {
                // Auto submit or just validate
              },
              onChanged: (value) {
                // Handle change
              },
              beforeTextPaste: (text) {
                return true;
              },

              textStyle: context.textTheme.headlineLarge?.copyWith(
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Gaps.v(32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: BlocProvider(
              create: (context) => getIt<VerifyOTPBloc>(),
              child: BlocConsumer<VerifyOTPBloc, BaseState<void>>(
                listener: (context, state) {
                  if(state.isSuccess){
                    context.go(Routes.home);
                  }
                  if(state.isFailure){
                    context.showTopSnackBar(message: state.errorMessage!,type: SnackBarType.error);
                  }
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return CircularProgressIndicator.adaptive();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Verify Logic
                        context.read<VerifyOTPBloc>().add(VerifyOtpEvent(
                            widget.phoneNumber, _otpController.text));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BFA5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: LocalizedLabel(
                      text: LocaleKeys.verify,
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
          Gaps.v(18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.didnt_receive_code.tr(),
                style: context.textTheme.bodyLarge,
              ),
              TextButton(
                onPressed: () {
                  // Resend logic
                },
                child: Text(
                  LocaleKeys.resend_code.tr(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Color(0xFF00BFA5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//7009
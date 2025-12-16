part of '../../auth.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocalizedLabel(
          text: LocaleKeys.otp_title,
          style: context.textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:  SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                OtpForm(
                  phoneNumber: phoneNumber,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

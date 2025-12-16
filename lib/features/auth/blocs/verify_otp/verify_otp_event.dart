part of "../../auth.dart";
 interface class VerifyOtpEvent extends Equatable{
  final String phone;
  final String otp;
  const VerifyOtpEvent(this.phone, this.otp);
  @override
  List<Object?> get props => [phone, otp];
}

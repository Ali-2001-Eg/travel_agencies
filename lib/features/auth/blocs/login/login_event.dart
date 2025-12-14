part of "../../auth.dart";

 interface class LoginEvent extends Equatable {
  final String phone;
  final String password;
  const LoginEvent(this.phone, this.password);
  @override
  List<Object?> get props => [phone,password];
}

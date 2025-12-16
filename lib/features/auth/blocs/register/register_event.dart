part of "../../auth.dart";

class RegisterEvent extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  const RegisterEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [name, email, phone, password, confirmPassword];
}

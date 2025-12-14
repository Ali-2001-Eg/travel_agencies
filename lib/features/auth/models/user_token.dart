part of '../auth.dart';
class UserToken extends Equatable{
  final String token;

  const UserToken({required this.token});

  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(
      token: json['token'] ?? "",
    );
  }
  @override
  List<Object?> get props => [token];
}
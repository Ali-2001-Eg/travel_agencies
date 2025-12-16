part of "../../auth/auth.dart";

abstract interface class LoginDataSource {
  Future<Either<Failure, UserToken>> login(
      String phone, String password, String deviceToken);
}

class LoginDataSourceImpl implements LoginDataSource {
  final GenericDataSource _genericDataSource;
  const LoginDataSourceImpl(this._genericDataSource);

  @override
  Future<Either<Failure, UserToken>> login(
      String phone, String password, String deviceToken) async {
    final result = await _genericDataSource.postData(
      endpoint: Endpoints.login,
      fromJson: UserToken.fromJson,
      data: {"phone": phone, "password": password, "fcm_token": deviceToken},
    );
    return result.fold((left) => Left(left), (right) async {
      await getIt<ITokenCache>().saveAccessToken(right.token);
      getIt<Dio>()
          .options
          .headers
          .addAll({"Authorization": "Bearer ${right.token}"});
      return Right(right);
    });
  }
}

part of "../../auth/auth.dart";

abstract interface class LoginDataSource {
  Future<Either<Failure, void>> login(
      String phone, String password, String deviceToken);
}

class LoginDataSourceImpl implements LoginDataSource {
  final GenericDataSource _genericDataSource;
  const LoginDataSourceImpl(this._genericDataSource);

  @override
  Future<Either<Failure, void>> login(
      String phone, String password, String deviceToken) {
    return _genericDataSource.postData(endpoint: Endpoints.login, data: {
      "phone": phone,
      "password": password,
      "device_token": deviceToken
    });
  }
}

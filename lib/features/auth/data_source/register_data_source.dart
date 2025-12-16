part of "../../auth/auth.dart";

abstract interface class RegisterDataSource {
  Future<Either<Failure, void>> register(Map<String, dynamic> body);
}

class RegisterDataSourceImpl implements RegisterDataSource {
  final GenericDataSource _genericDataSource;
  const RegisterDataSourceImpl(this._genericDataSource);

  @override
  Future<Either<Failure, void>> register(Map<String, dynamic> body) {
    return _genericDataSource.postData(
        endpoint: Endpoints.register, data: body);
  }
}

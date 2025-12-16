part of "../../auth/auth.dart";

abstract interface class VerifyOTPDataSource {
  Future<Either<Failure, UserToken>> verify(String phone, String otp);
  Future<Either<Failure, void>> resend(String phone);
}

class VerifyOTPDataSourceImpl implements VerifyOTPDataSource {
  final GenericDataSource _genericDataSource;
  const VerifyOTPDataSourceImpl(this._genericDataSource);

  @override
  Future<Either<Failure, UserToken>> verify(String phone, String otp) async {
    final result = await _genericDataSource.postData<UserToken>(
        endpoint: Endpoints.verifyOtp, data: {"phone": phone, "otp": otp},fromJson: UserToken.fromJson);
    return result.fold((left) => Left(left), (right) async {
      await getIt<ITokenCache>().saveAccessToken(right.token);
      getIt<Dio>()
          .options
          .headers
          .addAll({"Authorization": "Bearer ${right.token}"});
      return Right(right);
    });
  }

  @override
  Future<Either<Failure, void>> resend(String phone) {
    return _genericDataSource
        .postData(endpoint: Endpoints.resendOtp, data: {"phone": phone});
  }
}

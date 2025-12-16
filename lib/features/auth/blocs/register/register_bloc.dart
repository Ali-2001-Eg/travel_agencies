part of "../../auth.dart";

class RegisterBloc extends Bloc<RegisterEvent, BaseState<void>> {
  final RegisterDataSource _registerDataSource;
  RegisterBloc(this._registerDataSource) : super(const BaseState<void>()) {
    on<RegisterEvent>(_onRegister);
  }
  FutureOr<void> _onRegister(
      RegisterEvent event, Emitter<BaseState<void>> emit) async {
    emit(state.copyWith(status: Status.loading));
    String fcm = "";
    try{
      fcm = await FirebaseMessaging.instance.getToken() ?? "";
    }catch(e){
      fcm = "dummy";
    }
    final result = await _registerDataSource.register({
      "name": event.name,
      "email": event.email,
      "phone": event.phone,
      "password": event.password,
      "password_confirmation": event.confirmPassword,
      "fcm_token": fcm,
      "type": "customer"
    });
    emit(result.fold(
      (failure) => state.copyWith(
          status: Status.failure,
          errorMessage: failure.message,
          failure: failure),
      (data) => state.copyWith(status: Status.success),
    ));
  }
}

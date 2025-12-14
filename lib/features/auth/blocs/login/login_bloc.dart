part of "../../auth.dart";

class LoginBloc extends Bloc<LoginEvent, BaseState<void>> {
  final LoginDataSource _loginDataSource;
  LoginBloc(this._loginDataSource) : super(const BaseState<void>()) {
    on<LoginEvent>(_onLogin);
  }
  FutureOr<void> _onLogin(
      LoginEvent event, Emitter<BaseState<void>> emit) async {
    emit(state.copyWith(status: Status.loading));
    String fcm = "";
    try{
      fcm = await FirebaseMessaging.instance.getToken() ?? "";
    }catch(e){
      fcm = "";
    }
    final result = await _loginDataSource.login(event.email,event.password,fcm);
    emit(result.fold(
      (failure) => state.copyWith(
          status: Status.failure,
          errorMessage: failure.message,
          failure: failure),
      (data) => state.copyWith(status: Status.success),
    ));
  }
}

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(LoginInitial());

  final AuthenticationRepository _authenticationRepository;

  Future<void> loginWithGoogle() async {
    emit(LoginPerforming());
    try {
      await _authenticationRepository.loginWithGoogle();
    } on Exception {
      emit(LoginFailed());
    } on NoSuchMethodError {
      emit(LoginFailed());
    }
  }
}

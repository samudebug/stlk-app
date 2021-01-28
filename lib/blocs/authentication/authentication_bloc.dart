import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {@required AuthenticationRepository authenticationRepository,
      @required UserRepository userRepository})
      : assert(authenticationRepository != null),
        assert(userRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(AuthenticationUnknown()) {
    _userSubscription = _authenticationRepository.user.listen((user) {
      add(AuthenticationUserChanged(user));
    });
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  StreamSubscription<User> _userSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      yield await _mapAuthenticationUserChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationUserChangedToState(
      AuthenticationUserChanged event) async {
    if (event.user != User.empty) {
      await _userRepository.getDbId(
          event.user.id, (await event.user.firebaseUser.getIdToken()));
      return AuthenticationAuthenticated(event.user);
    }
    return event.user != User.empty
        ? AuthenticationAuthenticated(event.user)
        : AuthenticationUnauthenticated();
  }
}

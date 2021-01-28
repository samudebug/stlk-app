part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationUnknown extends AuthenticationState {
  const AuthenticationUnknown({this.user = User.empty});

  final User user;

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthenticationAuthenticated extends AuthenticationState {
  const AuthenticationAuthenticated(this.user) : assert(user != null);

  final User user;

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  const AuthenticationUnauthenticated({this.user = User.empty});

  final User user;
  @override
  // TODO: implement props
  List<Object> get props => [user];
}

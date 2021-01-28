import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class User extends Equatable {
  const User({@required this.id, @required this.firebaseUser})
      : assert(id != null);
  final String id;
  final firebase_auth.User firebaseUser;

  static const empty = User(id: '', firebaseUser: null);

  @override
  // TODO: implement props
  List<Object> get props => [id, firebaseUser];
}

import 'package:api_repository/api_repository.dart';

class UserActionError implements Exception {}

class UserRepository {
  const UserRepository({this.apiRepository = const APIRepository()});
  final APIRepository apiRepository;

  Future<void> getDbId(uid, idToken) async {
    try {
      Map<String, String> headers = {'auth': idToken};
      await apiRepository.performGet('http://10.0.2.2:3000/auth/login',
          headers: headers);
    } on Exception {
      throw UserActionError();
    }
  }
}

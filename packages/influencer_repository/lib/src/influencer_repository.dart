import 'package:api_repository/api_repository.dart';
import 'package:meta/meta.dart';
import 'package:authentication_repository/authentication_repository.dart';

import 'models/influencer.dart';

class InfluencerActionFailed implements Exception {}

class InfluencerRepository {
  InfluencerRepository(
      {@required APIRepository apiRepository,
      @required AuthenticationRepository authenticationRepository})
      : assert(apiRepository != null),
        _apiRepository = apiRepository,
        _authenticationRepository = authenticationRepository;
  final APIRepository _apiRepository;
  AuthenticationRepository _authenticationRepository;

  Future<List<Influencer>> getInfluencers() async {
    try {
      List<Influencer> result = List();

      String idToken = await _authenticationRepository.currentUser.firebaseUser
          .getIdToken(true);
      Map<String, String> headers = {'auth': idToken};
      List<dynamic> apiResponse = await _apiRepository.performGet(
          'https://stlk-api.herokuapp.com/influencers',
          headers: headers);
      result = apiResponse.map((item) => Influencer.fromJson(item)).toList();
      return result;
    } on Exception {
      throw InfluencerActionFailed();
    }
  }
}
import 'package:api_repository/api_repository.dart';
import 'package:influencer_repository/src/models/social_media.dart';
import 'package:influencer_repository/src/models/twitter_profile.dart';
import 'package:meta/meta.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:messaging_repository/messaging_repository.dart';

import 'models/influencer.dart';

class InfluencerActionFailed implements Exception {}

class InfluencerRepository {
  InfluencerRepository(
      {@required APIRepository apiRepository,
      @required AuthenticationRepository authenticationRepository,
      @required MessagingRepository messagingRepository})
      : assert(apiRepository != null),
        _apiRepository = apiRepository,
        _authenticationRepository = authenticationRepository,
        _messagingRepository = messagingRepository;
  final APIRepository _apiRepository;
  AuthenticationRepository _authenticationRepository;
  MessagingRepository _messagingRepository;

  Future<List<Influencer>> getInfluencers() async {
    try {
      List<Influencer> result = List();

      String idToken = await _authenticationRepository.currentUser.firebaseUser
          .getIdToken(true);
      Map<String, String> headers = {'auth': idToken};
      List<dynamic> apiResponse = await _apiRepository
          .performGet('https://10.0.2.2:3000/influencers', headers: headers);
      result = apiResponse.map((item) => Influencer.fromJson(item)).toList();
      return result;
    } on Exception {
      throw InfluencerActionFailed();
    }
  }

  Future<void> createInfluencer(Influencer influencer) async {
    try {
      String idToken = await _authenticationRepository.currentUser.firebaseUser
          .getIdToken(true);
      Map<String, String> headers = {
        'auth': idToken,
        "Content-Type": "application/json"
      };
      await _apiRepository.performPost(
          'http://10.0.2.2:3000/influencers', influencer.toJson(),
          headers: headers);
    } on Exception {
      throw InfluencerActionFailed();
    }
  }

  Future<List<TwitterProfile>> searchTwitterProfile(String handle) async {
    try {
      String idToken = await _authenticationRepository.currentUser.firebaseUser
          .getIdToken(true);
      Map<String, String> headers = {"auth": idToken};
      List result = await _apiRepository.performGet(
          "http://10.0.2.2:3000/twitter/search?search=$handle",
          headers: headers);
      return result.map((e) => TwitterProfile.fromJson(e)).toList();
    } on Exception {
      throw InfluencerActionFailed();
    }
  }

  Future<void> addSocialMedia(
      String influencerId, SocialMedia socialMedia) async {
    try {
      String idToken = await _authenticationRepository.currentUser.firebaseUser
          .getIdToken(true);
      Map<String, String> headers = {
        'auth': idToken,
        "Content-Type": "application/json"
      };
      socialMedia.registrationToken =
          await _messagingRepository.getDeviceToken();
      await _apiRepository.performPut(
          'http://10.0.2.2:3000/influencers/$influencerId/socialMedia',
          socialMedia.toJson(),
          headers: headers);
    } on Exception {
      throw InfluencerActionFailed();
    }
  }

  Future<Influencer> getInfluencer(String influencerId) async {
    try {
      String idToken = await _authenticationRepository.currentUser.firebaseUser
          .getIdToken(true);
      Map<String, String> headers = {"auth": idToken};
      Map result = await _apiRepository.performGet(
          "http://10.0.2.2:3000/influencers/$influencerId",
          headers: headers);
      return Influencer.fromJson(result);
    } on Exception {
      throw InfluencerActionFailed();
    }
  }
}

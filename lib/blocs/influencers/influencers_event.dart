part of 'influencers_bloc.dart';

@immutable
abstract class InfluencersEvent extends Equatable {
  const InfluencersEvent();
  @override
  List<Object> get props => [];
}

class LoadInfluencers extends InfluencersEvent {}

class InfluencersLoadSuccess extends InfluencersEvent {
  final List<Influencer> influencers;
  const InfluencersLoadSuccess({this.influencers});

  @override
  List<Object> get props => [influencers];
}

class InfluencersCreate extends InfluencersEvent {
  final Influencer influencer;
  const InfluencersCreate({this.influencer});

  @override
  List<Object> get props => [influencer];
}

class InfluencerCreateSuccess extends InfluencersEvent {}

class InfluencerCreateSocialMedia extends InfluencersEvent {
  final String influencerId;
  final SocialMedia socialMedia;
  const InfluencerCreateSocialMedia({this.socialMedia, this.influencerId});

  @override
  List<Object> get props => [socialMedia, influencerId];
}

class InfluencerSocialMediaCreated extends InfluencersEvent {}

class InfluencersLoadInfluencer extends InfluencersEvent {
  final String influencerId;
  InfluencersLoadInfluencer({this.influencerId});

  @override
  // TODO: implement props
  List<Object> get props => [influencerId];
}

class InfluencerLoadSuccess extends InfluencersEvent {
  final Influencer influencer;
  InfluencerLoadSuccess({this.influencer});

  @override
  // TODO: implement props
  List<Object> get props => [influencer];
}

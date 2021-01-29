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

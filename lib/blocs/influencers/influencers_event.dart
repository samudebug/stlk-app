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

part of 'influencers_bloc.dart';

@immutable
abstract class InfluencersState extends Equatable {
  const InfluencersState();
  @override
  List<Object> get props => [];
}

class InfluencersInitial extends InfluencersState {}

class InfluencersLoading extends InfluencersState {}

class InfluencersLoaded extends InfluencersState {
  final List<Influencer> influencers;

  const InfluencersLoaded({this.influencers});

  InfluencersLoaded copyWith({List<Influencer> influencers}) {
    return InfluencersLoaded(influencers: influencers ?? this.influencers);
  }

  @override
  List<Object> get props => [influencers];

  @override
  String toString() {
    // TODO: implement toString
    return "InfluencersLoaded: {influencers: ${influencers.length}}";
  }
}
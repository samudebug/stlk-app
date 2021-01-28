import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:influencer_repository/influencer_repository.dart';
import 'package:meta/meta.dart';

part 'influencers_event.dart';
part 'influencers_state.dart';

class InfluencersBloc extends Bloc<InfluencersEvent, InfluencersState> {
  InfluencersBloc({@required this.influencerRepository})
      : assert(influencerRepository != null),
        super(InfluencersInitial());

  InfluencerRepository influencerRepository;

  @override
  Stream<InfluencersState> mapEventToState(
    InfluencersEvent event,
  ) async* {
    final currentState = state;
    if (event is LoadInfluencers) {
      yield InfluencersLoading();
      fetchInfluencers();
      return;
    }
    if (event is InfluencersLoadSuccess) {
      yield InfluencersLoaded(influencers: event.influencers);
    }
  }

  Future<void> fetchInfluencers() async {
    List<Influencer> result = await influencerRepository.getInfluencers();
    add(InfluencersLoadSuccess(influencers: result));
  }
}

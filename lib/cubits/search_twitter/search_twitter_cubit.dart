import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:influencer_repository/influencer_repository.dart';

part 'search_twitter_state.dart';

class SearchTwitterCubit extends Cubit<SearchTwitterState> {
  TextEditingController query;
  InfluencerRepository _influencerRepository;
  SearchTwitterCubit({InfluencerRepository influencerRepository})
      : query = TextEditingController(),
        _influencerRepository = influencerRepository,
        super(SearchTwitterInitial());

  void queryChanged(String value) async {
    print("changed");
    query.text = value;
    emit(SearchTwitterLoading());
    fetchResults(query.text);
  }

  void fetchResults(String handle) async {
    List<TwitterProfile> result =
        await _influencerRepository.searchTwitterProfile(handle);
    emit(SearchTwitterLoaded(result));
  }
}

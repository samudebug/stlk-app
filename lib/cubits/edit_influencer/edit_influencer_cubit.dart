import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:influencer_repository/influencer_repository.dart';

part 'edit_influencer_state.dart';

class EditInfluencerCubit extends Cubit<EditInfluencerState> {
  final Influencer influencer;

  EditInfluencerCubit(this.influencer)
      : super(EditInfluencerState(
            influencer: influencer,
            name: TextEditingController(text: influencer.name),
            tags: influencer.tags));

  void nameChanged(String value) {
    state.name.text = value;
    emit(EditInfluencerState());
  }

  void tagsChanged(List<String> values) {
    emit(state.copyWith(tags: values));
  }
}

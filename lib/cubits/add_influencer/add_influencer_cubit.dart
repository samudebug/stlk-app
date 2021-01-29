import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:stlk/models/add_influencer_form/name.dart';

part 'add_influencer_state.dart';

class AddInfluencerCubit extends Cubit<AddInfluencerState> {
  AddInfluencerCubit() : super(AddInfluencerState(tags: List()));

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(name: name, status: Formz.validate([name])));
  }

  void tagsChanged(List<String> values) {
    emit(state.copyWith(tags: values, status: Formz.validate([state.name])));
  }
}

part of 'add_influencer_cubit.dart';

class AddInfluencerState extends Equatable {
  const AddInfluencerState(
      {this.name = const Name.pure(),
      this.tags,
      this.status = FormzStatus.pure});

  final Name name;
  final List<String> tags;
  final FormzStatus status;

  @override
  List<Object> get props => [name, tags, status];

  AddInfluencerState copyWith(
      {Name name, List<String> tags, FormzStatus status}) {
    return AddInfluencerState(
        name: name ?? this.name,
        tags: tags ?? this.tags,
        status: status ?? this.status);
  }
}

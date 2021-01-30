part of 'edit_influencer_cubit.dart';

class EditInfluencerState extends Equatable {
  final Influencer influencer;
  final TextEditingController name;
  final List<dynamic> tags;
  const EditInfluencerState({this.influencer, this.name, this.tags});

  EditInfluencerState copyWith(
      {Influencer influencer, TextEditingController name, List<String> tags}) {
    return EditInfluencerState(
        influencer: influencer ?? this.influencer,
        name: name ?? this.name,
        tags: tags ?? this.tags);
  }

  @override
  List<Object> get props => [influencer, name, tags];
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:influencer_repository/influencer_repository.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:stlk/blocs/influencers/influencers_bloc.dart';
import 'package:stlk/components/edit_social_media_list.dart';
import 'package:stlk/cubits/edit_influencer/edit_influencer_cubit.dart';

class EditInfluencerPage extends StatelessWidget {
  final Influencer influencer;
  EditInfluencerPage({@required this.influencer});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditInfluencerCubit(influencer),
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: (influencer.socialMedias != null &&
                          influencer.socialMedias.length > 0
                      ? CircleAvatar(
                          backgroundColor: Color(0xFFC4C4C4),
                          backgroundImage: NetworkImage(
                              influencer.socialMedias[0].profilePicUrl),
                        )
                      : DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            color: Color(0xFFC4C4C4),
                          ),
                        )),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 200,
                child: BlocBuilder<EditInfluencerCubit, EditInfluencerState>(
                  buildWhen: (previous, current) =>
                      previous.name.text != current.name.text,
                  builder: (context, state) {
                    return TextField(
                        controller: state.name,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          context
                              .read<EditInfluencerCubit>()
                              .nameChanged(value);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: "Nome",
                        ));
                  },
                ),
              ),
            ),
            BlocBuilder<EditInfluencerCubit, EditInfluencerState>(
              builder: (context, state) {
                List<String> initalValue = List.castFrom(influencer.tags);
                return MultiSelectFormField(
                  autovalidate: false,
                  title: Text(
                    "Tags",
                    style: TextStyle(fontSize: 16),
                  ),
                  dataSource: [
                    {"display": "Youtuber", "value": "Youtuber"},
                    {"display": "Streamer", "value": "Streamer"},
                    {"display": "Influencer", "value": "Influencer"},
                  ],
                  textField: "display",
                  valueField: "value",
                  okButtonLabel: "OK",
                  cancelButtonLabel: "Cancelar",
                  hintWidget: Text("O que ele/ela é?"),
                  initialValue: initalValue,
                  onSaved: (values) {
                    List<String> newTags = List.castFrom(values);
                    context.read<EditInfluencerCubit>().tagsChanged(newTags);
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Mídias Sociais",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: EditSocialMediaList(influencer),
            )
            // Expanded(
            //     child: SocialMediaList(
            //   socialMedias: influencer.socialMedias,
            // ))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:influencer_repository/influencer_repository.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:stlk/blocs/influencers/influencers_bloc.dart';
import 'package:stlk/cubits/add_influencer/add_influencer_cubit.dart';
import 'package:formz/formz.dart';
import 'package:stlk/cubits/login/login_cubit.dart';
import 'package:stlk/pages/home_page.dart';

class AddInfluencerPage extends StatelessWidget {
  AddInfluencerCubit cubit = AddInfluencerCubit();
  InfluencersBloc influencersBloc;
  AddInfluencerPage({this.influencersBloc});
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        floatingActionButton:
            BlocBuilder<AddInfluencerCubit, AddInfluencerState>(
          builder: (context, state) {
            return FloatingActionButton(
              child: Icon(Icons.save),
              onPressed: () {
                print(state.name.value);
                if (state.name.value.isNotEmpty) {
                  Influencer newInfluencer =
                      Influencer(name: state.name.value, tags: state.tags);
                  influencersBloc
                      .add(InfluencersCreate(influencer: newInfluencer));
                }
              },
            );
          },
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: BlocListener(
              cubit: influencersBloc,
              listener: (context, state) {
                if (state is InfluencersCreated) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (route) => false);
                }
              },
              child: _loginForm(),
            )
            // child: _loginForm(),
            ),
      ),
    );
  }

  Widget _loginForm() {
    const tagOptions = ['Youtuber', 'Streamer', 'Influencer'];
    return BlocListener<AddInfluencerCubit, AddInfluencerState>(
      listener: (context, state) {
        print(state);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xFFC4C4C4),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 200,
              child: BlocBuilder<AddInfluencerCubit, AddInfluencerState>(
                buildWhen: (previous, current) => previous.name != current.name,
                builder: (context, state) {
                  return TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      context.read<AddInfluencerCubit>().nameChanged(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      hintText: "Nome",
                    ),
                  );
                },
              ),
            ),
          ),
          BlocBuilder<AddInfluencerCubit, AddInfluencerState>(
            builder: (context, state) {
              return MultiSelectFormField(
                autovalidate: false,
                title: Text("Tags"),
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
                onSaved: (values) {
                  List<String> newTags = List.castFrom(values);
                  context.read<AddInfluencerCubit>().tagsChanged(newTags);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

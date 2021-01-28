import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:influencer_repository/influencer_repository.dart';
import 'package:stlk/blocs/influencers/influencers_bloc.dart';
import 'package:stlk/components/influencer_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => InfluencersBloc(
            influencerRepository: context.read<InfluencerRepository>())
          ..add(LoadInfluencers()),
        child: _body(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<InfluencersBloc, InfluencersState>(
      builder: (context, state) {
        if (state is InfluencersInitial) {
          return Container();
        }
        if (state is InfluencersLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is InfluencersLoaded) {
          if (state.influencers.isEmpty) {
            return Center(
              child: Text("Nenhum salvo até agora"),
            );
          } else {
            return ListView.builder(
              itemCount: state.influencers.length,
              itemBuilder: (context, index) {
                return InfluencerCard();
              },
            );
          }
        }
        return Container();
      },
    );
  }
}

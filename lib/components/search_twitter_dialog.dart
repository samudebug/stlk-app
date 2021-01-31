import 'package:flutter/material.dart';
import 'package:influencer_repository/influencer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stlk/cubits/search_twitter/search_twitter_cubit.dart';

class SearchTwitterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Procurar perfil"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => SearchTwitterCubit(
            influencerRepository: context.read<InfluencerRepository>()),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<SearchTwitterCubit, SearchTwitterState>(
        builder: (context, state) {
      return Column(
        children: [
          ListTile(
            leading: Icon(Icons.search),
            title: TextField(
              // controller: context.read<SearchTwitterCubit>().query,
              decoration: InputDecoration(hintText: "Pesquise"),
              onChanged: (value) {
                context.read<SearchTwitterCubit>().queryChanged(value);
              },
            ),
          ),
          if (state is SearchTwitterInitial)
            Expanded(
                child: Center(
              child: Text("Digite na caixa para pesquisar"),
            ))
          else if (state is SearchTwitterLoading)
            Expanded(
                child: Center(
              child: CircularProgressIndicator(),
            ))
          else if (state is SearchTwitterLoaded)
            Expanded(
              child: ListView.builder(
                itemCount: state.results.length,
                itemBuilder: (context, index) =>
                    TwitterProfileCard(state.results[index]),
              ),
            )
        ],
      );
    });
  }
}

class TwitterProfileCard extends StatelessWidget {
  final TwitterProfile profile;
  TwitterProfileCard(this.profile);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Card(
        child: InkWell(
          onTap: () {
            SocialMedia socialMedia = SocialMedia(
                name: profile.name,
                handle: profile.handle,
                uid: profile.id,
                profilePicUrl: profile.profilePicUrl,
                socialMediaName: "twitter");
            Navigator.of(context).pop(socialMedia);
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFC4C4C4),
                      backgroundImage: NetworkImage(profile.profilePicUrl),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.name, style: TextStyle(fontSize: 24)),
                        Text(
                          "@${profile.handle}",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(profile.description,
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

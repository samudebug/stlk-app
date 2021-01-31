import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:influencer_repository/influencer_repository.dart';
import 'package:stlk/blocs/influencers/influencers_bloc.dart';
import 'package:stlk/components/search_twitter_dialog.dart';

class EditSocialMediaList extends StatelessWidget {
  final Influencer influencer;
  EditSocialMediaList(this.influencer);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<InfluencersBloc>(
      create: (context) => InfluencersBloc(
          influencerRepository: context.read<InfluencerRepository>())
        ..add(InfluencersLoadInfluencer(influencerId: influencer.id)),
      child: BlocListener<InfluencersBloc, InfluencersState>(
        listener: (context, state) {
          if (state is InfluencerCreateSocialMediaSuccess) {
            context
                .read<InfluencersBloc>()
                .add(InfluencersLoadInfluencer(influencerId: influencer.id));
          }
        },
        child: BlocBuilder<InfluencersBloc, InfluencersState>(
          buildWhen: (previous, current) =>
              !(current is InfluencerCreateSocialMediaSuccess),
          builder: (context, state) {
            if (state is InfluencerLoaded) {
              Influencer currInfluencer = state.influencer;
              return Column(
                children: [
                  (state.influencer.socialMedias != null &&
                          state.influencer.socialMedias.length > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            child: ListView.builder(
                                itemCount: state.influencer.socialMedias.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return EditSocialMediaCard(
                                      socialMedia:
                                          state.influencer.socialMedias[index]);
                                }),
                          ),
                        )
                      : Container()),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          InfluencersBloc bloc =
                              context.read<InfluencersBloc>();
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  child: Wrap(
                                    children: [
                                      ListTile(
                                        leading: SvgPicture.asset(
                                          "assets/twitter-icon.svg",
                                          height: 24,
                                        ),
                                        title: Text("Twitter"),
                                        onTap: () async {
                                          SocialMedia result =
                                              await Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          SearchTwitterDialog(),
                                                      fullscreenDialog: true));
                                          bloc.add(InfluencerCreateSocialMedia(
                                              influencerId: currInfluencer.id,
                                              socialMedia: result));
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  )
                ],
              );
            }
            if (state is InfluencerLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class EditSocialMediaCard extends StatelessWidget {
  final SocialMedia socialMedia;
  EditSocialMediaCard({@required this.socialMedia});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Stack(
          children: [
            Padding(
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
                        backgroundImage:
                            NetworkImage(socialMedia.profilePicUrl),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (socialMedia.socialMediaName != 'youtube' ||
                                    socialMedia.socialMediaName != 'twitch'
                                ? Text(
                                    "@${socialMedia.handle}",
                                    style: TextStyle(fontSize: 24),
                                  )
                                : Text(
                                    socialMedia.handle,
                                    style: TextStyle(fontSize: 24),
                                  )),
                            Text(
                                "${socialMedia.socialMediaName[0].toUpperCase()}${socialMedia.socialMediaName.substring(1)}",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0x80000000)))
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {},
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:influencer_repository/influencer_repository.dart';
import 'package:stlk/components/social_media_list.dart';
import 'package:stlk/pages/edit_influencer_page.dart';

class InfluencerDetails extends StatelessWidget {
  final Influencer influencer;
  const InfluencerDetails({@required this.influencer});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => EditInfluencerPage(influencer: influencer)));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Hero(
                  tag: "influencer icon_${influencer.id}",
                  child: Material(
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
              ),
            ),
            Center(
              child: Container(
                width: 200,
                child: Text(influencer.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22)),
              ),
            ),
            Center(
              child: Wrap(
                children: influencer.tags
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Chip(label: Text(e)),
                        ))
                    .toList(),
              ),
            ),
            Expanded(
                child: SocialMediaList(
              socialMedias: influencer.socialMedias,
            ))
          ],
        ),
      ),
    );
  }
}

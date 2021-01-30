import 'package:flutter/material.dart';
import 'package:influencer_repository/influencer_repository.dart';

class EditSocialMediaList extends StatelessWidget {
  final List<SocialMedia> socialMedias;
  EditSocialMediaList(this.socialMedias);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (socialMedias != null
            ? ListView.builder(
                itemCount: socialMedias.length,
                itemBuilder: (context, index) {
                  return EditSocialMediaCard(socialMedia: socialMedias[index]);
                })
            : Container()),
        Center(
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
          ),
        )
      ],
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
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Color(0xFFC4C4C4),
                        ),
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
                            Text(
                              socialMedia.handle,
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                                "${socialMedia.name.toUpperCase()}${socialMedia.name.substring(1)}",
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
                child: IconButton(icon: Icon(Icons.clear), onPressed: () {}))
          ],
        ),
      ),
    );
  }
}

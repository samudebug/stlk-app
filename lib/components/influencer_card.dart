import 'package:flutter/material.dart';
import 'package:influencer_repository/influencer_repository.dart';
import 'package:stlk/pages/influencer_details_page.dart';

class InfluencerCard extends StatelessWidget {
  Influencer influencer;
  InfluencerCard({@required this.influencer});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: InkWell(
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => InfluencerDetails(influencer: influencer)))
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: Hero(
                      tag: "influencer icon_${influencer.id}",
                      child: Material(
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
                    )),
                Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            influencer.name,
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(influencer.tags.join(", "),
                              style: TextStyle(
                                  fontSize: 14, color: Color(0x80000000)))
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

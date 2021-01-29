import 'package:flutter/material.dart';
import 'package:influencer_repository/influencer_repository.dart';

class InfluencerCard extends StatelessWidget {
  Influencer influencer;
  InfluencerCard({@required this.influencer});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Color(0xFFC4C4C4),
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
    );
  }
}

import './social_media.dart';

import 'social_media.dart';

class Influencer {
  String name;
  List<String> tags;
  List<SocialMedia> socialMedias;

  Influencer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tags = json['tags'].map((item) => item).toList();
    socialMedias = json['social_medias']
        .map((item) => SocialMedia.fromJson(item))
        .toList();
  }
}

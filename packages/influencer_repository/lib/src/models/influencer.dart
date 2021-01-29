import './social_media.dart';

import 'social_media.dart';

class Influencer {
  String name;
  List<dynamic> tags;
  List<SocialMedia> socialMedias;

  Influencer({this.name, this.tags, this.socialMedias});

  Influencer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tags = json['tags'].map((item) => item.toString()).toList();
    if (json['social_medias'] != null) {
      socialMedias = json['social_medias']
          .map((item) => SocialMedia.fromJson(item))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "tags": tags};
  }
}

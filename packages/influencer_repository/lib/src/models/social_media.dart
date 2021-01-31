class SocialMedia {
  String socialMediaName;
  String name;
  String handle;
  String uid;
  String profilePicUrl;

  SocialMedia(
      {this.name,
      this.handle,
      this.uid,
      this.profilePicUrl,
      this.socialMediaName});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    socialMediaName = json['social_media_name'];
    name = json['name'];
    handle = json['handle'];
    uid = json['uid'];
    profilePicUrl = json['profile_pic_url'];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "handle": handle,
      "uid": uid,
      "profile_pic_url": profilePicUrl,
      "social_media_name": socialMediaName
    };
  }
}

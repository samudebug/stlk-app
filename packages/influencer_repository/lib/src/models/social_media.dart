class SocialMedia {
  String name;
  String handle;
  String uid;

  SocialMedia.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    handle = json['handle'];
    uid = json['uid'];
  }
}

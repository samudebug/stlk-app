class TwitterProfile {
  String id;
  String name;
  String description;
  String handle;
  String profilePicUrl;

  TwitterProfile.fromJson(Map json) {
    id = json['id'];
    handle = json['handle'];
    name = json['name'];
    description = json['description'];
    profilePicUrl = json['profile_image_url'];
  }
}

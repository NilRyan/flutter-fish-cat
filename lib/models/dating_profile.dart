
import 'celebrity_profile.dart';

class DatingProfile {
  String imageUrl;
  String name;
  String age;
  String aboutMe;
  List<CelebrityProfile> celebrityLookAlikes;

  DatingProfile({required this.imageUrl, required this.name, required this.age, required this.aboutMe, required this.celebrityLookAlikes});

  factory DatingProfile.fromJson(Map<String, dynamic> json) => DatingProfile(
    imageUrl: json["imageUrl"],
    name: json["name"],
    age: json["age"],
    aboutMe: json["aboutMe"],
    celebrityLookAlikes: List<CelebrityProfile>.from(json["celebrityLookAlikes"].map((x) => CelebrityProfile.fromJson(x))),
  );

}

import 'celebrity_profile.dart';
import 'gender.dart';

class DatingProfile {
  String userId;
  String imageUrl;
  String name;
  DateTime birthDay;
  String aboutMe;
  List<CelebrityProfile> celebrityLookAlikes;
  Gender gender;

  DatingProfile({required this.userId, required this.imageUrl, required this.name, required this.birthDay, required this.aboutMe, required this.celebrityLookAlikes, required this.gender});

  factory DatingProfile.fromJson(Map<String, dynamic> json) => DatingProfile(
    userId: json["userId"],
    imageUrl: json["imageUrl"],
    name: json["name"],
    birthDay: DateTime.parse(json["birthDay"]),
    aboutMe: json["aboutMe"],
    celebrityLookAlikes: List<CelebrityProfile>.from(json["celebrityLookAlikes"].map((celeb) => CelebrityProfile.fromJson(celeb))),
    gender: json["gender"] as Gender
  );

}
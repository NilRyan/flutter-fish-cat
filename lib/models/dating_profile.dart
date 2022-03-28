
import 'celebrity_profile.dart';
import 'gender.dart';

class DatingProfile {
  String userId;
  String imageUrl;
  String name;
  DateTime birthDate;
  String aboutMe;
  List<CelebrityProfile> celebrityLookAlikes;
  Gender gender;

  DatingProfile({required this.userId, required this.imageUrl, required this.name, required this.birthDate, required this.aboutMe, required this.celebrityLookAlikes, required this.gender});

  int get age {
    DateTime dateToday = DateTime.now();

    if (dateToday.month > birthDate.month
        || (dateToday.month == birthDate.month && dateToday.day >= birthDate.day) ) {
      return dateToday.year - birthDate.year;
    }
    return dateToday.year - birthDate.year - 1;
  }
  factory DatingProfile.fromJson(Map<String, dynamic> json) => DatingProfile(
    userId: json["userId"],
    imageUrl: json["imageUrl"],
    name: json["name"],
    birthDate: DateTime.parse(json["birthDay"]),
    aboutMe: json["aboutMe"],
    celebrityLookAlikes: List<CelebrityProfile>.from(json["celebrityLookAlikes"].map((celeb) => CelebrityProfile.fromJson(celeb))),
    gender: genderFromString(json["gender"])
  );

}
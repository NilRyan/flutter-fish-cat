
class CelebrityProfile {
  double lookAlikePercentage;
  String name;
  String celebrityId;
  String imageUrl;

  CelebrityProfile({
    required this.lookAlikePercentage,
    required this.name,
    required this.celebrityId,
    required this.imageUrl,
  });

  factory CelebrityProfile.fromJson(Map<String, dynamic> json) => CelebrityProfile(
    lookAlikePercentage: json["lookAlikePercentage"].toDouble(),
    name: json["name"],
    celebrityId: json["celebrityId"],
    imageUrl: json["imageUrl"],
  );

}

import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/models.dart';

class MockDatingProfileService {
  Future<List<DatingProfile>> getDatingProfiles() async {

    await Future.delayed(const Duration(milliseconds: 1000));

    final dataString = await _loadJsonFile('assets/sample_data/dating_profiles.json');

    final data = json.decode(dataString);
    final profiles = <DatingProfile>[];
    data.forEach((profile) {
      profiles.add(DatingProfile.fromJson(profile));
    });
    return profiles;
  }

  Future<String> _loadJsonFile(String fileName) async {
    return rootBundle.loadString(fileName);
  }
}
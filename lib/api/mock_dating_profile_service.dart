
import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/models.dart';

class MockDatingProfileService {
  MockDatingProfileService();
  Future<List<DatingProfile>> getDatingProfiles(String id) async {

    await Future.delayed(const Duration(milliseconds: 1000));

    // Load json file from disk
    final dataString = await _loadJsonFile('lib/assets/sample_data/dating_profiles.json');

    final List<dynamic> data = json.decode(dataString);

    return data.map((json) => DatingProfile.fromJson(json)).toList();
  }

  Future<String> _loadJsonFile(String fileName) async {
    return await rootBundle.loadString(fileName);
  }
}
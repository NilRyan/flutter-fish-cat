import 'package:flutter/material.dart';

import '../../api/mock_dating_profile_service.dart';
import '../../models/models.dart';

class MatchesView extends StatelessWidget {
  MatchesView({Key? key}) : super(key: key);

  final mockDatingProfileService = MockDatingProfileService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: mockDatingProfileService.getDatingProfiles(),
        builder: (context, AsyncSnapshot<List<DatingProfile>> snapshot) {
          // TODO: fix not getting data
          if (snapshot.hasData) {
            return GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 4/5), itemCount: snapshot.data?.length, itemBuilder: (context, index) {
              var datingProfile = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(datingProfile.imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(datingProfile.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 10),
                            Text(datingProfile.age.toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
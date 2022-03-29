import 'package:fish_cat/models/dating_profile.dart';
import 'package:flutter/material.dart';

import '../api/mock_dating_profile_service.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _index = 0;

  List<Widget> _buildItems = [
      Container(
        color: Colors.red,
        child: Text('Find Matches'),
      ),
    MatchesView(),

      Container(
        color: Colors.blue,
        child: Text('Messages'),
      ),
      Container(
        color: Colors.yellow,
        child: Text('My Profile and Settings'),
      ),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildItems[_index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: 'Find Match',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'
          ),
        ],
        unselectedItemColor: Colors.grey,
        elevation: 8,
        selectedItemColor: Colors.pink[800],
        currentIndex: _index,
        onTap: (int index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}

class MatchesView extends StatelessWidget {
  MatchesView({Key? key}) : super(key: key);

  final mockDatingProfileService = MockDatingProfileService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: mockDatingProfileService.getDatingProfiles(),
        builder: (context, AsyncSnapshot<List<DatingProfile>> snapshot) {
          // TODO: fix not getting data
          if (snapshot.hasData) {
            return GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 4/5), itemBuilder: (context, index) {
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
                  child: Stack(

                  )
                ),
              );
            });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}




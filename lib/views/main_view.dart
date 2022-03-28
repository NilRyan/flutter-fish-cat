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

class MatchesView extends StatefulWidget {
  const MatchesView({Key? key}) : super(key: key);

  @override
  State<MatchesView> createState() => _MatchesViewState();
}

class _MatchesViewState extends State<MatchesView> {
  final mockDatingProfileService = MockDatingProfileService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: mockDatingProfileService.getDatingProfiles(),
            builder: (context, AsyncSnapshot<List<DatingProfile>> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data![index].imageUrl),
                    ),
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].age.toString()),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

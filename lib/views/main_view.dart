import 'package:fish_cat/models/dating_profile.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../api/mock_dating_profile_service.dart';
import 'main_view/matches_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _index = 0;

  List<Widget> _buildItems = [
      SwipeView(),
    MatchesView(),
      Container(
        color: Colors.blue,
        child: const Text('Messages'),
      ),
      Container(
        color: Colors.yellow,
        child: const Text('My Profile and Settings'),
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

class SwipeView extends StatelessWidget {
  final _datingProfileService = MockDatingProfileService();
  SwipeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, AsyncSnapshot<List<DatingProfile>> snapshot) {
      if (snapshot.hasData) {
        final profiles = snapshot.data;
        return SwipableStack(builder: (context, properties) {
          // TODO: implement api integration on swipe
          var datingProfile = profiles![properties.index];
          return Container(
            margin: const EdgeInsets.only(
              top: 100,
              left: 16,
              right: 16,
              bottom: 16
            ),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(datingProfile.imageUrl),
                fit: BoxFit.fill,
          ),
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(datingProfile.name + ',', style: const TextStyle(fontSize: 25, color: Colors.white)),
                      const SizedBox(width: 10),
                      Text(datingProfile.age.toString(), style: const TextStyle(fontSize: 25, color: Colors.white)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [

                      Text('Philip John Calape - 60%', style: TextStyle(fontSize: 15, color: Colors.white)),
                      Text('John Lloyd Cruz - 95%', style: TextStyle(fontSize: 15, color: Colors.white)),
                      Text('Meowth - 10%', style: TextStyle(fontSize: 15, color: Colors.white)),
                    ],
                  ),
                )

              ],
            ),
          );
        },
        itemCount: profiles!.length,
        onSwipeCompleted: (index, direction) {
          print('$index $direction');
        },
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }, future: _datingProfileService.getDatingProfiles());
  }
}






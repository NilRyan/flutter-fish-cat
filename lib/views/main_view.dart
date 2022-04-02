
import 'package:fish_cat/models/dating_profile.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../api/mock_dating_profile_service.dart';
import 'main_view/matches_view.dart';
import 'main_view/profile_view.dart';
import 'main_view/swipe_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _index = 0;

  final List<Widget> _buildItems = [
      SwipeView(),
    MatchesView(),
      Container(
        color: Colors.blue,
        child: const Text('Messages'),
      ),
      const ProfileView(),
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











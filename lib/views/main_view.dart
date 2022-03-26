import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  List<Widget> _buildItems() {
    return [
      Container(
        color: Colors.red,
        child: Text('Find Matches'),
      ),
      Container(
        color: Colors.green,
        child: Text('Matches'),
      ),
      Container(
        color: Colors.blue,
        child: Text('Messages'),
      ),
      Container(
        color: Colors.yellow,
        child: Text('My Profile and Settings'),
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main View'),
      ),
      body: Center(
        child: Text('Main View'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text('Profile Details'),
        Column(
          children: const [
            Text('Name'),
            Text('Age'),
            Text('Location'),
            Text('About Me'),
          ],
        ),
        SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            }, child: const Text('Logout'),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

import 'views/login_view.dart';
import 'views/register_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(),
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
      },
    );
  }
}







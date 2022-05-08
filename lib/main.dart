import 'package:fish_cat/graphql/graphql_view.dart';
import 'package:fish_cat/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'views/intro_view.dart';
import 'views/login_view.dart';
import 'views/main_view.dart';
import 'views/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO: make backend an env variable and add separate subscription endpoint
    return ClientProvider(
      uri: 'https://nestjs-fish-cat.herokuapp.com/graphql',
      subscriptionUri: 'https://nestjs-fish-cat.herokuapp.com/graphql',
      child: MaterialApp(
        title: 'FishCat Dating App',
        theme: ThemeData(
          primarySwatch: Colors.pink,

        ),
        home: SecureStorage.tokenExists() ? const MainView() : IntroView(),
        routes: {
          LoginView.routeName: (context) =>  LoginView(),
          RegisterView.routeName: (context) => RegisterView(),
          MainView.routeName: (context) => const MainView(),
        },
      ),
    );
  }
}










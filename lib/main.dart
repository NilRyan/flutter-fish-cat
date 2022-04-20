import 'package:fish_cat/graphql/graphql_view.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'views/login_view.dart';
import 'views/main_view.dart';
import 'views/register_view.dart';

void main() {
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
        home: IntroView(),
        routes: {
          '/login': (context) => const LoginView(),
          '/register': (context) => const RegisterView(),
          '/main': (context) => const MainView(),
        },
      ),
    );
  }
}

class IntroView extends StatelessWidget {
  IntroView({Key? key}) : super(key: key);

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }


  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Find your soul mate",
          body: "Join us and find someone",
          image: const Padding(
            padding: EdgeInsets.only(top: 150.0),
            child: Center(child: Image(image: AssetImage('assets/images/streamline-icon-selfie.PNG'))),
          ),
        ),
        PageViewModel(
          title: "FishCat",
          body: "You can find people as handsome as Boss Philip John",
          image: const Padding(
            padding: EdgeInsets.only(top: 150.0),
            child: Center(
              child: Image(image: AssetImage('assets/images/streamline-icon-searching-network.PNG')),
            ),
          ),
          footer: ElevatedButton(
            onPressed: () => navigateToLogin(context),
            child: const Text("Start FishCat Journey"),
          ),
        ),
      ],
      onDone: () => navigateToLogin(context),
      showBackButton: false,
      showNextButton: false,
      showSkipButton: false,
      skip: const Icon(Icons.skip_next),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(10.0, 10.0),
          activeColor: Colors.pink,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)
          )
      ),
    );
  }
}








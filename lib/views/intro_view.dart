import 'package:fish_cat/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroView extends StatelessWidget {
  IntroView({Key? key}) : super(key: key);
  static const routeName = '/intro';

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, LoginView.routeName);
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
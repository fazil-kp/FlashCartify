import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../home_screen/home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  Future gotoLogin() async {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => LoginScreen()),
      );
    });
  }

  Future checkUserLoggedIn() async {
    final _sharedPref = await SharedPreferences.getInstance();
    _sharedPref.setBool(SAVE_KEY_NAME, true);
    final _userLoggedIn = _sharedPref.getBool(SAVE_KEY_NAME);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx1) => const ZomatoHomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/zomato_splash.png"),
              width: 300,
            ),
            SizedBox(
              height: 40,
            ),
            SpinKitFadingCircle(
              color: Colors.red,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

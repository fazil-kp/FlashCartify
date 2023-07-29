import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zomato_project/reusable_widget/color_utils.dart';
import 'package:zomato_project/reusable_widget/constants.dart';
import 'package:zomato_project/screens/splash_screen.dart';
import 'database/firebase_options.dart';


const SAVE_KEY_NAME = "UserLoggedIn";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zomato',
      theme: ThemeData(
          primarySwatch: MyColors.navy,
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xfffcfcfc),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: .2,
              titleTextStyle:  TextStyle(fontFamily: Bold , color: Color(0xff323232)),
              iconTheme: IconThemeData(color: MyColors.primaryColor)
          )
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: MyColors.navy,
          scaffoldBackgroundColor: const Color(0xfffcfcfc),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: .2,
              titleTextStyle:  TextStyle(fontFamily: Bold , color: Color(0xff323232)),
              iconTheme: IconThemeData(color: MyColors.primaryColor)
          )
      ),
      home: SplashScreen(),
    );
  }
}







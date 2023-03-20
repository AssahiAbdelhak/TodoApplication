
import 'package:flutter/material.dart';
import 'package:mynotes/screens/Home.dart';
import 'package:mynotes/screens/Profile.dart';
import 'package:mynotes/screens/SignIn.dart';
import 'package:mynotes/screens/SignUp.dart';
import 'package:mynotes/services/MainRouter.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: <String,WidgetBuilder>{
        '/signup': (BuildContext context) => const SignUp(),
        '/signin': (BuildContext contect) => const SignIn(),
        '/home':(context) => const Home(),
        '/profile':(context) => const Profile(),
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MainRouter(),
    );
  }
}

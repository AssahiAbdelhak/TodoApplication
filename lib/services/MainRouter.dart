
import 'package:flutter/material.dart';
import 'package:mynotes/screens/Home.dart';
import '../screens/SignIn.dart';
import '../screens/SplachScreen.dart';
import 'package:mynotes/services/AuthServices.dart';

class MainRouter extends StatefulWidget {
  const MainRouter({super.key});


  @override
  State<MainRouter> createState() => _MainRouterState();
}

class _MainRouterState extends State<MainRouter> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthServices.initFirebase(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return const SplachScreen();
        }
        else if(snapshot.connectionState==ConnectionState.done){
            if(AuthServices().user != null?false:true) {
              return const SignIn();
            }
            return const Home();
        }return const Center(child: Text('Null'),);
      },
      );
  }
}
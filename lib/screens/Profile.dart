import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile "),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
                  height: 100,
                  width: 100,
              child:
                Stack(
                  
                  children: [
                    ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/image.jpg'),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(onPressed: () {
                        // choose a picture from device
                      },icon: Icon(Icons.add_a_photo),color: Colors.white,),
          )]
                  
              ),
            ),
          ),
          ]
      ),
    );
  }
}
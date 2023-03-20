import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/models/User.dart';

import '../firebase_options.dart';

class AuthServices {
  User? get user => FirebaseAuth.instance.currentUser;

  static Future<FirebaseApp> initFirebase() async {
    return await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  }

  Future<AppUser?> createUserWithEmailAndPassword({required String email,required String password}) async{
      try{
        UserCredential usercred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        usercred.user?.sendEmailVerification();
        return AppUser.fromFirebaseAuth(usercred);
      }on FirebaseAuthException catch(_){
        rethrow;
      }
  }

  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
  }

  Future<AppUser?> connectUser({required BuildContext context,required String email,required String password}) async {
    try{
      UserCredential usercred =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if(! usercred.user!.emailVerified){
        return null;
      }
      return AppUser.fromFirebaseAuth(usercred);
      } on FirebaseAuthException catch(error){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(error.code)));
      
      return null;
    }
      
      
  }

}
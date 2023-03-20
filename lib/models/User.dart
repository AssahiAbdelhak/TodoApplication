import 'package:firebase_auth/firebase_auth.dart';

class AppUser{
  String? email;
  String? id;

  AppUser({required email,required id,});

  factory AppUser.fromFirebaseAuth(UserCredential user) => AppUser(email: user.user?.email!,id:user.user?.uid);

}
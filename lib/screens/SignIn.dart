// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mynotes/services/AuthServices.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  void initState() {
    super.initState();
    
  }
  
@override
void dispose() {
    super.dispose();
    _emailField.dispose();
    _passwordField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Title(color: Colors.black, child: const Text('Sign In',style: TextStyle(fontSize: 20,letterSpacing:2,wordSpacing: 5),)),
            TextField(
              controller: _emailField,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: null,
                prefixIcon: Icon(Icons.mail)
              ),
              
            ) ,
             TextField(
              controller: _passwordField,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: null,
                prefixIcon: Icon(Icons.lock)
              ),  
              ),
            TextButton(
              onPressed: () => signIn(context,_emailField,_passwordField),
              child : const Text('Login')
            ) , 
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/signup', (route) => false);
              },
              child : const Text('Don\'t have an account? Sign Up here')
            ) , 
          ],
        ),
      ),
    );
  }
  
  signIn(BuildContext context,TextEditingController emailField,TextEditingController passwordField) async {
      await AuthServices().connectUser(context: context,email: _emailField.text,password: _passwordField.text);
      _emailField.clear();
      _passwordField.clear();
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }
}
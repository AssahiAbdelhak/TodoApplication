import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/services/AuthServices.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

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
            Title(color: Colors.black, child: const Text('Sign Up',style: TextStyle(fontSize: 20,letterSpacing:2,wordSpacing: 5),)),
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
              onPressed: () => createAccount(context),
              child : const Text('Sign Up')
            ) , 
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
              },
              child : const Text('Already have an account? Sign In here')
            ) , 
          ],
        ),
      ),
    );
  }
  
  createAccount( BuildContext context) async {
    try{
      await AuthServices().createUserWithEmailAndPassword(email: _emailField.text, password: _passwordField.text);
      _emailField.clear();
      _passwordField.clear();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('We \'ve sent you an email verification please verify your email by clicking on the link in the email')));
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));
    }
    
  }
}

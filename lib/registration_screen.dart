import 'package:flutter/material.dart';
import 'package:flutter_app/login_screen.dart';
import 'rounded_button.dart';
import 'constants2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {

  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  final firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*backgroundColor: Colors.white,*/
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.jpg'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value;//Do something with the user input.
                      },
                      decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email.')
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value;//Do something with the user input.
                      },
                      decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password.')
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(title: 'Register',colour: Colors.blueAccent,onPressed: () async{
                    setState(() {
                      showSpinner = true;
                    });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if(newUser!=null){
                      Navigator.pushNamed(context, LoginScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }
                  catch(e){
                    print(e);
                  }
                 firestore.collection('reports').add({
                 'url': 'Not recorded yet',
                 'user': email});
                  },)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
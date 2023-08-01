import 'package:flutter/material.dart';
import 'package:flutter_app/profile_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'rounded_button.dart';
import 'constants2.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {

  static const String id = 'login_screen';

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  static String email;
  bool showSpinner = false;
  String password;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                      /*style: TextStyle(
                        color: Colors.red
                      ),*/
                      onChanged: (value) {
                        email = value;
                        //Do something with the user input.
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
                  RoundedButton(title: 'Log In',colour: Colors.lightBlueAccent,onPressed:

                      ()async{
                    setState(() {
                      showSpinner = true;
                    });
                    try{
                    final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if (user != null){
                      Navigator.pushNamedAndRemoveUntil(context, ProfileScreen.id,(_)=>false);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                    }
                    catch(e){
                      AlertDialog(
                          title: Text(e),
                          backgroundColor: Colors.white,
                          titleTextStyle: TextStyle(
                              color: Colors.black
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          )
                      );
                    }
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
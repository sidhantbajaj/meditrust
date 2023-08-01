import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'rounded_button.dart';

class WelcomeScreen extends StatefulWidget {

  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

 /* AnimationController controller;
  Animation animation;*/

  @override
  /*void initState() {

    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.jpg',width: 50.0,),
                      height: 60.0,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),

                     Padding(
                       padding: EdgeInsets.fromLTRB(50.0, 0.0, 20.0,0.0),
                       child: TypewriterAnimatedTextKit(
                        text: ['Meditrust'],
                        textStyle: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.lightGreen
                        ),
                    ),
                     ),

              SizedBox(
                height: 48.0,
              ),
              RoundedButton(title: 'Log In', colour: Colors.lightBlueAccent,onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);}),
              RoundedButton(title: 'Register', colour: Colors.blueAccent,onPressed: () {
                Navigator.pushNamed(context,RegistrationScreen.id);}),
            ],
          ),
        ),
        decoration: BoxDecoration( gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.red, Colors.yellow]))
      ),
    );
  }
}
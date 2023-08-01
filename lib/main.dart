import 'package:flutter/material.dart';
import 'package:flutter_app/tests_booked.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'welcome_screen.dart';
import 'profile_screen.dart';
import 'tests_booked.dart';
import 'main1.dart';
import 'package:provider/provider.dart';
import 'bloc_cart.dart';


void main() => runApp(LabSystem());

class LabSystem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartBloc>(
      builder: (context) => CartBloc(),
      child :MaterialApp(
      theme: ThemeData(

          brightness: Brightness.dark,
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
          accentColor: Colors.teal,
          textSelectionColor: Colors.black54,
          /*hintColor: Colors.yellow,*/
          /*cardColor: Colors.teal*/

      ),

      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id :(context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        TestsBooked.id: (context) => TestsBooked(),
        BMICalculator.id: (context)  => BMICalculator()
      },
      ));
  }
}

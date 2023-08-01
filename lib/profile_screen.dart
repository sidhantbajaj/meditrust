import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' as prefix0;
import 'main1.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/tests_booked.dart';
import 'package:flutter_app/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/get_report.dart';
import 'rounded_button.dart';
import 'package:flutter_app/dialogbox.dart';
import 'bloc_cart.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatefulWidget {

  static const String id = 'profile_screen';

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {

  String email = LoginScreenState.email;
  final _auth = FirebaseAuth.instance;
  static FirebaseUser loggedInUser;
  final firestore = Firestore.instance;
  bool reportsFlag = false;
  var reports;

  @override
  void initState() {
    super.initState();
    getCurrentUser();


  }

  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch(e){
      print(e);
    }
  }
  void getBookedTests(){

  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    int totalCount = 0;
    if (bloc.cart.length > 0) {
      totalCount = bloc.cart.values.reduce((a, b) => a + b);
    }

    return Scaffold(
        appBar:  AppBar(
          title: Text('Profile'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  'hello $email',
                  textAlign: TextAlign.justify,
                  textScaleFactor: 2.0,
                ),
                decoration: BoxDecoration(/*color: Color(0XFF4efff2)*/ gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue, Colors.red])),
              ),
               ListTile(
                 title: Text('Tests Booked'),
                 onTap:(){
                   Navigator.pushNamed(context, TestsBooked.id);
                 },
               ),
               ListTile(
                  title: Text("Log out"),
                  onTap: () {
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  },
              ),
            ],
          ),
        ),
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar:  AppBar(
              actions: <Widget>[],
              title:  TabBar(
                tabs: [
                   Tab(text: 'TESTS'),
                   Tab(text:'REPORTS'),
                   Tab(text: 'BMI Calc',),
                ],
                indicatorColor: Colors.white,
              ),
            ),
            body:  TabBarView(
              children: [
            ListView(
              shrinkWrap: true,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 150.0,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const ListTile(
                                  leading: Icon(Icons.local_hospital),
                                  title: Text('Platelets'),
                                  subtitle: Text('Price - Rs. 350'),
                                ),
                                ButtonTheme.bar( // make buttons use the appropriate styles for cards
                                  child: ButtonBar(
                                    children: <Widget>[
                                      FlatButton(
                                        child: const Text('ADD TEST'),
                                        onPressed: () {
                                          firestore.collection('tests').add({
                                            'tests': 'Platelets',
                                            'user': loggedInUser.email
                                          });
                                          int index = 1;
                                          bloc.addToCart(index);
                                          showDialog(context: context, builder: (_){return Dialogbox(test:'Platelets');});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                  Container(
                    height: 150.0,
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.local_hospital),
                              title: Text('Hemoglobin'),
                              subtitle: Text('Price - Rs. 280'),
                            ),
                            ButtonTheme.bar( // make buttons use the appropriate styles for cards
                              child: ButtonBar(
                                children: <Widget>[
                                  FlatButton(
                                    child: const Text('ADD TEST'),
                                    onPressed: () {
                                      firestore.collection('tests').add({
                                        'tests': 'Hemoglobin',
                                        'user': loggedInUser.email
                                      });
                                      int index = 2;
                                      bloc.addToCart(index);
                                      showDialog(context: context, builder: (_){return Dialogbox(test:'Hemoglobin');});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                      Container(
                        height: 150.0,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const ListTile(
                                  leading: Icon(Icons.local_hospital),
                                  title: Text('Creatinine'),
                                  subtitle: Text('Price - Rs. 200'),
                                ),
                                ButtonTheme.bar( // make buttons use the appropriate styles for cards
                                  child: ButtonBar(
                                    children: <Widget>[
                                      FlatButton(
                                        child: const Text('ADD TEST'),
                                        onPressed: () { firestore.collection('tests').add({
                                          'tests': 'Creatinine',
                                          'user': loggedInUser.email
                                        });
                                        int index = 3;
                                        bloc.addToCart(index);
                                        showDialog(context: context, builder: (_){return Dialogbox(test:'creatinine');});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 150.0,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const ListTile(
                                  leading: Icon(Icons.local_hospital),
                                  title: Text('Complete blood count'),
                                  subtitle: Text('Price - Rs. 800'),
                                ),
                                ButtonTheme.bar( // make buttons use the appropriate styles for cards
                                  child: ButtonBar(
                                    children: <Widget>[
                                      FlatButton(
                                        child: const Text('ADD TEST'),
                                        onPressed: () { firestore.collection('tests').add({
                                          'tests': 'complete blood count',
                                          'user': loggedInUser.email
                                        });
                                        int index = 4;
                                        bloc.addToCart(index);
                                        showDialog(context: context, builder: (_){return Dialogbox(test:'creatinine');});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 150.0,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const ListTile(
                                  leading: Icon(Icons.local_hospital),
                                  title: Text('HLA-B1'),
                                  subtitle: Text('Price - Rs. 320'),
                                ),
                                ButtonTheme.bar( // make buttons use the appropriate styles for cards
                                  child: ButtonBar(
                                    children: <Widget>[
                                      FlatButton(
                                        child: const Text('ADD TEST'),
                                        onPressed: () { firestore.collection('tests').add({
                                          'tests': 'HLA-B1',
                                          'user': loggedInUser.email
                                        });
                                        int index = 5;
                                        bloc.addToCart(index);
                                        showDialog(context: context, builder: (_){return Dialogbox(test:'creatinine');});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
              ]
            ),
                )
  ]),
             Container(
              child:  ListView(
                children: <Widget>[
                  (Reporting.buildBody(context))
                ])
             ),
                Container(
                  /*child: FlatButton(
                    child: Text('click for BMI calc'),
                    color: Colors.red[100],
                    onPressed: (){
                      Navigator.pushNamed(context, BMICalculator.id);
                    },
                  ),*/
                  child: Center(
                    child: RoundedButton(title: 'BMI Calc',colour: Colors.blueAccent,onPressed:(){
                      Navigator.pushNamed(context, BMICalculator.id);
                    }),
                  )
                )
              ],
            ),
          ),
        ));
  }
}

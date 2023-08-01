import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/pdf.dart';
import 'login_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class Reporting {
  static Widget buildBody(BuildContext context) {
    final db = Firestore.instance;
    String email = LoginScreenState.email;
    return Container(
      //height: 300,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.88,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 10,
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: db.collection('reports').where(
                  'user', isEqualTo: '$email').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  );
                } else {
                  return _buildList(context, snapshot.data.documents);
                  // String a = snapshot.data.documents.toString();
                  // return Text('hello $email $a');
                }
              }),
        ),
      ),
    );
  }

  static Widget _buildList(BuildContext context,
      List<DocumentSnapshot> snapshot) {
    return ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 60.0,
          maxHeight: 300.0,
        ),
        child: Container(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children:
            snapshot.map((data) => _buildListItem(context, data)).toList(),
          ),
        ));
  }

  static Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    Future launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url, forceWebView: false);
      }
      else {
        throw 'Cant launch $url';
      }
    }

    final record = Record.fromSnapshot(data);
    String urlPDF = record.test1;


    if ('Not recorded yet' == urlPDF ) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          'Not yet recorded',
          style: TextStyle(
            fontFamily: 'Bebas',
            fontSize: 25,
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
        //trailing: Text(''),
      );
    }
    else {
      return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Click here for reports',
            style: TextStyle(
              fontFamily: 'Bebas',
              fontSize: 25,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          //trailing: Text(''),
          onTap: () {
            launchURL(urlPDF);
            //Navigator.pushNamed(context, PDF.id);
          }
      );
    }
  }
}
class Record{
   String test1;

  //final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference}){
    if (map['url'] != null)
    test1 = map['url'];
    else if (map['url'] = null){
      print('reports have not been made yet');
    }
  }

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$test1>";

}




import 'package:flutter/material.dart';
import 'package:chainvoteweb/utilities/constants.dart';

class Ballot extends StatefulWidget {
  const Ballot({Key? key}) : super(key: key);

  @override
  _BallotState createState() => _BallotState();
}

class _BallotState extends State<Ballot> {
  String? candidateName;

  TextEditingController candidateNameContoller = TextEditingController();
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Printing Ballot"),
      content: Container(
        height: 500,
        width: 500,
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Text("${candidateNamesList[index]}");
            }),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List candidateNamesList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: SafeArea(
          child: Column(children: <Widget>[
            TextField(
              controller: candidateNameContoller,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: kTextFieldInputDecoration,
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    candidateNamesList.add(candidateNameContoller.text);
                  });
                  print(candidateNameContoller.text);
                  candidateNameContoller.clear();
                },
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 60.0),
                ),
              ),
              TextButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                child: Text(
                  'Print Ballot',
                  style: TextStyle(fontSize: 60.0),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}

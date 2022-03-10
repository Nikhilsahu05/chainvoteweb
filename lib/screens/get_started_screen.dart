import 'dart:html';

import 'package:chainvoteweb/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var dataOfCandidate;
  getCandidateData() async {
    firebaseFirestore.collection('adminCandidate').get().then((value) {
      setState(() {
        dataOfCandidate = value;
      });
      print(value);
      print(value.docs.length);
      print(value.docs[0]['age']);
    });
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future updateDatabase() async {
    await firebaseFirestore
        .collection('${auth.currentUser!.uid}')
        .doc("Email_information")
        .set({
      "email": auth.currentUser!.email,
      "isEmailVerified": auth.currentUser!.emailVerified,
    }).then((value) {
      print("success");
    }).catchError((onError) {
      print("${onError} Error on updateDatabse");
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget continueButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Confirm"),
      onPressed: () {
        Get.to(WelcomeScreen());
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
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

  @override
  void initState() {
    // updateDatabase();
    getCandidateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      // Expanded(
                      //   flex: 8,
                      //
                      // ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 35.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 60.0,
                                    right: 40,
                                  ),
                                  child: Icon(
                                    Icons.logout,
                                    size: 32,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showAlertDialog(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1.75,
                height: MediaQuery.of(context).size.height,
                color: Colors.grey.shade300,
              ),
              Expanded(
                flex: 8,
                child: Discription(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Discription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User Manual',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Welcome',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'These are few Guidelines for user:',
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Voting Process',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
            'Overall,voting process is divided into two phases.All of which will be initialized and terminated by the admin.User have to participate in the process according to current phase.'),
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: [
            Text(
              'Voting Phase:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
                'After initialization of voting phase from the admin,user can cast the vote in voting section.The casting of vote can be simply done by clicking on "VOTE" button,after which transaction will be initiated and after confirming transaction the vote will get successfully casted.After voting phase gets over user will not be able to vote.'),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          children: [
            Text(
              'Result Phase:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
                'This is the final stage of whole voting process during which the results of election will be displayed at "Result" section.')
          ],
        )
      ],
    ));
  }
}

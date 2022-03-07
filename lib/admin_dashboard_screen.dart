import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chainvoteweb/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _candidateName = TextEditingController();
  TextEditingController _party = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _qualification = TextEditingController();

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
        _auth.signOut();
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
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  updateToDatabase()async{
    _firebaseFirestore.collection('adminCandidate').doc("${_auth.currentUser?.uid}").set({
      'candidateName':_candidateName.text,
      'party':_party.text,
      'qualification':_qualification.text,
      'age':_age.text,
    }).catchError((onError){
      print(onError);
    });
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
                      Expanded(
                        flex: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 60.0, right: 40),
                                  child: Icon(
                                    Icons.info,
                                    size: 32,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Candidate Details',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 60.0, right: 40),
                                  child: Icon(
                                    Icons.person_add,
                                    size: 32,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Add Candidate',
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 60.0, right: 40),
                                  child: Icon(
                                    Icons.published_with_changes,
                                    size: 32,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Change State',
                                        style: TextStyle(fontSize: 16))),
                              ],
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            SizedBox(
                              height: 35,
                            ),
                          ],
                        ),
                      ),
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
                                    print("CLicked");
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
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Text('Add Candidate Info',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      ),
                      TextField(
                        controller: _candidateName,
                        decoration: InputDecoration(
                          hintText:'Name'
                        ),

                      ),
                      TextField(
                        controller: _party,
                        decoration: InputDecoration(
                          hintText:'Party'
                        ),

                      ),
                      TextField(
                        controller: _age,
                        decoration: InputDecoration(
                          hintText: 'Age',
                        ),

                      ),
                      TextField(
                        controller: _qualification,
                        decoration: InputDecoration(
                          hintText: 'Qualification',
                        ),

                      ),
                      ElevatedButton(onPressed: (){
                        updateToDatabase();
                      },
                          child: Text('Add',

                          ))
                    ],
                  ),
                ),

              ),
            ],
          ),
        ],
      ),
    );
  }
}


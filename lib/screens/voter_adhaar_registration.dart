import 'package:chainvoteweb/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoterRegisterationScreen extends StatefulWidget {
  @override
  State<VoterRegisterationScreen> createState() =>
      _VoterRegisterationScreenState();
}

class _VoterRegisterationScreenState extends State<VoterRegisterationScreen> {
  bool isFieldFilled = false;
  TextEditingController testingController1 = TextEditingController();
  TextEditingController testingController2 = TextEditingController();
  TextEditingController _adharController = TextEditingController();

  TextEditingController _privateController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text('$message'));
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  checkupdateDB() async {
    _firebaseFirestore
        .collection('VoterDetails')
        .where("email", isEqualTo: "${_auth.currentUser?.email}")
        .get()
        .then((value) {
      print(value.docs.length);
      for (var i = 0; i < value.docs.length; i++) {
        if (_adharController.text == "${value.docs[i]['aadhar']}") {
          print(value.docs[i]['age']);
          if (value.docs[i]['age'] >= 18) {
            print("Can vote");
            print(value.docs[i].id);

            _firebaseFirestore
                .collection('VoterDetails')
                .doc(value.docs[i].id)
                .update({
              'aadhar': value.docs[i]['aadhar'],
              'age': value.docs[i]['age'],
              'email': value.docs[i]['email'],
              'privateKey': _privateController.text,
              'registered': true,
            }).then((value) {
              Get.to(LoginScreen(testingController1, testingController2));
            }).catchError((onError) {
              print(onError);
            });
          } else {
            print("Can not vote");
            _displaySnackBar(
                context, "You are below 18, you are not allowed for voting.");
          }
        } else {
          _displaySnackBar(context, "Entered Aadhar number is incorrect.");
        }
      }
    });
  }

  @override
  void initState() {
    print(_auth.currentUser?.uid);
    print(_auth.currentUser?.displayName);
    print(_auth.currentUser?.email);
    print(_auth.currentUser?.emailVerified);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blue.shade200,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.65,
            child: Card(
              elevation: 18,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 75,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                        controller: _adharController,
                        onChanged: (_) {
                          if (_privateController.text.isNotEmpty &&
                              _adharController.text.isNotEmpty) {
                            setState(() {
                              isFieldFilled = true;
                            });
                          } else {
                            setState(() {
                              isFieldFilled = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Aadhar Number',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                        controller: _privateController,
                        onChanged: (_) {
                          if (_privateController.text.isNotEmpty &&
                              _adharController.text.isNotEmpty) {
                            setState(() {
                              isFieldFilled = true;
                            });
                          } else {
                            setState(() {
                              isFieldFilled = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Private Key',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: isFieldFilled == true
                                  ? Colors.green
                                  : Colors.grey),
                          onPressed: () {
                            isFieldFilled == true
                                ? checkupdateDB()
                                : _displaySnackBar(
                                    context, "Please Fill Required Details");
                          },
                          child: Text("REGISTER"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 175,
        left: 320,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.60,
          color: Colors.red,
          child: Center(
            child: Text(
              "REGISTRATION".toUpperCase(),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.2),
            ),
          ),
        ),
      ),
    ]);
  }
}

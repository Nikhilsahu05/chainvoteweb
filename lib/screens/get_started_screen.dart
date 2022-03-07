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
                                    Icons.description,
                                    size: 32,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Description',
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
                                    Icons.how_to_reg,
                                    size: 32,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Voter Registration',
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
                                    Icons.how_to_vote,
                                    size: 32,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Voting Area',
                                        style: TextStyle(fontSize: 16))),
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
                                    Icons.poll,
                                    size: 32,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Result',
                                        style: TextStyle(fontSize: 16))),
                              ],
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
                  child: dataOfCandidate.docs.length == 0
                      ? Text("")
                      : ListView.builder(
                          itemCount: dataOfCandidate.docs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                    "${dataOfCandidate.docs[index]['candidateName']}"),
                              ),
                              title:Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                    "${dataOfCandidate.docs[index]['party']}"),
                              ),
                              subtitle: Text( "${dataOfCandidate.docs[index]['qualification']}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Age ${dataOfCandidate.docs[index]['age']}"),
                                  SizedBox(width: 45,),
                                  ElevatedButton(onPressed: (){}, child: Text("VOTE NOW"))
                                ],
                              ),
                            );
                          }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

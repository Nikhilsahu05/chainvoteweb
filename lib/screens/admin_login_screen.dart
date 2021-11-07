import 'package:chainvoteweb/screens/get_started_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passTextEditingController = TextEditingController();

  void signIn() async {}

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List adminCredential1 = [];
  List adminCredential2 = [];

  Future callAdminDetails() async {
    await firebaseFirestore
        .collection("admin_login")
        .doc("admin_login_credential_2")
        .get()
        .then((value) {
      print(value.data());
      adminCredential1.add(value.data()!["email"]);

      adminCredential1.add(value.data()!["password"]);
    }).catchError((onError) {
      print(onError);
    });

    await firebaseFirestore
        .collection("admin_login")
        .doc("admin_login_credentials")
        .get()
        .then((value) {
      print(value.data());
      adminCredential2.add(value.data()!["email"]);
      adminCredential2.add(value.data()!["password"]);
    }).catchError((onError) {
      print(onError);
    });

    print("${adminCredential1}${adminCredential2}");
  }

  void checkWeatherAdminIsPresentOrNot() {
    if (adminCredential1.contains(_emailTextEditingController.text.trim()) &&
        adminCredential1.contains(_passTextEditingController.text.trim())) {
      print("Email & Password is present 1 ");
      _displaySnackBar(context, "Admin Login Successful");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print('Admin is not present 1');

      _displaySnackBar(context, "Admin Login Error");
    }

    if (adminCredential2.contains(_emailTextEditingController.text.trim()) &&
        adminCredential2.contains(_passTextEditingController.text.trim())) {
      print("Email & Password is present 2");
      _displaySnackBar(context, "Admin Login Successful");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print('Admin is not present  2');
      _displaySnackBar(context, "Admin Login Error");
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text('$message'));
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  @override
  void initState() {
    callAdminDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xFFCBF1F5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(50),
                decoration: const BoxDecoration(
                  color: Color(0xFFCBF1F5),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(500.0)),
                ),
                child: SvgPicture.asset(
                  "assets/login.svg",
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(500.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 3),
                          child: TextField(
                            controller: _emailTextEditingController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_rounded,
                                color: Color(0xFFCBF1F5),
                              ),
                              border: InputBorder.none,
                              hintText: 'Enter email',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 3),
                          child: TextField(
                            controller: _passTextEditingController,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xFFCBF1F5),
                              ),
                              border: InputBorder.none,
                              hintText: 'Enter password',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        width: MediaQuery.of(context).size.width / 2.4,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent,
                            ),
                            onPressed: () {
                              checkWeatherAdminIsPresentOrNot();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

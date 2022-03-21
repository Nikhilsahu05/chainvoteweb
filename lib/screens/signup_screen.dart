import 'package:chainvoteweb/screens/login_screen.dart';
import 'package:chainvoteweb/screens/voter_adhaar_registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passTextController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String? _userEmail;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController confirmPassEditingController = TextEditingController();
  String uid = "";

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  checkRegisteredUser() async {
    await _firebaseFirestore
        .collection('VoterDetails')
        .where('email', isEqualTo: "${auth.currentUser?.email}")
        .get()
        .then((value) {
      print(value.docs.length);
      for (var i = 0; i < value.docs.length; i++) {
        print(value.docs.length);
        print(value.docs[i]['email']);
        print(value.docs[i]['registered']);
        if (value.docs[i]['registered'] == false) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => VoterRegisterationScreen()),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LoginScreen(_emailTextController, _passTextController)),
              (route) => false);
        }
        print(value.docs[i]['aadhar']);
      }
    });
  }

  void _register() async {
    auth
        .createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passTextController.text)
        .then((value) {
      checkRegisteredUser();
    }).catchError((onError) {
      print('${auth.currentUser}');
      auth
          .signInWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passTextController.text)
          .then((value) {
        checkRegisteredUser();
      }).catchError((onError) {
        print(onError);
      });

      print("an exeption found");
      print(onError);
    });
  }

  final snackBar = SnackBar(
    content: Text('Yay! A SnackBar!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text('$message'));
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                  "assets/signup.svg",
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
                      "Get's Started.",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(
                                            _emailTextController,
                                            _passTextController),
                                      ));
                                },
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: SignInButton(
                        Buttons.Google,
                        elevation: 8,
                        text: "Sign up with Google",
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 400,
                      child: Row(children: <Widget>[
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ]),
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
                            controller: nameTextEditingController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFFCBF1F5),
                              ),
                              border: InputBorder.none,
                              hintText: 'Enter name',
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
                            controller: _emailTextController,
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
                            controller: _passTextController,
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
                            controller: confirmPassEditingController,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xFFCBF1F5),
                              ),
                              border: InputBorder.none,
                              hintText: 'Confirm password',
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
                            onPressed: () async {
                              if (nameTextEditingController.text.isEmpty) {
                                return _displaySnackBar(
                                    context, "Please Enter Name");
                              }
                              if (_emailTextController.text.isEmpty) {
                                return _displaySnackBar(
                                    context, "Please Enter Email Address");
                              }
                              if (_passTextController.text.isEmpty) {
                                return _displaySnackBar(
                                    context, "Please Enter Password");
                              }
                              if (confirmPassEditingController.text.isEmpty) {
                                return _displaySnackBar(context,
                                    "Please Enter Confirm Password Field");
                              }
                              if (_passTextController.text !=
                                  confirmPassEditingController.text) {
                                return _displaySnackBar(
                                    context, "Password Should be Same");
                              }

                              _register();
                              await Future.delayed(Duration(seconds: 3));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Register',
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

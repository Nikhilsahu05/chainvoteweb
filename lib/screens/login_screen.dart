import 'package:chainvoteweb/candidate_tab_bar/candidate_tab_bar.dart';
import 'package:chainvoteweb/forgot_password.dart';
import 'package:chainvoteweb/screens/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  TextEditingController _emailTextController;
  TextEditingController _passTextController;

  LoginScreen(this._emailTextController, this._passTextController);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var checkboxForgot = false;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text('$message'));
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn() async {
    print(widget._emailTextController.text);
    print(widget._passTextController.text);
    _auth
        .signInWithEmailAndPassword(
            email: widget._emailTextController.text,
            password: widget._passTextController.text)
        .then((value) {
      checkRegisteredUser();
    }).catchError((onError) {
      print(onError);
      _displaySnackBar(context, "$onError");
    });
  }

  Future sendResetLink(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  checkRegisteredUser() async {
    await _firebaseFirestore
        .collection('VoterDetails')
        .where('email', isEqualTo: "${_auth.currentUser?.email}")
        .get()
        .then((value) {
      print(value.docs.length);
      for (var i = 0; i < value.docs.length; i++) {
        print(value.docs.length);
        print(value.docs[i]['email']);
        print(value.docs[i]['registered']);
        if (value.docs[i]['registered'] == false) {
          _displaySnackBar(context, "User not registered");
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CandidateTabBarScreen()),
              (route) => false);
        }
        print(value.docs[i]['aadhar']);
      }
    });
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
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "If you don't have an account?",
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
                                        builder: (context) => SignupScreen()),
                                  );
                                },
                                child: Text(
                                  "SignUp",
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
                        text: ""
                            "Login with Google",
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
                            controller: widget._emailTextController,
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
                            controller: widget._passTextController,
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
                      padding: const EdgeInsets.only(left: 130.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen()),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
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
                              signIn();
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

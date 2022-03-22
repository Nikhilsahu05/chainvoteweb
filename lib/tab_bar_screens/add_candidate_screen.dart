import 'package:chainvoteweb/utilities/backend_function.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../utilities/constants.dart';

class AddCandidateScreen extends StatefulWidget {
  @override
  State<AddCandidateScreen> createState() => _AddCandidateScreenState();
}

class _AddCandidateScreenState extends State<AddCandidateScreen> {
  Client? httpClient;
  Web3Client? ethClient;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _partyController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.60,
          width: MediaQuery.of(context).size.width * 0.65,
          child: Card(
            elevation: 18,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 50,
                    width: 350,
                    child: Center(
                      child: Text(
                        "Add Candidate Information".toUpperCase(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Full Name',
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: TextField(
                                controller: _qualificationController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Qualification',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: TextField(
                                controller: _partyController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Party',
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: TextField(
                                controller: _ageController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Age',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 12,
                      child: InkWell(
                        onTap: () {
                          addCandidate(
                                  _ageController.text,
                                  _nameController.text,
                                  _qualificationController.text,
                                  _partyController.text,
                                  ethClient!)
                              .catchError((onError) {
                            print(
                                "Error In AddCandidate function ====> $onError");
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(0.0),
                          height:
                              40.0, //MediaQuery.of(context).size.width * .08,
                          width:
                              150.0, //MediaQuery.of(context).size.width * .3,
                          decoration: BoxDecoration(),
                          child: Row(
                            children: <Widget>[
                              LayoutBuilder(builder: (context, constraints) {
                                print(constraints);
                                return Container(
                                  height: constraints.maxHeight,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                );
                              }),
                              Expanded(
                                child: Text(
                                  'ADD',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

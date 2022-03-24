import 'package:chainvoteweb/utilities/backend_function.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../utilities/constants.dart';

class AddCandidateScreen extends StatefulWidget {
  const AddCandidateScreen({Key? key}) : super(key: key);

  @override
  State<AddCandidateScreen> createState() => _AddCandidateScreenState();
}

class _AddCandidateScreenState extends State<AddCandidateScreen> {
  Client? httpClient;
  Web3Client? ethClient;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _partyController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  bool isLoading = false;

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
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.60,
          width: MediaQuery.of(context).size.width * 0.65,
          child: Card(
            elevation: 18,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: Center(
                      child: Text(
                        "Add Candidate Information".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.2),
                      ),
                    ),
                  ),
                  const SizedBox(
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
                                decoration: const InputDecoration(
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
                                decoration: const InputDecoration(
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
                                decoration: const InputDecoration(
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
                                decoration: const InputDecoration(
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
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await addCandidate(
                                  _ageController.text,
                                  _nameController.text,
                                  _qualificationController.text,
                                  _partyController.text,
                                  ethClient!)
                              .catchError((onError) {
                            if (kDebugMode) {
                              print(
                                  "Error In AddCandidate function ====> $onError");
                            }
                          });
                          setState(() {
                            isLoading = false;
                            _nameController.clear();
                            _qualificationController.clear();
                            _partyController.clear();
                            _ageController.clear();
                          });
                        },
                        child: isLoading == true
                            ? const SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  strokeWidth: 5,
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(0.0),
                                height:
                                    40.0, //MediaQuery.of(context).size.width * .08,
                                width:
                                    150.0, //MediaQuery.of(context).size.width * .3,
                                decoration: const BoxDecoration(),
                                child: Row(
                                  children: <Widget>[
                                    LayoutBuilder(
                                        builder: (context, constraints) {
                                      if (kDebugMode) {
                                        print(constraints);
                                      }
                                      return Container(
                                        height: constraints.maxHeight,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      );
                                    }),
                                    const Expanded(
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
                  const SizedBox(
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

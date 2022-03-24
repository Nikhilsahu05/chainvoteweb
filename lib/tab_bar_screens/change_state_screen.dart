import 'package:chainvoteweb/utilities/backend_function.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../utilities/constants.dart';

class ChangeState extends StatefulWidget {
  @override
  State<ChangeState> createState() => _ChangeStateState();
}

class _ChangeStateState extends State<ChangeState> {
  Client? httpClient;
  Web3Client? ethClient;
  final TextEditingController _electionNameController = TextEditingController();

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
        child: Container(
          height: MediaQuery.of(context).size.height * 0.60,
          width: MediaQuery.of(context).size.width * 0.65,
          child: Card(
            elevation: 18,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: FutureBuilder<List>(
                  future: getElectionActivity(ethClient!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "Change Phase".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.2),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                                child: Text(
                              snapshot.data![0] == false
                                  ? "Current Phase : Voting Not Started"
                                  : "Current Phase : Voting Started",
                              style: TextStyle(
                                  color: snapshot.data![0] == false
                                      ? Colors.red
                                      : Colors.green,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.1,
                                  fontSize: 17),
                            ))),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Container(
                                      child: Text(
                                    "Election Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.1,
                                        fontSize: 17),
                                  )),
                                ),
                              ),
                              Flexible(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          child: snapshot.data![0] == false
                                              ? TextField(
                                                  controller:
                                                      _electionNameController,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Election Name',
                                                  ),
                                                )
                                              : FutureBuilder<List>(
                                                  future: getElectionName(
                                                      ethClient!),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }
                                                    return Text(
                                                      snapshot.data![0]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 50,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  }))))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        snapshot.data![0] == false
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    elevation: 12,
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await startElection(
                                            _electionNameController.text,
                                            ethClient!);
                                        setState(() {
                                          isLoading = false;
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
                                              padding: EdgeInsets.all(0.0),
                                              height:
                                                  40.0, //MediaQuery.of(context).size.width * .08,
                                              width:
                                                  150.0, //MediaQuery.of(context).size.width * .3,
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                children: <Widget>[
                                                  LayoutBuilder(builder:
                                                      (context, constraints) {
                                                    print(constraints);
                                                    return Container(
                                                      height:
                                                          constraints.maxHeight,
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
                                                      'Start Voting',
                                                      textAlign:
                                                          TextAlign.center,
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
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    elevation: 12,
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await endElection(ethClient!);
                                        setState(() {
                                          isLoading = false;
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
                                              padding: EdgeInsets.all(0.0),
                                              height:
                                                  40.0, //MediaQuery.of(context).size.width * .08,
                                              width:
                                                  150.0, //MediaQuery.of(context).size.width * .3,
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                children: <Widget>[
                                                  LayoutBuilder(builder:
                                                      (context, constraints) {
                                                    print(constraints);
                                                    return Container(
                                                      height:
                                                          constraints.maxHeight,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    );
                                                  }),
                                                  Expanded(
                                                    child: Text(
                                                      'End Voting',
                                                      textAlign:
                                                          TextAlign.center,
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
                              )
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

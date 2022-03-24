import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../utilities/backend_function.dart';
import '../utilities/constants.dart';

class CandidateVotingAreaScreen extends StatefulWidget {
  @override
  State<CandidateVotingAreaScreen> createState() =>
      _CandidateVotingAreaScreenState();
}

class _CandidateVotingAreaScreenState extends State<CandidateVotingAreaScreen> {
  var httpClient;
  TextEditingController _pvtKeyController = TextEditingController();

  var ethClient;

  var totalCandidates;
  showAlertDialog(BuildContext context, int index) {
    // Create button
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Get.back();
        showTextInputPVTKey(context, index);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure?"),
      actions: [
        okButton,
        cancelButton,
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

  showTextInputPVTKey(BuildContext context, int index) {
    // Create button
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget okButton = FlatButton(
      child: Text("Proceed"),
      onPressed: () {
        Get.back();
        vote(index, _pvtKeyController.text, ethClient).catchError((onError) {
          print(onError);
        });
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Enter your MetaMask Private Key ?"),
      content: TextField(
        controller: _pvtKeyController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Private Key',
        ),
      ),
      actions: [
        okButton,
        cancelButton,
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
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: getVotingActivity(ethClient),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          } else {
            return snapshot.data![0] == false
                ? FutureBuilder<List>(
                    future: getElectionActivity(ethClient!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ));
                      } else {
                        return snapshot.data![0] == true
                            ? Scaffold(
                                body: Container(
                                  padding: EdgeInsets.all(14),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              FutureBuilder<List>(
                                                  future: getElectionName(
                                                      ethClient),
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
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 35,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  }),
                                              Text('Election Name')
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              FutureBuilder<List>(
                                                  future: getTotalCandidates(
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
                                                          fontSize: 35,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  }),
                                              Text('Total Candidates')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Divider(),
                                      Container(
                                        color: Colors.green.shade300,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: 150,
                                                child: Text(
                                                  "#",
                                                  style: TextStyle(
                                                      letterSpacing: 1.2,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: 150,
                                                child: Text(
                                                  "Name",
                                                  style: TextStyle(
                                                      letterSpacing: 1.2,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: 150,
                                                child: Text(
                                                  "Qualification",
                                                  style: TextStyle(
                                                      letterSpacing: 1.2,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: 150,
                                                child: Text(
                                                  "Party",
                                                  style: TextStyle(
                                                      letterSpacing: 1.2,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: 150,
                                                child: Text(
                                                  "Age",
                                                  style: TextStyle(
                                                      letterSpacing: 1.2,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: 150,
                                                child: Text(
                                                  "",
                                                  style: TextStyle(
                                                      letterSpacing: 1.2,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(thickness: 1.5),
                                      FutureBuilder<List>(
                                        future: getNumCandidates(ethClient!),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else {
                                            return Column(
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        snapshot.data![0]
                                                            .toInt();
                                                    i++)
                                                  FutureBuilder<List>(
                                                      future: candidateInfo(
                                                          i, ethClient!),
                                                      builder: (context,
                                                          candidatesnapshot) {
                                                        if (candidatesnapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        } else {
                                                          return Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        "${i + 1}",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        "${candidatesnapshot.data![0][2].toString()}",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        "${candidatesnapshot.data![0][3].toString()}",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        "${candidatesnapshot.data![0][4].toString()}",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        "${candidatesnapshot.data![0][0].toString()}",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Container(
                                                                        width: 150,
                                                                        child: ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            // vote(i, ethClient!).catchError((onError) {
                                                                            //   print(onError);
                                                                            // });
                                                                            showAlertDialog(context,
                                                                                i);
                                                                          },
                                                                          child:
                                                                              Text("Vote"),
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider(
                                                                  thickness:
                                                                      1.5),
                                                            ],
                                                          );
                                                        }
                                                      })
                                              ],
                                            );
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "Election has not started yet!",
                                  style: TextStyle(
                                      fontSize: 20,
                                      letterSpacing: 1.35,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                      }
                    })
                : Center(
                    child: Text(
                      "Your Vote has counted!",
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.35,
                          fontWeight: FontWeight.bold),
                    ),
                  );
          }
        });
  }
}

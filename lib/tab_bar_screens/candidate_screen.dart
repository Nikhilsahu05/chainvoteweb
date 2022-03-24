import 'package:chainvoteweb/utilities/backend_function.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../utilities/constants.dart';

class CandidateScreens extends StatefulWidget {
  @override
  State<CandidateScreens> createState() => _CandidateScreensState();
}

class _CandidateScreensState extends State<CandidateScreens> {
  var httpClient;
  var ethClient;
  var totalCandidates;

  getTotalCandidates() async {
    print(getNumCandidates(ethClient));
  }

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient);
    getTotalCandidates();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FutureBuilder<List>(
                        future: getNumCandidates(ethClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Text(
                            snapshot.data![0].toString(),
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          );
                        }),
                    Text('Total Candidates')
                  ],
                ),
                Column(
                  children: [
                    FutureBuilder<List>(
                        future: getTotalVotes(ethClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Text(
                            snapshot.data![0].toString(),
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          );
                        }),
                    Text('Total Votes')
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: 150,
                      child: Text(
                        "#",
                        style: TextStyle(
                            letterSpacing: 1.2, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 150,
                      child: Text(
                        "Name",
                        style: TextStyle(
                            letterSpacing: 1.2, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 150,
                      child: Text(
                        "Qualification",
                        style: TextStyle(
                            letterSpacing: 1.2, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 150,
                      child: Text(
                        "Party",
                        style: TextStyle(
                            letterSpacing: 1.2, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 150,
                      child: Text(
                        "Age",
                        style: TextStyle(
                            letterSpacing: 1.2, fontWeight: FontWeight.bold),
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      for (int i = 0; i < snapshot.data![0].toInt(); i++)
                        FutureBuilder<List>(
                            future: candidateInfo(i, ethClient!),
                            builder: (context, candidatesnapshot) {
                              if (candidatesnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Column(
                                  children: [
                                    Row(
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
                                              "${i + 1}",
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 150,
                                            child: Text(
                                              "${candidatesnapshot.data![0][2].toString()}",
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 150,
                                            child: Text(
                                              "${candidatesnapshot.data![0][3].toString()}",
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 150,
                                            child: Text(
                                              "${candidatesnapshot.data![0][4].toString()}",
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 150,
                                            child: Text(
                                              "${candidatesnapshot.data![0][0].toString()}",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 1.5),
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
    );
  }
}
//       Flexible(
//                                         child: Text(
//                                           candidatesnapshot.data![0][3]
//                                               .toString(),
//                                           textAlign: TextAlign.start,
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                           candidatesnapshot.data![0][4]
//                                               .toString(),
//                                           textAlign: TextAlign.start,
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                           candidatesnapshot.data![0][0]
//                                               .toString(),
//                                           textAlign: TextAlign.start,
//                                         ),
//                                       ),

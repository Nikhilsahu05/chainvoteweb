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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  child: Text(
                    "#",
                  ),
                ),
                Container(
                  width: 150,
                  child: Text(
                    "Name",
                  ),
                ),
                Container(
                  width: 150,
                  child: Text(
                    "Qualification",
                  ),
                ),
                Container(
                  width: 150,
                  child: Text(
                    "Party",
                  ),
                ),
                Container(
                  width: 150,
                  child: Text(
                    "Age",
                  ),
                ),
              ],
            ),
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
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${i + 1}"),
                                    Container(
                                      width: 150,
                                      child: Text(
                                        candidatesnapshot.data![0][2]
                                            .toString(),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      child: Text(
                                        candidatesnapshot.data![0][3]
                                            .toString(),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      child: Text(
                                        candidatesnapshot.data![0][4]
                                            .toString(),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      child: Text(
                                        candidatesnapshot.data![0][0]
                                            .toString(),
                                      ),
                                    ),
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

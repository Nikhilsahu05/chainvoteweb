import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../utilities/backend_function.dart';
import '../utilities/constants.dart';

class CandidateResultScreen extends StatefulWidget {
  @override
  State<CandidateResultScreen> createState() => _CandidateResultScreenState();
}

class _CandidateResultScreenState extends State<CandidateResultScreen> {
  var httpClient;

  var ethClient;

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient);
    getVotingActivity(ethClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List>(
          future: getTotalVotes(ethClient),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()));
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<List>(
                      future: getTotalVotes(ethClient!),
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
                              fontSize: 35, fontWeight: FontWeight.bold),
                        );
                      }),
                  Text('Total Votes'),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: 150,
                          child: Text(
                            "",
                            style: TextStyle(
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 150,
                          child: Text(
                            "#",
                            style: TextStyle(
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold),
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
                                fontWeight: FontWeight.bold),
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
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 150,
                          child: Text(
                            "Votes",
                            style: TextStyle(
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
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
                                                child: Container(),
                                              ),
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
                                                    "${candidatesnapshot.data![0][4].toString()}",
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 150,
                                                  child: Text(
                                                    "${candidatesnapshot.data![0][1].toString()}",
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
              );
            }
          }),
    );
  }
}

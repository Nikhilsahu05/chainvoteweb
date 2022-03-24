import 'package:flutter/material.dart';

import 'candidate_information_screen.dart';
import 'candidate_logout_screen.dart';
import 'candidate_result_screen.dart';
import 'candidate_voting_area.dart';

class CandidateTabBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(

        initialIndex: 1,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(


              tabs: [
                Tab(icon: Icon(Icons.info), text: "Information"),
                Tab(icon: Icon(Icons.ballot), text: "Voting Area"),
                Tab(icon: Icon(Icons.insert_chart), text: "Result"),
                Tab(
                    icon: Icon(
                      Icons.logout,
                    ),
                    text: "Logout"),
              ],
            ),
            title: Center(
              child: Container(
                child: Text(
                  'Vote Chain'.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 2.5),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              CandidateInformationScreen(),
              CandidateVotingAreaScreen(),
              CandidateResultScreen(),
              CandidateLogoutScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

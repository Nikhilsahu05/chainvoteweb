import 'package:chainvoteweb/candidate_tab_bar/candidate_logout_screen.dart';
import 'package:chainvoteweb/tab_bar_screens/add_candidate_screen.dart';
import 'package:chainvoteweb/tab_bar_screens/candidate_screen.dart';
import 'package:chainvoteweb/tab_bar_screens/change_state_screen.dart';
import 'package:flutter/material.dart';

class AdminTabBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.info), text: "Candidate Details"),
                Tab(
                    icon: Icon(
                      Icons.person_add,
                    ),
                    text: "Add Candidate"),
                Tab(
                    icon: Icon(
                      Icons.published_with_changes,
                    ),
                    text: "Change Phase"),
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
              CandidateScreens(),
              AddCandidateScreen(),
              ChangeState(),
              CandidateLogoutScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

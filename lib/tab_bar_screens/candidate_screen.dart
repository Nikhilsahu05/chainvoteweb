import 'package:flutter/material.dart';

class CandidateScreens extends StatelessWidget {
  const CandidateScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.blue.shade200,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.60,
            width: MediaQuery.of(context).size.width * 0.65,
            child: Card(
              elevation: 18,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: Text(
                          "#",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Age",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Party",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Qualification",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text("${(index + 1)}"),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Name"),
                                  Text("Age"),
                                  Text("Party"),
                                  Text("Qualification"),
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 50,
        left: 300,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.60,
          color: Colors.red,
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
      ),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CandidateInformationScreen extends StatelessWidget {
  const CandidateInformationScreen({Key? key}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: 1000,
                    child: Center(
                      child: Text(
                        "user manual".toUpperCase(),
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
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Welcome',
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                        children: <TextSpan>[],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'These are few Guidelines for user:',
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                        children: <TextSpan>[],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Voting Process',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: <TextSpan>[],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 8.0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '*  ',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'Overall,voting process is divided into two phases.All of which will be initialized and terminated by the admin.User have to participate in the process according to current phase.'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Voting Phase:',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: <TextSpan>[],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 8.0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '*  ',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'After initialization of voting phase from the admin,user can cast the vote in voting section.The casting of vote can be simply done by clicking on "VOTE" button,after which transaction will be initiated and after confirming transaction the vote will get successfully casted.After voting phase gets over user will not be able to vote.'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Result Phase:',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: <TextSpan>[],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 8.0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '*  ',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'This is the final stage of whole voting process during which the results of election will be displayed at "Result" section.')
                        ],
                      ),
                    ),
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

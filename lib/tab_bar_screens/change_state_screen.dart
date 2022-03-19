import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ChangeState extends StatelessWidget {
  const ChangeState({Key? key}) : super(key: key);

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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Current Phase :",
                        style: TextStyle(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
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
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Election Name',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Container(
                                child: Text(
                              "Voting",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.1,
                                  fontSize: 17),
                            )),
                          ),
                        ),
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.blue,
                          value: true,
                          onToggle: (value) {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 12,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(0.0),
                            height:
                                40.0, //MediaQuery.of(context).size.width * .08,
                            width:
                                150.0, //MediaQuery.of(context).size.width * .3,
                            decoration: BoxDecoration(),
                            child: Row(
                              children: <Widget>[
                                LayoutBuilder(builder: (context, constraints) {
                                  print(constraints);
                                  return Container(
                                    height: constraints.maxHeight,
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
                                    'Save',
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

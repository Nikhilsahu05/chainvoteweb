import 'package:flutter/material.dart';
import 'package:chainvoteweb/utilities/constants.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class Ballot extends StatefulWidget {
  @override
  _BallotState createState() => _BallotState();
}

class _BallotState extends State<Ballot> with ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _privateKey =
      "63d5902a0f1b6f46b4fca880f8306b6c0379b87abe1ba6130678aa3a4e9318cd";

  Web3Client? _client;
  bool isLoading = true;

  String? _abiCode;

  EthereumAddress? _contractAddress;

  var _credentials;

  var _contract;
  var _printBallot;
  var _addCandidate;

  String? deployedName;
  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    // establish a connection to the ethereum rpc node. The socketConnector
    // property allows more efficient event streams over websocket instead of
    // http-polls. However, the socketConnector property is experimental.
    final httpClient = Client();
    _client = Web3Client(_rpcUrl, httpClient, socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    // Reading the contract abi
    String abiStringFile =
        await rootBundle.loadString("build/artifacts/Candidates.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client?.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {
    // Telling Web3dart where our contract is declared.

    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "Candidates"), _contractAddress!);

    // Extracting the functions, declared in contract.
    _printBallot = _contract?.function("printBallot");
    _addCandidate = _contract?.function("addCandidate");
    _printBallot();
    // print(_printBallot);
  }

  getName() async {
    // Getting the current name declared in the smart contract.
    var currentName = await _client
        ?.call(contract: _contract, function: _addCandidate, params: []);
    var deployedName = currentName![0];
    isLoading = false;
    print("Deployed Name => $deployedName");
    notifyListeners();
  }

  setName(String nameToSet) async {
    // Setting the name to nameToSet(name defined by user)
    isLoading = true;
    notifyListeners();

    await _client?.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _contract,
            function: _addCandidate,
            parameters: [nameToSet]));
    getName();
  }

  String? candidateName;

  TextEditingController candidateNameContoller = TextEditingController();

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Printing Ballot"),
      content: Container(
        height: 500,
        width: 500,
        child: ListView.builder(
            itemCount: candidateNamesList.length,
            itemBuilder: (context, index) {
              return Text("${candidateNamesList[index]}");
            }),
      ),
      actions: [
        okButton,
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

  List candidateNamesList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: SafeArea(
          child: Column(children: <Widget>[
            TextField(
              controller: candidateNameContoller,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(children: [
              TextButton(
                onPressed: () {
                  setName(candidateNameContoller.text);
                  setState(() {
                    candidateNamesList.add(candidateNameContoller.text);
                  });
                  print(candidateNameContoller.text);
                  candidateNameContoller.clear();
                },
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 60.0),
                ),
              ),
              TextButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                child: Text(
                  'Print Ballot',
                  style: TextStyle(fontSize: 60.0),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}

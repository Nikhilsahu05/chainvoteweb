import 'dart:convert';

import 'package:chainvoteweb/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _privateKey =
      "6d4240b88168edcf0b5276afa192f2fb6d8af89e761c25987d5b2b5828a14ac8";

  Web3Client? _client;
  bool isLoading = true;

  String? _abiCode;

  EthereumAddress? _contractAddress;

  Credentials? _credentials;

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
    print(_printBallot);
  }

  getName() async {
    // Getting the current name declared in the smart contract.

    var ballot = await _client
        ?.call(contract: _contract, function: _printBallot, params: []);
    deployedName = ballot![0];
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
}

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _candidateName = TextEditingController();
  TextEditingController _party = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _qualification = TextEditingController();

  showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget continueButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Confirm"),
      onPressed: () {
        _auth.signOut();
        Get.to(WelcomeScreen());
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
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
  //
  // FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //
  // addCandidatesDetailsToDB() async {
  //   _firebaseFirestore
  //       .collection('adminCandidate')
  //       .doc("${_auth.currentUser?.uid}")
  //       .set({
  //     'candidateName': _candidateName.text,
  //     'party': _party.text,
  //     'qualification': _qualification.text,
  //     'age': _age.text,
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  //
  //   // ethAddCandidate();
  // }

  // ethAddCandidate() {
  //   //  creating contractFactory after compiled Solidity file on Remix
  //   var CandidateContractAddress = "0xd9145CCE52D386f254917e481eB44e9943F39138";
  //   var CandidateContractABI = [
  //     {
  //       "inputs": [
  //         {"internalType": "string", "name": "candidate_", "type": "string"}
  //       ],
  //       "name": "addCandidate",
  //       "outputs": [],
  //       "stateMutability": "nonpayable",
  //       "type": "function"
  //     },
  //     {
  //       "inputs": [],
  //       "name": "printBallot",
  //       "outputs": [
  //         {"internalType": "string[]", "name": "", "type": "string[]"}
  //       ],
  //       "stateMutability": "view",
  //       "type": "function"
  //     }
  //   ];
  //
  //   var provider = new ethers.providers.Web3Provider(
  //     web3.currentProvider,
  //     "ropsten"
  //   );
  //
  //   var CandContract;
  //   var signer;
  //
  //   provider.listAccounts(0).then((accounts) => {
  //     signer = provider.getSigner(accounts[0]);
  //     CandContract = new ethers.Contract(
  //       CandidateContractAddress,
  //       CandidateContractABI,
  //       signer
  //   );
  //   });
  //
  //   addCandidate() async {
  //   var candidate = "Modi";
  //   var addCandidatePromise = CandContract.addCandidate(candidate);
  //   await addCandidatePromise;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        flex: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 60.0, right: 40),
                                  child: Icon(
                                    Icons.info,
                                    size: 32,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Candidate Details',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 60.0, right: 40),
                                  child: Icon(
                                    Icons.person_add,
                                    size: 32,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Add Candidate',
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 60.0, right: 40),
                                  child: Icon(
                                    Icons.published_with_changes,
                                    size: 32,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Change State',
                                        style: TextStyle(fontSize: 16))),
                              ],
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            SizedBox(
                              height: 35,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 35.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 60.0,
                                    right: 40,
                                  ),
                                  child: Icon(
                                    Icons.logout,
                                    size: 32,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print("CLicked");
                                    showAlertDialog(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1.75,
                height: MediaQuery.of(context).size.height,
                color: Colors.grey.shade300,
              ),
              Expanded(
                flex: 8,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Add Candidate Info',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextField(
                        controller: _candidateName,
                        decoration: InputDecoration(hintText: 'Name'),
                      ),
                      TextField(
                        controller: _party,
                        decoration: InputDecoration(hintText: 'Party'),
                      ),
                      TextField(
                        controller: _age,
                        decoration: InputDecoration(
                          hintText: 'Age',
                        ),
                      ),
                      TextField(
                        controller: _qualification,
                        decoration: InputDecoration(
                          hintText: 'Qualification',
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // addCandidatesDetailsToDB();
                          },
                          child: Text('Add'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

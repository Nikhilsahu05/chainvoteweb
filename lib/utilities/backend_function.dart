import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

import 'constants.dart';

List candidateInfoList = [];

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  String contractAddress = contractAddress1;
  final contract = DeployedContract(ContractAbi.fromJson(abi, 'Voting'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String funcname, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funcname);
  final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
}

Future<String> startElection(String name, Web3Client ethClient) async {
  var response =
      await callFunction('startElection', [name], ethClient, owner_private_key);
  print('Election started successfully');

  return response;
}

Future<String> endElection(Web3Client ethClient) async {
  var response =
      await callFunction('endElection', [], ethClient, owner_private_key);
  print('Election Ended successfully');
  print(response);
  return response;
}

Future<String> addCandidate(String name, String age, String qualification,
    String party, Web3Client ethClient) async {
  var response = await callFunction('addCandidateOtherInfo',
      [age, name, qualification, party], ethClient, owner_private_key);
  print('Candidate added successfully');
  print(
      'Age ==> $age,Name ==> $name, Qualification==> $qualification, Party ==> $party');
  print('$name');
  return response;
}

//TODO: AUTHORIZE VOTER
// Future<String> authorizeVoter(String address, Web3Client ethClient) async {
//   var response = await callFunction('authorizeVoter',
//       [EthereumAddress.fromHex(address)], ethClient, owner_private_key);
//   print('Voter Authorized successfully');
//   return response;
// }

Future<List> getTotalCandidates(Web3Client ethClient) async {
  List<dynamic> result = await ask('getTotalCandidates', [], ethClient);
  print('result ==> ${result.length}');
  return result;
}

Future<List> getNumCandidates(Web3Client ethClient) async {
  List<dynamic> result = await ask('getNumCandidates', [], ethClient);

  return result;
}

Future<List> getElectionActivity(Web3Client ethClient) async {
  List<dynamic> result = await ask('getElectionActivity', [], ethClient);
  print(result[0]);
  return result;
}

Future<List> getElectionName(Web3Client ethClient) async {
  List<dynamic> result = await ask('getElectionName', [], ethClient);
  print(result[0]);
  return result;
}

Future<List> getVotingActivity(Web3Client ethClient) async {
  List<dynamic> result = await ask('getVotingActivity', [], ethClient);
  print(result[0]);
  return result;
}

Future<List> getTotalVotes(Web3Client ethClient) async {
  List<dynamic> result = await ask('getTotalVotes', [], ethClient);
  return result;
}

// Future<List> candidateInfo(int index, Web3Client ethClient) async {
//   List<dynamic> result =
//       await ask('candidateInfo', [BigInt.from(index)], ethClient);
//   return result;
// }

Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result =
      ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<String> vote(
    int candidateIndex, String voterPvtKey, Web3Client ethClient) async {
  var response = await callFunction(
      "vote", [BigInt.from(candidateIndex)], ethClient, owner_private_key);
  print("key ==> $owner_private_key");
  print("index ==> $candidateIndex");
  print("Vote counted successfully");
  return response;
}

Future<List> candidateInfo(int index, Web3Client ethClient) async {
  List<dynamic> result =
      await ask('candidateInfo', [BigInt.from(index)], ethClient);

  return result;
}

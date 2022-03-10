const Candidates = artifacts.require("Candidates");

contract("Candidates" , () => {
	it("Candidates Testing" , async () => {
	const contract = await Candidates.deployed() ;
	const parties = ['TOM', 'JERRY', 'POPEYE', 'BEN10'];
	await contract.addCandidate(parties[0]) ;
	await contract.addCandidate(parties[1]) ;
	await contract.addCandidate(parties[2]) ;
	await contract.addCandidate(parties[3]) ;
	const result = await contract.printBallot() ;
	console.log(result);
	});
});

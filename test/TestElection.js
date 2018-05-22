// Specifically request an abstraction for Registry
var Election = artifacts.require("Election");

contract('Election', function(accounts) {

  let electionContractInstance;

  it("Administrator should be able to add eligible voters to census", function() {
      return Election.deployed().then(function(instance) {
          electionContractInstance = instance;
          electionContractInstance.addEligibleVoter(accounts[1]);
          return electionContractInstance.eligibleVoters.call(accounts[1]);
      }).then(function(member) {
          assert.equal(member[0], 1, "Administrator is able to add eligible voters to the census");
      });
  });

    it("Eligible Voters should be able to vote", function() {
        return Election.deployed().then(function(instance) {
            electionContractInstance.addEligibleVoter(accounts[0]);
            electionContractInstance.Vote(1,0,0);
            return electionContractInstance.votes.call(1);
        }).then(function(member) {
            assert.equal(member.toNumber(), 1, "Vote has been cast");
        });
    });

});

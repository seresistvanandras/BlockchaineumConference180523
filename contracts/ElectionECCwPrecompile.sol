pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import {eccPrecompiles} from './utils/preCompiles.sol';

contract ElectionECCwPrecompile is Ownable {
  using SafeMath for uint256;
  mapping (address => Voter) public eligibleVoters;
  mapping (uint256 => uint256) public votes; //counts the votes for specific options

  string public question;

  //https://github.com/ethereum/EIPs/pull/213


  struct Voter {
    bool eligible;
    uint256 blindedVote;
    uint256 signedBlindedVote;
  }

  event voteSuccess(address indexed voter, uint256 choiceCode);


  //constructor
  function ElectionECCwPrecompile (string _question) public {
    question = _question;
  }



  function Vote(uint256 choiceCode, uint256 c, uint256 s) public {
    votes[choiceCode] = votes[choiceCode].add(1);

    voteSuccess(msg.sender,choiceCode);
  }


  function addEligibleVoter(address _voter) onlyOwner public {
    eligibleVoters[_voter].eligible = true;
  }

  function removeEligibleVoter(address _voter) onlyOwner public {
    eligibleVoters[_voter].eligible = false;
  }
}

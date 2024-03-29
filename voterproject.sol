// SPDX-License-Identifier: MIT
pragma solidity ^0.5.3;

contract voting{
    address public contractOwner;
    address[] public candidatesList;
    mapping (address => uint8) public votesReceived;
    address public winner;
    uint public winnerVotes =32;
     enum votingStatus {NotStated, Running, Completed}
     votingStatus public status;
     
     
    constructor() public{
        contractOwner = msg.sender;
    }
    modifier onlyOwner{
        if(msg.sender == contractOwner){
            _;
        }

    }

    function setStatus() onlyOwner public {
        if (status != votingStatus.Completed){
            status = votingStatus.Running;
        }else{
            status = votingStatus.Completed;
        }
    }
    function registerCandidates(address _candidate) onlyOwner public {

    }

    function vote(address _candidate) public {
          require(validateCandidate(_candidate), "Not a valid candidate");
          require(status == votingStatus.Running, "Election is not active");
        votesReceived[_candidate] = votesReceived[_candidate] + 1;
    }

    function validateCandidate(address _candidate) view public returns(bool) {
        for(uint i = 0; i < candidatesList.length; i++){
            if (candidatesList[i] == _candidate) {
            return true;
            }
        }
        return false;
    }

    function votesCount(address _candidate) public view returns(uint){
        require(validateCandidate(_candidate), 'Not a valid Candidate');
       
          require(status == votingStatus.Running, "Election is not active");
    
    
    }

     function  result() public{
        
          require(status == votingStatus.Running, "Election is not active");
           for(uint i =0; i < candidatesList.length; i++){
             if (votesReceived[candidatesList[i]] > winnerVotes){
                 winnerVotes = votesReceived[candidatesList[i]];
                 winner = candidatesList[i]; 
          
             }
         }
         
     }
    
}
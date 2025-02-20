
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AIVotingAdvisor {
    address public owner;
    mapping(address => bool) public hasVoted;
    mapping(string => uint256) public votes;
    string[] public options;
    
    event Voted(address indexed voter, string option);
    
    constructor() {
        owner = msg.sender;
        options = ["Option1", "Option2", "Option3"];
    }
    
    function vote(string memory _option) public {
        require(!hasVoted[msg.sender], "You have already voted");
        bool validOption = false;
        for (uint i = 0; i < options.length; i++) {
            if (keccak256(abi.encodePacked(options[i])) == keccak256(abi.encodePacked(_option))) {
                validOption = true;
                break;
            }
        }
        require(validOption, "Invalid voting option");
        
        votes[_option]++;
        hasVoted[msg.sender] = true;
        
        emit Voted(msg.sender, _option);
    }
    
    function getVotes(string memory _option) public view returns (uint256) {
        return votes[_option];
    }
}

//SPDX-License-Identifier:MIT
pragma solidity ^0.8.1;

contract DeRep {
    address public admin;
    uint public counter;
    string[] public dummy;

    struct News {
        string source;
        string news;
        string voteStatus;
        string finalResult;
        string newsRef; 
        uint rewards;
        uint quorumRequired;
        uint pID;
    }

    struct VoteOptions {
        uint newsId;
        string Option;
    }

    mapping(uint => News) public newsPosts;
    mapping (uint => mapping (string => uint256)) public voteSnapshot;
    mapping (uint => mapping (address => bool)) public voteUsermap;


    function addPredictions(string memory _source, string memory _news, string memory _newsRef, uint _quorumRequired) public {
        counter = counter + 1;
        newsPosts[counter] = News( _source, _news, "Ongoing" , "" , _newsRef, 0,  _quorumRequired, counter);
        voteSnapshot[counter]['Total'] = 0;
        voteSnapshot[counter]['Fact'] = 0;
        voteSnapshot[counter]['Fake'] = 0;
    
    }

    function voteOnPredictions(uint _pId, string memory _vote) public {

        //require(newsPosts[_pId].voteStatus == 'Ongoing', "Invalid Status");
        require((keccak256(abi.encodePacked((newsPosts[_pId].voteStatus))) == keccak256(abi.encodePacked(('Ongoing')))), "Invalid Status");
        require( voteUsermap[_pId][msg.sender] == false, "User Already Voted");

        voteSnapshot[_pId][_vote] += 1;
        voteSnapshot[_pId]['Total'] += 1;
        voteUsermap[_pId][msg.sender] =true;

        if (voteSnapshot[_pId]['Total'] > newsPosts[_pId].quorumRequired){

            if ((voteSnapshot[_pId][_vote] * 100) > (voteSnapshot[_pId]['Total'] * 75)){

                newsPosts[_pId].finalResult = _vote;
                newsPosts[_pId].voteStatus = 'Completed';
            
               
            } 
         


        }



    }



}
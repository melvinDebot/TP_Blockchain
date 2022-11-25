pragma solidity ^0.5;

contract Message {
    string public lemessage;

    constructor(string memory _messageoriginal) public {
        lemessage = _messageoriginal;
    }

    function definirMessage(string memory _nouveaumessage) public {
        lemessage = _nouveaumessage;
    }

    function voirMessage() public view returns (string memory) {
        return lemessage;
    }
}

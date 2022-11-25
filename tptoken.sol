pragma solidity ^0.5;

contract MyCoin {
    address public minter;
    mapping(address => uint256) public balances; // Génère un tabeleau

    event Sent (address from, address to, uint amount);

    constructor() public {
        minter = msg.sender; //Récupérer l'adresse qui a créer le smart contract
    }

    function mint(address receiver, uint256 amount) public {
        require(msg.sender == minter); // Vérification de la transaction
        require(amount < 1e60);
        balances[receiver] += amount;
    }

    function send(address receiver, uint256 amount) public {
        require(balances[msg.sender] > amount, "Not enough token");
        require(amount + balances[receiver] < 1e60, "don't.");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}

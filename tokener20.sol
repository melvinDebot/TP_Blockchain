pragma solidity 0.5.15;

contract ERC20Basic {
    // ici on déclare les 6 fonctions et les 2 evenements standards de l'ERC20

    // @return total amount of tokens
    function totalSupply() public view returns (uint256);

    // @param _owner The address from which the balance will be retrieved
    /// @return The balance
    function balanceOf(address who) public view returns (uint256);

    // @notice send `_value` token to `_to` from `msg.sender`
    // @param _to The address of the recipient
    // @param _value The amount of token to be transferred
    // @return Whether the transfer was successful or not
    function transfer(address to, uint256 value) public returns (bool);

    // @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    // @param _from The address of the sender
    // @param _to The address of the recipient
    // @param _value The amount of token to be transferred
    // @return Whether the transfer was successful or not
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public returns (bool) {}

    // @notice `msg.sender` approves `_addr` to spend `_value` tokens
    // @param _spender The address of the account able to transfer the tokens
    // @param _value The amount of wei to be approved for transfer
    // @return Whether the approval was successful or not
    function approve(address spender, uint256 value) public returns (bool);

    // @param _owner The address of the account owning tokens
    // @param _spender The address of the account able to transfer the tokens
    // @return Amount of remaining tokens allowed to spent
    function allowance(address owner, address spender)
        public
        view
        returns (uint256);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
}

contract StandardToken is ERC20Basic {
    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowed;

    uint256 public _totalSupply;

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address who) public view returns (uint256) {
        return balances[who];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        //Default assumes totalSupply can't be over max (2^256 - 1).
        if (balances[msg.sender] >= value && value > 0) {
            balances[msg.sender] -= value;
            balances[to] += value;
            emit Transfer(msg.sender, to, value);
            return true;
        } else {
            return false;
        }
    }

    // @param _owner The address of the account owning tokens
    // @param _spender The address of the account able to transfer the tokens
    // @return Amount of remaining tokens allowed to spent
    function allowance(address owner, address spender)
        public
        view
        returns (uint256)
    {
        return allowed[owner][spender];
    }

    // @notice `msg.sender` approves `_addr` to spend `_value` tokens
    // @param _spender The address of the account able to transfer the tokens
    // @param _value The amount of wei to be approved for transfer
    // @return Whether the approval was successful or not
    function approve(address spender, uint256 value) public returns (bool) {
        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    // @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    // @param _from The address of the sender
    // @param _to The address of the recipient
    // @param _value The amount of token to be transferred
    // @return Whether the transfer was successful or not
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public returns (bool) {
        require(
            allowed[from][msg.sender] > 0 && allowed[from][msg.sender] >= value
        );
        if (balances[from] >= value && value > 0) {
            balances[to] += value;
            balances[from] -= value;
            allowed[from][msg.sender] -= value;
            emit Transfer(from, to, value);
            return true;
        } else {
            return false;
        }
    }
}

contract YnovToken is StandardToken {
    // on rajoute les variables qui viennent définir le token
    string public name;
    string public symbol;
    uint256 public decimals;

    /**
     * @dev assign totalSupply to account creating this contract
     */
    constructor() public {
        symbol = "DBT";
        name = "DEBOT";
        decimals = 18;
        _totalSupply = 21000000;

        balances[msg.sender] = _totalSupply * 10**decimals;
    }
}

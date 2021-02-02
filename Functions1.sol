pragma solidity ^0.7.4;

contract Mapping {

    // mapping data structure
    mapping(address => uint64) public balanceReceived; 

    address payable owner;

    constructor() public { 

        owner = msg.sender;

    }

    function getOwner() public view returns(address){

        return owner;

    }

    // pure = does not interact with state at the top (class varaibles)
    // a regular function can call this one 
    function convertWeiToEther(uint _amountInWei) public pure returns(uint) {

        return _amountInWei / 1 ether;

    }

    function destroySmartContract() public {
        require(msg.sender == owner, "you are not the owner");
        
        selfdestruct(owner);
        
    }

    function getMyBalance() public view returns(uint) {

        return address(this).balance;

    }
        

    function receiveMoney() public payable {

        // assert checks internal state whereas require deals with implemented data
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);

        balanceReceived[msg.sender] += uint64(msg.value);

    }

    function sendMoneyTo(address payable _to, uint64 _amount) public {

        // for implementation use require = 
        // require used to validate user input
        // require returns gas to user
        require(balanceReceived[msg.sender] >= _amount, "not enough funds");

        // assert does not return gas to user
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);

        balanceReceived[msg.sender] -= _amount;

        _to.transfer(_amount);

    }

    // catch all - none of functions match or payable is not included in your contract
    fallback () external payable {

        receiveMoney();

    }

}
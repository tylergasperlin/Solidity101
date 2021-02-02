pragma solidity ^0.7.4;

contract Mapping {

    // mapping data structure
    mapping(address => uint64) public balanceReceived; 

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

}
pragma solidity ^0.7.4;

contract Mapping {

    struct Payment {
        uint amount;
        uint timestamps;
    }

    struct Balance {
        uint totalBalance;
        uint numPayments; 
        mapping(uint => Payment) payments;
    }

    // mapping data structure
    mapping(address => Balance) public balanceReceived; 

    function getMyBalance() public view returns(uint) {
        return address(this).balance;
    }
        

    function receiveMoney() public payable {

        balanceReceived[msg.sender].totalBalance += msg.value;

        Payment memory payment = Payment(msg.value, block.timestamp);

        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;

        balanceReceived[msg.sender].numPayments++;

    }

    function sendMoneyTo(address payable _to, uint _amount) public {
        // for implementation use require
        require(balanceReceived[msg.sender].totalBalance >= _amount, "not enough funds");
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }

    function sendAllMoneyTo(address payable _to) public {
        // checks effect interaction

        //check if you can do something
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        // make sure you can do something and impact state
        balanceReceived[msg.sender].totalBalance = 0;
        // interact with external effect
        _to.transfer(balanceToSend);
    }

}
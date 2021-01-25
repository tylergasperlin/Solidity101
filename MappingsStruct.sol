pragma solidity ^0.7.4;

contract Mapping {

    // mapping data structure
    mapping(address => uint) public balanceReceived; 

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
        

    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(balanceReceived[msg.sender] >= _amount, "not enough funds");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    function withdrawAllMoney(address payable _to) public {
        // checks effect interaction

        //check if you can do something
        uint balanceToSend = balanceReceived[msg.sender];
        // make sure you can do something and impact state
        balanceReceived[msg.sender] = 0;
        // interact with external effect
        _to.transfer(balanceToSend);
    }

}
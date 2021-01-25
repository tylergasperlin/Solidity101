pragma solidity ^0.7.4;

contract Mapping {

    mapping(uint => bool) public myMapping;
    
    // maps an address to bool
    mapping(address => bool) public myAddressMapping;
    
    function setValue(uint _index) public {
        myMapping[_index] = true;
    }

    // sets the sender's address to true using mapping 
    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }


}
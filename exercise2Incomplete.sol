//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract example {
    struct name{
        bytes32 givenName;
        bytes32 familyName;
        uint8 age;
    }
    uint public x;
    name[3] public persons;
    uint public y;

    function populate() public {
        persons[0] = name("Ian", "Mitchell", 60);
        persons[1] = name("Arpreet", "Singh", 20);
        persons[2] = name("Mohammed", "Sherrif", 50);
    }
    
    function getStruct(uint _index) public view returns (bytes32 gName, bytes32 fName, uint8 a){
        name _______ _individual = persons[______];
            return(_individual.givenName, _individual.familyName, _individual.age);
    }

    function getSlot(uint _index) public view returns (uint slotA, uint slotP, uint slotB){
        name _______ _individual = persons[______];
        
        assembly{
          : 
        }
    }
}

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract called {
        
        uint256 public counter;

        function increment() public {
                counter++;
        }

        function decrement() public {
                counter--;
        }
}

contract caller {
        //insert the line below to make the callerCounter the slot 0 and not the calledAddress
        //uint public callerCounter;
        uint public constant callerCounter = 10;
        address public calledAddress;

        constructor(address _calledAddress){
                calledAddress = _calledAddress;
        }
        
        function callIncrement() public {
                (bool success, ) = calledAddress.call(abi.encodeWithSignature("increment()"));
                require(success, "call failed");
        }      

        function delegateIncrement() public{
                (bool success, ) = calledAddress.delegatecall(abi.encodeWithSignature("increment()"));
                require(success, "delegatecall failed");
        } 

        function getSlot() external pure returns(uint256 slot){
                assembly{ slot := calledAddress.slot}
        }
}        

contract slotAllocation {
        address public addr1;   // = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        bool public bool1;      // = true/01
        uint8 public x1;        // = 10 
        uint8 public x2;        // = 48
        uint256 public ctr0;    // = 32
        address public addr2;   // = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        bytes2 public z;        // = 0x65
        uint8 public ctrU;      // = 128
        uint public x3;         // = 0x512
        uint public constant x=8;
        string public s1;       // = hello

        function getSlot() external pure 
        returns( ... )
        {
                assembly{ 
			:
			:
               }
        }
}

/*
Completely incorrect 
 - callIncrement is fine and works
 - delegatecall doesn't since the context has switched to caller contract and it increments slot 0, 
 which is the calledAddress. This subsequently fails the rest of the code.
 */

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract called {
        uint256 public counter;
        function increment() public {
                counter++;
        }
}

contract caller1 {
        address public calledAddress;

        constructor(address _calledAddress){
                calledAddress = _calledAddress;
        }
        
        function callIncrement() public {
                (bool success, ) ____________________________________________________________;
                require(success, "call failed");
        }      
}

contract caller2 {
	address public calledAddress;

        constructor(address _calledAddress){
                calledAddress = _calledAddress;
        }
        function delegateIncrement() public{
                (bool success, ) = calledAddress.delegatecall(abi.encodeWithSignature("increment()"));
                require(success, "delegatecall failed");
        } 
}          

/*
Completely incorrect 
 - callIncrement is fine and works
 - delegatecall doesn't since the context has switched to caller contract and it increments slot 0, 
 which is the calledAddress. This subsequently fails the rest of the code.
 */
 
         //insert the line below at line 14 to make the callerCounter the slot 0 and not the calledAddress
        //uint public callerCounter;

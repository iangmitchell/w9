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


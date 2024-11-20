//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract called{
    string public message;
    event received(address, uint256, string);
    fallback() external payable {
        emit received(msg.sender, msg.value, "FB called");
    }
    receive() external payable {
        emit received(msg.sender, msg.value, "RC called");
    }
    function setMessage(string memory _data) public payable {
        message=_data;
        emit received(msg.sender, msg.value, _data);
    }
    function withdraw() public payable {
        address _______ _to = _______ (msg.sender);
        _to.transfer(address(____)._______);
    }
}
contract caller1{
    string public message = "caller1";
    event Response(bool, bytes);
    function callSM(address payable _addr, string memory _msg ) public payable{
	//insert code here
        emit Response(success, data);
    }
    function callRC(address payable _addr) public payable {
	//insert code here
        emit Response(success, data);
    }
    function callFB(address payable _addr) public payable {
	//insert code here	
        emit Response(success, data);
    }
}
contract caller2{
    string public message;
    event Response(bool, bytes);
    fallback() external payable {
        emit Response(true, "FB called");
    }
    receive() external payable {
        emit Response(true, "RC called");
    }
    function callSM(address payable _addr, string memory _msg ) public payable{
        (bool success, bytes memory data) = _addr.delegatecall(abi.encodeWithSignature("setMessage(string)", _msg));
        emit Response(success, data);
    }
    function callRC(address payable _addr) public payable {
        (bool success, bytes memory data) = _addr.delegatecall("");
        emit Response(success, data);
    }
    function callFB(address payable _addr) public payable {
        (bool success, bytes memory data) = _addr.delegatecall(abi.encodeWithSignature("doesNotExist(address)", _addr));
        emit Response(success, data);
    }    
}


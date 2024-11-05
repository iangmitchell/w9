//MyToken Function   
  function transferFromCall(address _owner, address _to, uint _amount) public {
        transferFrom(_owner, _to, _amount);
    }
//ico Function
  function transferTokenCall(uint _amount) public {
        require(____________[__________] > 0, "must contribute");
        (bool _______,) = tokenAddress.call(___________________________________________________________________, _______, ___________ _amount) );
        require(________ "call failed");
	_____________msg.sender] = 0;
    }
  

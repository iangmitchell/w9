:
contract MyToken is ERC20, Ownable {
    constructor(address initialOwner)
        ERC20("MyToken", "MTK")
        Ownable(initialOwner)
    {}

    function mint(_______ to, _______ amount) ______ ____Owner {
        _mint(__, ______);
    }
}

contract ico is Ownable(msg.sender){
    MyToken public token;
    address tokenAddress;
    mapping (address => ____) public contributors;

    constructor (address  _tokenAddress) {
        tokenAddress = _tokenAddress;
        Ownable(msg.sender);
        token = MyToken(_tokenAddress);
    }

    _______() external _______ { }
   
    function exchange( ) external payable {
        require( msg._______ msg.______________, "Insufficient Funds");
        payable(__________________________________; 
        _____________msg.sender] += msg.value; 
    }

    function transferToken(uint _amount) public {
        token.transferFrom(____________________ _amount);
    }
}




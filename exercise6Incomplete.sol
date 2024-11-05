//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
contract Pizza is ERC20, Pausable, AccessControl {
    uint8 public constant decimal = 2;
    uint public constant initialSupply = 1000000;
    bytes32 public constant ADMIN = keccak256("ADMIN");
    bytes32 public constant CUSTOMER = keccak256("CUSTOMER");
    bytes32 public constant CHEF = keccak256("CHEF");
    bytes32 public constant DELIVERER = keccak256("DELIVERER");
    uint8 public constant DELIVER_PRICE = 2;
    uint8 public constant PIZZA_PRICE = 10;
    address public contractAddress;
    address public constant chefAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public constant customerAddress = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    address public constant delivererAddress = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;
    enum STATUS{
        ordered,
        prepared,
        delivered
    }
    enum PIZZA_SIZE{
        small,
        medium,
        large
    }
    enum PIZZA_TYPE{
        americana,
        carbonara,
        margherita,
        napoli,
        mariana,
        quattro,
        romana
    }
    struct order{
        STATUS pizzaState;
        PIZZA_TYPE pizzaType;
        PIZZA_SIZE pizzaSize;
        uint8 price;
    }
    mapping(address => order) public orders; 
    event orderPizza(address customer, order);
    event preparePizza(address chef, order);
    event deliverPizza(address deliverer, order);
    constructor(address defaultAdmin)
        ERC20("PizzaCoin", "PI")
    {
        _mint(msg.sender, initialSupply * 10 ** decimals() );
        contractAddress=address(this);
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _setRoleAdmin(CHEF, DEFAULT_ADMIN_ROLE);
        _setRoleAdmin(CUSTOMER, DEFAULT_ADMIN_ROLE);
        _setRoleAdmin(DELIVERER, DEFAULT_ADMIN_ROLE);
        _grantRole(CHEF, chefAddress);
        _grantRole(CUSTOMER, customerAddress);
        _grantRole(DELIVERER, delivererAddress);
    }
    function pause() public onlyRole(ADMIN) { _pause(); }
    function unpause() public onlyRole(ADMIN) { _unpause(); }
    function decimals() override public pure returns (uint8) { return decimal;  }
    receive() payable external {revert();    }
    function ordered(PIZZA_TYPE _pizzaType, PIZZA_SIZE _pizzaSize) public whenNotPaused onlyRole(CUSTOMER) {
        _createOrder(_pizzaType, _pizzaSize);
        _sendToContract(PIZZA_PRICE);
        emit orderPizza(msg.sender, orders[msg.sender]);
    }
    function prepare(address _customer) public whenNotPaused onlyRole(CHEF)  {
        orders[_customer].pizzaState = STATUS.prepared;
        _withdrawFromContract(orders[_customer].price-DELIVER_PRICE);
        emit preparePizza(msg.sender, orders[_customer]);
    }
    function deliver(address _customer) public whenNotPaused onlyRole(DELIVERER)  {
        orders[_customer].pizzaState = STATUS.delivered;
        _withdrawFromContract(DELIVER_PRICE);
        emit deliverPizza(msg.sender, orders[_customer]);
    }
    function _createOrder(PIZZA_TYPE _pt, PIZZA_SIZE _ps) internal {
        orders[msg.sender].pizzaState = STATUS.ordered;
        orders[msg.sender].pizzaType = _pt;
        orders[msg.sender].pizzaSize = _ps;
        orders[msg.sender].price      = PIZZA_PRICE;
    }
    function _sendToContract(uint256 _amount) internal whenNotPaused {
        require(_amount <= balanceOf(msg.sender), "insufficient funds");
        transfer(address(this), _amount);
    }
    function _withdrawFromContract(uint256 _amount) internal whenNotPaused{
        require(_amount <= balanceOf(address(this)), "insufficient funds");
        (bool success, ) = contractAddress.call(abi.encodeWithSignature("transfer(address,uint256)", msg.sender, _amount));
        require(success, "call to transfer failed");
    }
}


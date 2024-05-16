// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract FundsManager {
    address public owner;

    // Event to log deposit transactions
    event Deposit(address indexed from, uint256 amount);

    // Event to log withdrawal transactions
    event Withdrawal(address indexed to, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict functions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Function to deposit funds into the contract
    function deposit() public payable {
        require(msg.value > 0, "You need to deposit some amount of Ether");
        emit Deposit(msg.sender, msg.value);
    }

    // Function to withdraw funds from the contract
    function withdraw(uint256 _amount) public onlyOwner {
        require(address(this).balance >= _amount, "Insufficient balance in the contract");
        payable(owner).transfer(_amount);
        emit Withdrawal(owner, _amount);
    }

    // Function to check the contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

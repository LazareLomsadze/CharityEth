// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	address public owner;
	address public charity;

	constructor(address _charity) {
		owner = msg.sender;
		charity = _charity;
	}

	receive() external payable { }
	// The address provided to the selfdestruct function gets all of the ether remaining in the contract! Ether sent to the payable constructor will be refunded to the final caller of the tick function.
	function donate() public {
		(bool success, ) = charity.call{ value: address(this).balance }("");
		require(success);
		selfdestruct(payable(msg.sender));
	}

	function tip() public payable {
		(bool success, ) = owner.call{ value: msg.value }("");
		require(success);
	}
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Charity.sol";

contract ContractTest is Test {
    Charity public myContract;
    address msgSender = address(3);
    address charity = address(4);

    function setUp() public {
        vm.prank(msgSender);
        myContract = new Contract(charity);
        address(myContract).call{ value: 4 ether }("");
        myContract.donate();
    }

    function testDonate() public {
        assertEq(charity.balance, 4 ether);
    }

    function testDestruction() public {
        assert(!isContract(address(myContract)));
    }

    function isContract(address _addr) public view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(_addr)
        }
        return (size > 0);
    }
}

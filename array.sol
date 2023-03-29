// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8;

contract myarray{

 uint256 [] public uint256 myarray = [1, 2, 3];
 string[] public stringarray = ["apple", "hello", "how are you"];
 string[] public values;
 uint256 [][] public array2D = [[1, 2, 3],[4, 5, 6]];

function addvalue(string memory _value) public {
    values.push(_value);
}

function valuecount() public view returns (uint256){
    return vaues.length;
}
}


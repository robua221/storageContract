// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageContract {
    uint256 public data;

    function setData(uint256 _data) public {
        data = _data;
    }
}

contract DelegateCallContract {
    address public storageContractAddress;

    constructor(address _storageContractAddress) {
        storageContractAddress = _storageContractAddress;
    }

    function updateData(uint256 _newData) public {
        (bool success, ) = storageContractAddress.delegatecall(
            abi.encodeWithSignature("setData(uint256)", _newData)
        );

        require(success, "Delegate call failed");
    }
}

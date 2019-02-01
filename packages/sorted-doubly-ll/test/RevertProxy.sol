pragma solidity ^0.5.0;


contract RevertProxy {
    bytes data;

    function() external {
        data = msg.data;
    }

    // solium-disable security/no-low-level-calls
    function execute(address _target) external returns (bool) {
        (bool success,) = _target.call(data);
        return success;
    }
}

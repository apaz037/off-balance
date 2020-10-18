pragma solidity ^0.6.0;

interface IWeth {
    function deposit(uint value) external payable;
    function withdraw(uint wad) external;
    function approve(address guy, uint wad) external returns (bool);
    function balanceOf(address owner) external view returns(uint);
}
pragma solidity ^0.6.0;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './IBPool.sol';
import './IWeth.sol';

contract OffBalance {
    IBPool public bPool;
    IERC20 public dai;
    IWeth public weth;

    constructor (address _bPool, address _dai, address _weth) public {
        bPool = IBPool(_bPool);
        dai = IERC20(_dai);
        weth = IWeth(_weth);
    }

    function swapEthForDai(uint daiAmount) external payable {
        weth.deposit({ value: msg.value });
        uint price = 110 * bPool.getSpotPrice(address(weth), address(dai)) / 100;
        uint wethAmount = price * daiAmount;
        weth.approve(address(bPool), wethAmount);
        bPool.swapExactAmountOut(
            address(weth),
            wethAmount, 
            address(dai),
            daiAmount,
            price
            );

        dai.transfer(msg.sender, daiAmount);
        uint wethBalance = weth.balanceOf(address(this));

        if (wethBalance > 0) {
            weth.withdraw(wethBalance);
        }
        msg.sender.transfer(address(this).balance);
    }

    function getSpotPrice() external view returns(uint) {
        return bPool.getSpotPrice(address(weth), address(dai));
    }

    // function deposit(uint daiAmount) external {
    //     uint totalSupply = bPool.totalSupply();
    //     uint daiPoolBalance = dai.balanceOf(_bPool);
    //     dai.approve(address(bPool), daiAmount);
    //     bPool.joinPool(daiAmount * totalSupply / daiPoolBalance, daiAmount);
    // }
}
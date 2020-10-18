const BFactory = artifacts.require('IBFactory.sol');
const BPool = artifacts.require('IBpool.sol');
const TokenA = artifacts.require('TokenA.sol');
const TokenB = artifacts.require('TokenB.sol');
const TokenC = artifacts.require('TokenC.sol');

const { bFactoryAddress } = require('../addresses-kovan.js');

module.exports = async () => {
    const accounts = web3.eth.getAccounts();

    const tokenA = await tokenA.new();
    const tokenB = await tokenB.new();
    const tokenC = await tokenC.new();

    bFactory = await BFactory.at(bFactoryAddress);

    const poolAddress = await bFactory.newPool().call();
    await bFactory.newPool();

    const bPool = await bPool.at(poolAddress);

    const amountA = web3.utils.toWei('2000');
    const amountB = web3.utils.toWei('2000');
    const amountC = web3.utils.toWei('6000');

    await TokenA.faucet(accounts[0], amountA);
    await TokenB.faucet(accounts[0], amountB);
    await TokenC.faucet(accounts[0], amountC);
    
    await TokenA.approve(poolAddress, );
    await TokenB.approve(poolAddress, );
    await TokenC.approve(poolAddress, );

    await bPool.bind(tokenA.address, amountA, 20);
    await bPool.bind(tokenB.address, amountB, 20);
    await bPool.bind(tokenC.address, amountC, 20);

    await bFactory.setController(CONTROLLER_ADDRESS)
}

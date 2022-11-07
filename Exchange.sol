// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title Owner
 * @dev Set & change owner
 */
contract DTCDevMarket {

    address private tokenAddress;
    uint private k = 0;
    uint private totalLiquidityPositions = 0;
    mapping(address => uint) private LiquidityAddresses;

    /**
     * @dev Creates a OMM for the token at the given address 
     */
    constructor(address _tokenContractAddress) {
        console.log("Exchange for ERC20 token contract located at :", _tokenContractAddress);
        tokenAddress = _tokenContractAddress;
    }

    function provideLiquidity(uint _amountERC20Token) public {
      /*
      *Caller deposits Ether and ERC20 token in ratio equal to the current ratio of tokens in the contract
      *and receives liquidity positions (that is:
      *totalLiquidityPositions * amountERC20Token/contractERC20TokenBalance ==
      * totalLiquidityPositions *amountEth/contractEthBalance)
      */
      //Transfer Ether and ERC-20 tokens from caller into contract
      //If caller is the first to provide liquidity, give them 100 liquidity positions
      //Otherwise, give them liquidityPositions =
      //totalLiquidityPositions * amountERC20Token / contractERC20TokenBalance
      //Update K: K = newContractEthBalance * newContractERC20TokenBalance
      //Return a uint of the amount of liquidity positions issued
    }

    function estimateEthToProvide(uint _amountERC20Token) public view returns(uint) {
      /*
      *Users who want to provide liquidity won’t know the current ratio of the tokens in the contract so
      *they’ll have to call this function to find out how much Ether to deposit if they want to deposit a
      *particular amount of ERC-20 tokens.
      */

      /*Return a uint of the amount of Ether to provide to match the ratio in the contract if caller wants
      *to provide a given amount of ERC20 tokens
      *Use the above to get amountEth =
      *contractEthBalance * amountERC20Token / contractERC20TokenBalance)
      */
      return (address(this).balance)*(_amountERC20Token)/(IERC20(tokenAddress).balanceOf(address(this)));
    }

    function estimateERC20TokenToProvide(uint _amountEth) public view returns(uint) {
      /*Users who want to provide liquidity won’t know the current ratio of the tokens in the contract so
      *they’ll have to call this function to find out how much ERC-20 token to deposit if they want to
      *deposit an amount of Ether
      */

      /*Return a uint of the amount of ERC20 token to provide to match the ratio in the contract if the
      *caller wants to provide a given amount of Ether
      *Use the above to get amountERC20 =
      *contractERC20TokenBalance * amountEth/contractEthBalance)
      *getMyLiquidityPositions()
      */

      /*Return a uint of the amount of the caller’s liquidity positions (the uint associated to the address
      *calling in your liquidityPositions mapping) for when a user wishes to view their liquidity positions
      */
      
      return (IERC20(tokenAddress).balanceOf(address(this)))*(_amountEth)/(address(this).balance);
    }

    function withdrawLiquidity(uint _liquidityPositionsToBurn) public returns(uint ERC20Sent, uint ETHSent) {
      require(totalLiquidityPositions > _liquidityPositionsToBurn, "Can not give up all liquitity positions in the market/pool");
      require(LiquidityAddresses[msg.sender] >= _liquidityPositionsToBurn, "Does not have the required amount of liquitity to burn");
      //UNSURE OF ORDER. SHOULD BE CALCULATED USING NEW/OLD K, LIQUIDITY POSITIONS Or BALANCES????
      uint ETHToSend = _liquidityPositionsToBurn * address(this).balance / totalLiquidityPositions;
      uint ERC20ToSend = _liquidityPositionsToBurn * IERC20(tokenAddress).balanceOf(address(this)) / totalLiquidityPositions;
      totalLiquidityPositions -= _liquidityPositionsToBurn;
      LiquidityAddresses[msg.sender] -= _liquidityPositionsToBurn;
      k = (address(this).balance - ETHToSend) * (IERC20(tokenAddress).balanceOf(address(this)) - ERC20ToSend);
      bool success = IERC20(tokenAddress).transfer(msg.sender, ERC20ToSend);
      require(success, "Unable to pay ERC20 to sender");
      ERC20Sent = ERC20ToSend;
      success = payable(msg.sender).send(ETHToSend);
      require(success, "Unable to pay sender");
      ETHSent = ETHToSend;
      return (ERC20Sent, ETHSent);

      /* Caller gives up some of their liquidity positions and receives some Ether and ERC20 tokens in
      *return.
      *Use the above to get
      *amountEthToSend = liquidityPositionsToBurn*contractEthBalance / totalLiquidityPositions
      *and
      *amountERC20ToSend =
      *liquidityPositionsToBurn * contractERC20TokenBalance / totalLiquidityPositions
      */
      
      //Decrement the caller’s liquidity positions and the total liquidity positions
      //Caller shouldn’t be able to give up more liquidity positions than they own
      //Caller shouldn’t be able to give up all the liquidity positions in the pool
      //Update K: K = newContractEthBalance * newContractERC20TokenBalance
      //Transfer Ether and ERC-20 from contract to caller
      //Return 2 uints, the amount of ERC20 tokens sent and the amount of Ether sent
    }

    function swapForEth(uint _amountERC20Token) public returns(uint ETHSent) {
      bool success = IERC20(tokenAddress).transferFrom(msg.sender, address(this), _amountERC20Token);
      require(success, "Unable to transfer ERC20 to contract");
      uint ETHToSend = address(this).balance - (k / (IERC20(tokenAddress).balanceOf(address(this))) );
      require(ETHToSend < address(this).balance , "Insufficient funds to pay ETH");
      success = payable(msg.sender).send(ETHToSend);
      require(success, "Unable to pay sender");
      ETHSent = ETHToSend;
      return ETHSent;
      //Caller deposits some ERC20 token in return for some Ether
      /*
      * hint: ethToSend = contractEthBalance - contractEthBalanceAfterSwap
      * where contractEthBalanceAfterSwap = K / contractERC20TokenBalanceAfterSwap
      */
      //Transfer ERC-20 tokens from caller to contract
      //Transfer Ether from contract to caller
      //Return a uint of the amount of Ether sent
    }

    function estimateSwapForEth(uint _amountERC20Token) public view returns(uint ETHEstimate){
      ETHEstimate = address(this).balance - (k / (IERC20(tokenAddress).balanceOf(address(this)) + _amountERC20Token) );
      return ETHEstimate;
      /*estimates the amount of Ether to give caller based on amount ERC20 token caller wishes to swap
      *for when a user wants to know how much Ether to expect when calling swapForEth
      /*hint: ethToSend = contractEthBalance-contractEthBalanceAfterSwap where contractEthBalanceAfterSwap = K/contractERC20TokenBalanceAfterSwap
      */
      //Return a uint of the amount of Ether caller would receive
      
    }

    function swapForERC20Token() public returns(uint ERC20Sent) {
      uint ERC20ToSend = IERC20(tokenAddress).balanceOf(address(this)) - (k / address(this).balance);
      bool success = IERC20(tokenAddress).transfer(msg.sender, ERC20ToSend);
      require(success, "Unable to transfer ERC20 to caller");
      ERC20Sent = ERC20ToSend;
      return ERC20Sent;
      //Caller deposits some Ether in return for some ERC20 tokens
      //hint: ERC20TokenToSend = contractERC20TokenBalance - contractERC20TokenBalanceAfterSwap
      //where contractERC20TokenBalanceAfterSwap = K /contractEthBalanceAfterSwap
      //Transfer Ether from caller to contract
      //Transfer ERC-20 tokens from contract to caller
      //Return a uint of the amount of ERC20 tokens sent
    }

    function estimateSwapForERC20Token(uint _amountEth) public view returns(uint ERC20Estimate){
      return ERC20Estimate = IERC20(tokenAddress).balanceOf(address(this)) - (k / (_amountEth + address(this).balance));
      /* estimates the amount of ERC20 token to give caller based on amount Ether caller wishes to
      * swap for when a user wants to know how many ERC-20 tokens to expect when calling swapForERC20Token
      */
      /* hint: ERC20TokenToSend = contractERC20TokenBalance - contractERC20TokenBalanceAfterSwap where 
      *  contractERC20TokenBalanceAfterSwap = K /contractEthBalanceAfterSwap
      */
      //Return a uint of the amount of ERC20 tokens caller would receive
    }
}

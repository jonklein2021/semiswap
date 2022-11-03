// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Owner
 * @dev Set & change owner
 */
contract DTCDevMarket {

    int private k = 0;
    int private totalLiquidityPositions = 0;

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

    function estimateEthToProvide(uint _amountERC20Token) public {
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
    }

    function estimateERC20TokenToProvide(uint _amountEth) public {
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
    }

    function withdrawLiquidity(uint _liquidityPositionsToBurn) public {
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

    function swapForEth(uint _amountERC20Token) public {
      //Caller deposits some ERC20 token in return for some Ether
      /*
      * hint: ethToSend = contractEthBalance - contractEthBalanceAfterSwap
      * where contractEthBalanceAfterSwap = K / contractERC20TokenBalanceAfterSwap
      */
      //Transfer ERC-20 tokens from caller to contract
      //Transfer Ether from contract to caller
      //Return a uint of the amount of Ether sent
    }

    function estimateSwapForEth(uint _amountERC20Token) public {
      /*estimates the amount of Ether to give caller based on amount ERC20 token caller wishes to swap
      *for when a user wants to know how much Ether to expect when calling swapForEth
      /*hint: ethToSend = contractEthBalance-contractEthBalanceAfterSwap where contractEthBalanceAfterSwap = K/contractERC20TokenBalanceAfterSwap
      */
      //Return a uint of the amount of Ether caller would receive
    }

    function swapForERC20Token() public {
      //Caller deposits some Ether in return for some ERC20 tokens
      //hint: ERC20TokenToSend = contractERC20TokenBalance - contractERC20TokenBalanceAfterSwap
      //where contractERC20TokenBalanceAfterSwap = K /contractEthBalanceAfterSwap
      //Transfer Ether from caller to contract
      //Transfer ERC-20 tokens from contract to caller
      //Return a uint of the amount of ERC20 tokens sent
    }

    function estimateSwapForERC20Token(uint _amountEth) public {
      /* estimates the amount of ERC20 token to give caller based on amount Ether caller wishes to
      * swap for when a user wants to know how many ERC-20 tokens to expect when calling swapForERC20Token
      */
      /* hint: ERC20TokenToSend = contractERC20TokenBalance - contractERC20TokenBalanceAfterSwap where 
      *  contractERC20TokenBalanceAfterSwap = K /contractEthBalanceAfterSwap
      */
      //Return a uint of the amount of ERC20 tokens caller would receive
    }
}

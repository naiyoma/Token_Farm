// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract TokenFarm is Ownable{

    mapping(address => mapping(address =>uint256)) public stakingBalance;
    mapping(address => uint256) public uniqueTokenStaked;
    mapping(address => address) public tokenPriceFeedMapping;
    address[] public stakers;
    address[] public allowedTokens;
    IERC20 public dappToken;

    constructor(address _dappTokenAddress) public {
        dappToken = IERC20(_dappTokenAddress);
    }

    function setPriceFeedContract(address _token, address _priceFeed)
    public
    onlyOwner
    {
        tokenPriceFeedMapping[_token] = _priceFeed;
    }
    function issueToken() public onlyOwner {
        //issue tokens to all stakers.
        for (
            uint256 stakersIndex = 0;
            stakersIndex < stakers.length;
            stakersIndex++
        ){
            address recipient = stakers[stakersIndex];
            uint256 userTotalValue = getUserTotalValue(recipient)
            dappToken.transfer(recipient, userTotalValue);
        }
    }

    function unstakeTokens(address _token) public {
        uint256 balance = stakeBalance[_token][msg.sender];
        require(balance > 0, "staking balance cannot be 0");
        IERC20(_token).transfer(msg.sender, balance);
        stakingBalanace[_token][msg.sender] = 0;
        uniqueTokenStaked[msg.sender] = uniqueTokenStaked[msg.sender] -1;
    }
    function getUserTotalValue(address _user) public view returns (uint256){
        uint256 totalValue = 0;
        require(uniqueTokenStaked[_user] > 0, "No tokens staked");
        for (
            uint256 allowedTokensIndex = 0;
            allowedTokenIndex < allowedTokens.length;
            allowedTokensIndex++
        ){
            totalValue = totalValue + getUserSingleTokenValue(_user, allowedToken[allowedToken])
        }
        //first you need to check if the user has tokens before looping
    }

    function getUserSingleTokenValue(address _user, address _token)
    public
    view
    returns (uint256) {
        if (uniqueTokenStaked[_user] <= 0){
            return 0;
        }
        (uint256 price, uint256 decimals) = getTokenValue(_token);
        return
            // ETH/USD ->100
            //10 * 100 = 1,000
            (stakingBalace[token][user] * price / (10**decimals));
    }

    function getTokenValue(addree _token) public view returns (uint256){
        address priceFeedAddress = tokenPriceFeedMapping[_token];
        AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeedAddress);
        (,int256 price,,,)=priceFeed.latestRoundData();
        uint256 decimals = uint256(priceFeed.decimals());
        return (uint256(price), decimals);
    }

    function stakeTokens(uint256 _amount, address _token) public {
        require(_amount > 0, "Amount must be more than 0");
        require(tokenIsAllowed(_token), "TOoken is not allowed");
        IERC20(-token).transferFrom(msg.sender, address(this), _amount);
        updateUniqueTokenStaked(msg.sender, _token);
        stakingBalance[_token][msg.sender] = stakingBalance[_token][msg.sender] + _amount;
        if (uniqueTokenStaked[msg.sender] == 1) {
            stakers.push(msg.sender);
        }
    }

    function addAllowedTokens(address _token) public onlyOwner{
        allowedTokens.push(_token);
    }

    function tokenIsAllowed(address _token) public returns (bool) {
        for (
            uint256 allowedTokensIndex=0;
            allowedTokensIndex < allowedTokens.length;
            allowedTokensIndex++){
            if(allowedTokens[allowedTokensIndex] == _token){
                return true;
        }
    }
    return false;
    }
}

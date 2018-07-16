//KMC_coin ico
pragma solidity ^0.4.22;

contract KMC_ico {
    
    //introducing maximum number of KMC coins available for sale
    uint public max_KMC = 1000000; //one million KMC_coins available
    
    //conversion rate for KMC/USD
    uint public usd_to_KMC = 1;
    
    //total number of coins purchased by investors
    uint public total_KMC_bought = 0;
    
    //mapping investors address to equity in USD and KMC coin
    mapping(address => uint) equity_KMC;
    mapping(address => uint) equity_usd;
    
    //checking if an investor can buy a KMC coin
    modifier can_buy_KMC_coins(uint usd_invested) {
        require((usd_invested * usd_to_KMC + total_KMC_bought) <= max_KMC);
        _;
    }
    
    //get the equity in KMC coins of an investor
    function equity_in_KMC_coins(address investor) external constant returns (uint) {
        return equity_KMC[investor];
    }
    
    //get the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }
    
    // Buying KMC coins
    function buy_KMC_coins(address investor, uint usd_invested) external can_buy_KMC_coins(usd_invested) {
        uint KMC_bought = usd_invested * usd_to_KMC;
        equity_KMC[investor] += KMC_bought;
        equity_usd[investor] = equity_KMC[investor] / 1000;
        total_KMC_bought += KMC_bought;
    }

    // Selling KMC coins
    function sell_KMC_coins(address investor, uint KMC_sold) external {
        equity_KMC[investor] -= KMC_sold;
        equity_usd[investor] = equity_KMC[investor] / 1000;
        total_KMC_bought -= KMC_sold;
    }
}
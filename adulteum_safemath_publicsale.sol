pragma solidity ^0.4.24;
import "./adulteum.sol";




/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
    if (a == 0) {
      return 0;
    }
    c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    // uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return a / b;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
    c = a + b;
    assert(c >= a);
    return c;
  }
}




contract publicsale
{
    using SafeMath for uint256;
    uint256 number_of_tokens;
    address public tokenobj;
    uint256 rate;
    bool pause_status;
    address owner;
    
    constructor(address tokenaddress,uint256 rate_per_ether)
    {
        owner = msg.sender;
       rate=rate_per_ether;
        tokenobj=tokenaddress;
       
    }
    
    function validate_purchase(uint256 xyz) private returns(uint256){
        uint256 normal_rate =xyz*rate;
    
        if(xyz<1 ether){
         
            uint256 a = normal_rate.mul(125);
            
            return a.div(100);
        
            
        }
        else if(xyz>= 1 ether && xyz < 3 ether){
            
             uint256 c = normal_rate.mul(145);
            
            return c.div(100);
            
            
        }
        else if(xyz>= 3 ether && xyz < 5 ether){
            
              uint256 e = normal_rate.mul(165);
            
           
            return e.div(100);
            
        }
        else if(xyz>= 5 ether){
             uint256 g = normal_rate.mul(185);
            
           
            return g.div(100);
            
        }
    }
    
    function pasuse_sale() public {
        require(msg.sender == owner);
        
        pause_status = true;
    }
     function unpasuse_sale() public {
        require(msg.sender == owner);
        
        pause_status = false;
    }
    function() payable public{
         
         uint256 amount;
         require(msg.value>0.49 ether&&pause_status==false);
        
            amount = validate_purchase(msg.value);
            address cust= msg.sender;
            ADULTEUM(tokenobj).transfer(cust,amount);
      
    }
    

}

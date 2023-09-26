
//ERC-20 Token Code in Solidity

//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

// // ------
// EIP-20: ERC-20 Token Standard
// https://eips.ethereum.org/EIPS/eip-20
//
interface ERC20Interface {
function totalsupply() external view returns (uint);
function balanceof (address tokenOwner) external view returns (uint balance); 
function transfer (address to, uint tokens) external returns (bool success);
function allowance (address tokenOwner, address spender) external view returns (uint remaining);
function approve(address spender, uint tokens) external returns (bool success);
function transferFrom(address from, address to, uint tokens) external returns (bool success);
event Transfer (address indexed from, address indexed to, uint tokens);
event Approval (address indexed tokenowner, address indexed spender, uint tokens);
}
contract Block is ERC20Interface{
string public name="Block";//name of the token
string public symbol ="BLK";
string public decimal="0";
uint public override totalsupply;
address public founder;
mapping (address=>uint) public balances;
mapping (address=>mapping (address=>uint)) allowed;


 constructor (){
    totalsupply=100000;
    founder = msg.sender;
    balances [founder]=totalsupply;
    }
    function balanceof (address tokenowner) public view override returns (uint balance){
    return balances [tokenOwner];
  }

    function transfer (address to, uint tokens) public override returns (bool success) {
        require (balances[msg.sender] >=tokens);
        balances [to]+=tokens; //balances [to]-balances [to]+tokens;
        balances[msg.sender]-=tokens;
        emit Transfer (msg.sender, to, tokens);
        return true;
    }

    function approve(address spender,uint tokens) public override returns (bool success){
        require(balances[msg.sender]>=tokens);
        require(tokens>0);
        allowed[msg.sender][spender]=tokens;
        emit Approval(msg.sender,spender,tokens);
        return true;
    }


    function allowance (address tokenowner, address spender) public view override returns (uint noofTokens) {
    return allowed[tokenowner][spender];
    }

     function transferFrom (address from, address to,uint tokens) public override returns (bool success) {
        require(allowed[from][to]>=tokens);
        require(balances[from]>=tokens);
        balances[from]-=tokens;
        balances[to]+=tokens;
        return true;
    }
 }

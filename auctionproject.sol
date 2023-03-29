pragma solidity ^0.8;
//pragma experimental ABIEncoderV2;
 
  library safemath{
      function safeAdd(uint a, uint b) public pure returns (uint c){
        require(c>=a);
          c= a +b;
      }
      function safeSub(uint a, uint b) public pure returns (uint c){
          require(b<=a);
          c = a - b;
      }
      function safeMul( uint a , uint b) public pure returns (uint c){
          c= a*b;
          require(a==0||c/a==b);
      }
      function safeDiv(uint a, uint b) public pure returns (uint c){
          requir(b>0),
          c = a/b;
      }

  }

  using safemath for uint;
  enum Auction_State{
      created,
      live,
      closed
  }
  enum Bid_State{
      Placed,
      accepted
  }
  struct Auction{
      string Auction_ID;
      address Auction_Owner;
      uint256 Highest_Bid;
      uint256 Auction_start_date;
      uint256 Auction_expiry_date;
      bool Auction_is_live;
      address top_bidder;
      uint256 Auction_index;
      Auction_Manager.Auction_State state;
  }
 struct Bid{
     string Bid_ID;
     string Auction_ID;
     string payable_date;
     address bid_owner;
     uint256 bid_val;
     bool bid_accepted;
 }
 mapping(uint=>Auction) public Auction;
 mapping(uint=> Bid[])  public Bid;
 mapping(address=>uint) balances;

 modifier onlyAuctionOnwer(uint_Auction_index){
     require(msg.sender== auctions[Auction_index].Auction_Owner, "Only auction owner allowed");
      }
 modifier onlyBidOwner(uint _bid_index, uint _Auction_index){
    require(msg.sender==bids[_Auction_index][_bid_index].bid_owner,"only bid owner is allowed" );

}
 modifier onlyauction_or_BidOwner(uint _bid_index, uint _Auction_index){
     require(msg.sender== auctions[Auction_index].Auction_Owner)||(msg.sender==bids[_Auction_index][_bid_index].bid_owner);
 }

Auction[] auction_list;
uint = Auction_index = 0,
uint = bid_index=0;
function create_auction (string memory Auction_ID) public returns (bool success){
    auction[Auction_index].Auction_ID=_Auction_ID;
    auction[Auction_index].Highest_Bid=0;
    auction[Auction_index].Auction_Owner=msg.sender;
    auction[Auction_index].state= Auction_State.created;
    auction[Auction_index].Auction_start_date= now;
    auction[Auction_index].Auction_expiry_date= now + 10 days ;
    auction[Auction_index].Auction_is_live= true;
    auction[Auction_index].Auction_index = Auction_index;
    _Auction_index++;
    return success = true
}
function read_auction(uint _Auction_index) public view returns(string memory Auction_ID,address Auction_Owner,bool Auction_is_live, uint256 Highest_Bid,Auction_Manager.Auction_State state, uint256 Auction_start_date,uint256 Auction_expiry_date,uint256 Auction_index){
    Auction storage a = auction[_Auction_index]
    return(a._Auction_ID,a.Auction_Owner,a.Highest_Bid,a.state,a.Auction_start_date,a.Auction_expiry_date,a.Auction_is_live,a.Auction_index);
}
function Place_Bid(uint Auction_index, string memory Bid_ID, uint256 bid_val,string memory payable_date) public returns(bool bid_accepted){
    require(auction.[Auction_index].Auction_Owner!= msg.sender, "Auction owner should not bid on own auction");
    require(auction.[_Auction_index].Auction_is_live,"Auction should be live to palce bid");
}

uint=i;
bool exists= false;
for(i=0,i<bids[_Auction_index].length;i++) {
    if (bids[_Auction_index][i].bid_owner==msg.sender){
        require(bids[_Auction_index][i].bid_val<_Bid_Amount,"Bid must be larger than previous");
        exists=true;
        //existsAt=i;
        break;
    
    }
}

if (existes==true){
    bids[_Auction_index][i].bid_val=_Bid_Amount
}//rebidding
else{
    bids[_Auction_index].push(Bid({
        Bid_ID:_Bid_ID,
        Auction_ID: auctions[_Auction_index].Auction_ID,
        bid_owner: msg.sender,
        bid_val:_Bid_Amount,
        payable_date: payable_date,
        bid_accepted:false
    }));
}

bid_index++;
if (auctions[_Auction_index].Highest_Bid<_Bid_Amount) {
    auctions[_Auction_index].Highest_Bid=_Bid_Amount;
     auctions[_Auction_index].state= Auction_State.live;
    }

    return success=true
    
}
function total_bid(uint _Auction_index)public view onlyAuctionOnwer(_Auction_index)returns(uint){
    return bids[_Auction_index].length;
}
function Read_bid(uint _bid_index,uint _Auction_index)public view onlyauction_or_BidOwner(_bid_index,_Auction_index)returns(string Bid_ID,string Auction_ID,string payable_date,address bid_owner,uint256 bid_val,bool bid_accepted){
    Bid storage b = bids[_Auction_index][_bid_index];
    return b;
}
function readallbida(uint _Auction_index)public view onlyAuctionOnwer(_Auction_index)returns(Bid[]memory){
    return bids[_Auction_index];
}
function accepted_bid(uint _bid_index ,uint _Auction_index)public onlyAuctionOnwer(_Auction_index){
   bids[_Auction_index][_bid_index].bid_accepted=true;
   auctions[_Auction_index].state=Auction_State.closed;
   auctions[_Auction_index].Auction_is_live=false;

}
function close_auction(uint _Auction_index)public onlyAuctionOnwer(_Auction_index)returns(bool success){
     require(now>auctions[_Auction_index].Auction_start_date);
     auctions[_Auction_index].state= Auction_State.closed;
     auctions[_Auction_index].Auction_is_live=false;
     return success=true;

}
function Repay_Auction(uint _bid_index, uint _Auction_index)payable public onlyBidOwner(_bid_index,_Auction_index)returns(bool success){
    require(msg.value==bids[_Auction_index][_bid_index].Bid_val);
    require(bids[_Auction_index][_bid_index].bid_accepted=true);
    address Auc_owner=auctions[_Auction_index].Auction_Owner;
    //please add transfer of send here
    return success=true
}


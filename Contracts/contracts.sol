pragma solidity ^0.4.2;
contract Lottery {

      struct Ticket {
       address adr;
       uint256 number1;
       uint256 number2;
    }

      struct Winners {
          address adr;
      }

    address public owner;
    Ticket[] public tickets;
    uint public total_tickets;
    uint public ticket_price;
    uint public betting_period;
    uint public waiting_period;
    uint public total_winners;
    bool public betsclosed;
    uint public tickets_init;
    uint public total_pool;
    uint public next_round;
    uint256 moment_now;
    uint256 moment_closes;
    uint256 moment_lottery;
    uint256 count_down;

    Winners[] public winners;


    function Lottery(uint _betting_period, uint _waiting_period) {
      ticket_price = 0.1 ether;
      total_tickets = 0;
      tickets_init = 0;
      owner = msg.sender;
      moment_now = now;
      moment_closes = moment_now +2 minutes;
      moment_lottery = moment_now + 1 minutes;


    }

    function create_ticket(uint256 n1, uint256 n2){
      tickets.push(Ticket({
          adr: msg.sender,
          number1: n1,
          number2: n2
      }));
      total_tickets += 1;

    }

        function buy_ticket(uint256 n1, uint256 n2) public payable {
      require(msg.value == ticket_price);
    //   require(0 > n1 && n1  <= 11);
    //   require(0 > n2 && n2  <= 11);
      require(betsclosed == false);
      create_ticket(n1,n2);
      total_pool += msg.value;
   }

    function reset_tickets() private {
      total_tickets = 0;
    }


      function closeBets(){
        if(now >= moment_closes){
          betsclosed = true;
        }
      }

      function random() private view returns (uint8) {
        // return uint8(uint256(keccak256(block.timestamp, block.difficulty))%251);
        return uint8(uint256(keccak256(block.timestamp, block.difficulty))%1000);
      }


      function Check_results(uint256 number1, uint256 number2){

        uint256 total_winners = 0;
        for (uint i = 0; i< tickets.length-tickets_init; i++){
          if((tickets[i].number1==number1 && tickets[i].number2==number2) || (tickets[i].number2==number1 && tickets[i].number1==number2)){
              winners.push(Winners({
                  adr: tickets[i].adr
              }));

              total_winners++;
          }
        }

        Pay_winners();
      }



      function Pay_winners(){

             require(total_winners!=0 );

             uint256 ShareAmmount = (total_pool * 85)/100;
             next_round = (total_pool * 10)/100;
             owner.transfer(total_pool-ShareAmmount-next_round);
             uint256 EachAmmount = ShareAmmount / winners.length;
            //  for(uint256 j = 0; j < total_winners-1; j++){
            //     winners[j].transfer(EachAmmount);
            // }


            Reset_pool();
      }


      function Reset_pool(){
        if(winners.length != 0){
            total_pool= next_round;
        }

        delete winners;
        tickets_init = tickets.length;
        total_winners = 0;
        betsclosed = false;
        moment_now = block.timestamp;
        moment_closes = block.timestamp +  2 minutes;
        moment_lottery = moment_closes + 1 minutes;

      }

      function StartLottery() public returns (uint256,uint256){
          if(now >= moment_lottery)
          {
            var number1 = 1;
            var number2 = 4;
            Check_results(number1,number2);
            // return (number1,number2);
          }

      }






}

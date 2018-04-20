
      function closeBets(){
        if(now >= moment_closes){
          betsclosed = true;
        }
      }

      function random() private view returns (uint8) {
        return uint8(uint256(keccak256(block.timestamp, block.difficulty))%251);
      }

      function StartLottery() private returns (uint256,uint256){
          if(now >= moment_lottery)
          {
            var number1 = random();
            var number2 = random();
            return ;
          }

      }

      function Check_results(){
        uint256 total_winners = 0;
        for (uint i = 0; i< tickets.length-tickets_init; i++){
          if((tickets[i].ticket.number1==number1 && tickets[i].ticket.number2==number2) || (tickets[i].ticket.number2==number1 && tickets[i].number1==number2)){
              winners.push(tickets[tickets_init].tickets[i].ticket.adr);
              total_winners++;
          }
        }
      }

      function Pay_winners(){

             require(total_winners!=0 );
             uint256 ShareAmmount = 0.85*total_pool;
             next_round = 0.1*total_pool;
             owner.transfer(total_pool-ShareAmmount-next_round);
             uint256 EachAmmount = ShareAmmount / winners.length;
             for(uint256 j = 0; j < total_winners-1; j++){
                winners[j].transfer(EachAmmount);
             }

      }

      function Reset_pool(){
        
        delete winners
        total_winners = 0
        betsclosed = false;
        moment_now = block.timestamp;
        moment_closes = block.timestamp +  2 minutes;
        moment_lottery = moment_closes + 3 minutes;

      }

      struct Ticket {
       address adr;
       uint256 number1;
       uint256 number2;
    }  
    
    Ticket[] public tickets;
    uint public total_tickets;
    
    function Lottery(uint _betting_period, uint _waiting_period) {
      ticket_price = 0.1 ether;
      betting_period = _betting_period;
      waiting_period = _waiting_period;
      total_tickets = 0;
      reset_tickets();
    }
    
    function create_ticket(uint256 n1, uint256 n2){
      tickets.push(Ticket({
          msg.sender,
          number1: n1,
          number2: n2
      }));
      total_tickets += 1;
      
    }
    
    function reset_tickets() private {
      total_tickets = 0;
    }

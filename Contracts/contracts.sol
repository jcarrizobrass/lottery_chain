pragma solidity ^0.4.2;


contract LotteryChain {

      // Events
      event But_ticket(address _user);
      event Transfer(address indexed from, address indexed to, uint256 value);

      //Ticket price
      uint public precio;

      //lottery start day
      uint public dia_inicio;

      //lottery total tickets sell
      uint public total_tickets;

      mapping(uint => uint) public lista_tickets;

      function LotteryChain(uint _dia_inicio) {
        precio = 0.001 ether;
        dia_inicio = _dia_inicio;
        reset_tickets();
      }

      function reset_tickets() private {
      total_tickets = 0;
      }

      function agregar_ticket(uint guess, address _user) private {

    }
      fuction comprar_ticket(adress _from, uint _value) internal {
        // check payment is correct
        if (msg.value != precio) throw;
        // Check if the sender has enough
        require(balanceOf[_from] >= precio);
        // Check for overflows
        require(balanceOf[lottery_address] + _value > balanceOf[lottery_address]);
        // Subtract from the sender
        balanceOf[_from] -= precio;
        // Add the same to the recipient
        balanceOf[lottery_address] += precio;
        Transfer(_from, lottery_address, precio);

        insert_bet(guess, msg.sender);
        Buy_ticket(msg.sender);
      }





}

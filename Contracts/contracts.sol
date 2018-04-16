pragma solidity ^0.4.2;


contract LotteryChain {

      // Events
      event But_ticket(address _user);
      event Transfer(address indexed from, address indexed to, uint256 value);
      mapping(uint => uint) public lista_tickets;
      mapping (address => uint256) public balanceOf;
      mapping (address => mapping (address => uint256)) public allowance;
      //Ticket price
      uint public precio;
      address public bank;

      //lottery start day
      uint public dia_inicio;
      mapping(uint => address[]) public tickets;

      //lottery total tickets sell
      uint public total_tickets;


    function _transfer(address _from, address _to, uint _value) internal {
        // Prevent transfer to 0x0 address. Use burn() instead
        require(_to != 0x0);
        // Check if the sender has enough
        require(balanceOf[_from] >= _value);
        // Check for overflows
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        // Save this for an assertion in the future
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        // Subtract from the sender
        balanceOf[_from] -= _value;
        // Add the same to the recipient
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        // Asserts are used to use static analysis to find bugs in your code. They should never fail
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }

        function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }


    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= allowance[_from][msg.sender]);     // Check allowance
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }



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
      function comprar_ticket(uint guess, address _from, uint _value) internal {
        // check payment is correct
        if (msg.value != precio) throw;

        // Subtract from the sender
        transfer(bank, _value);
        tickets[guess].push(_from);

        total_tickets += 1;
        // Add the same to the recipient

        //insert_bet(guess, msg.sender);
        //Buy_ticket(msg.sender);
      }

}

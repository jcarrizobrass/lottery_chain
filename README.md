# lottery_chain

### Intructions are based on the tutorial shown on School of AI from Siraj.

Course Team: 
	Javier Carrizo  -
	Joaquín Ugarte -
	Máximo Gazitúa
	



#Install and run ganache

If you don't have ganache-cli on your computer, simply install using npm:

$ npm install -g ganache-cli
Then, run your RPC client, it will run and listen to the remote call on port 8545

$ ganache-cli
Ganache CLI v6.1.0 (ganache-core: 2.1.0)

Listening on localhost:8545 


#Connect Remix with ganache

It's ready for your RPC client, now you need to connect your smart contract from Remix for the sake of convenience.

1. Open remix on your browser and go to http://remix.ethereum.org/#optimize=false&version=builtin

2. Create a new file called lottery.sol

3. Copy and paste solidity code at the end of the HTML file.

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
		uint public total_winners;
		bool public betsclosed;
		uint public tickets_init;
		uint public total_pool;
		uint public next_round;

		uint256 public last_number1;
		uint256 public last_number2;
		uint public last_total_winners;
		/* uint256 moment_closes;
		uint256 moment_lottery; */
		uint256 count_down;

		Winners[] public winners;


		function Lottery(uint _moment_closes){
			ticket_price = 0.1 ether;
			total_tickets = 0;
			total_winners = 0;
			tickets_init = 0;
			owner = msg.sender;

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
			require(betsclosed == false);
			create_ticket(n1,n2);
			total_pool += msg.value;

	 }

		function reset_tickets() private {
			total_tickets = 0;
		}


			function closeBets(){
				if(msg.sender == owner){
					betsclosed = true;
				}
			}

			function random12() public returns(uint256){
				 last_number1 =  uint256(uint8(((uint256(keccak256(block.timestamp, block.difficulty))%251)*11)/256));
				 return last_number1;
			}
			function random11(uint256 rand_val) public returns(uint256) {
				 last_number2 = uint256(uint8(((uint256(keccak256(block.timestamp, block.difficulty,rand_val))%251)*11)/256));
				 return last_number2;
			}



			function Check_results(uint256 number1, uint256 number2){
				for (uint i = tickets_init; i< tickets.length; i++){
					if((tickets[i].number1==number1 && tickets[i].number2==number2) || (tickets[i].number2==number1 && tickets[i].number1==number2)){
							winners.push(Winners({
									adr: tickets[i].adr
							}));

							total_winners+=1;
					}
				}
				Pay_winners();
				}


			function Pay_winners(){

						 if(total_winners!=0 ){
															uint256 ShareAmmount = (total_pool * 85)/100;
						 next_round = (total_pool * 10)/100;
						 owner.transfer(total_pool-ShareAmmount-next_round);
						 uint256 EachAmmount = ShareAmmount / winners.length;
						 for(uint256 j = 0; j < total_winners; j++){
								winners[j].adr.transfer(EachAmmount);
						}

						last_total_winners=total_winners;

						 }
						 else {
								 next_round = total_pool;
						 }


						Reset_pool();
			}

			function Reset_pool(){
				if(winners.length != 0){
						total_pool= next_round;
				}
				delete winners;
				tickets_init+=total_tickets;
				total_tickets=0;
				total_winners = 0;
				betsclosed = false;
				/* moment_closes = block.timestamp +  2 minutes;
				moment_lottery = moment_closes + 1 minutes; */

			}

			function StartLottery(uint256 seed1, uint256 seed2){
					if(msg.sender==owner)
					{
						/* var number1 = 5; */
						//var number2 = 4;
						last_number1 = random11(seed2);
						last_number2 = random11(seed1);
						Check_results(last_number1,last_number2);
					}

			}


}

4. Connect remix with ganache by select Run > Web3Provider > OK for "Are you sure you want to connect to an Ethereum node?"

In case of error "Make sure the provider is running and a connection is open (via IPC or RPC)"
It can be resolved by changing https to http http://remix.ethereum.org/#optimize=false&version=builtin

5. Open lottery.html file on your browser and follow your heart...
interface evm_interface( clk,rst);
	logic clk;
	logic rst;
	logic vote_candidate_1;
	logic vote_candidate_2;
	logic vote_candidate_3;
	logic switch_on_evm;        
	logic candidate_ready;
	logic voting_session_done;
	logic [1:0] display_results;
	logic display_winner;

	logic [1:0] candidate_name;
	logic invalid_results;
	logic [`WIDTH-1:0] results;
	logic voting_in_progress;
	logic voting_done;

	clocking drv_cb @(posedge clk);
		 output rst,
		 vote_candidate_1,
		 vote_candidate_2,
		 vote_candidate_3,
		 switch_on_evm,         
		 candidate_ready,
		 voting_session_done,
		 display_results,
		 display_winner;
	endclocking

	clocking mon_cb @(posedge clk);
		 input rst,
		 vote_candidate_1,
		 vote_candidate_2,
		 vote_candidate_3,
		 switch_on_evm,         
		 candidate_ready,
		 voting_session_done,
		 display_results,
		 display_winner,

		 candidate_name,
		 invalid_results,
		 results,
		 voting_in_progress,
		 voting_done;
	endclocking
	
	modport drv_mod(clocking drv_cb);
	modport mon_mod(clocking mon_cb);
endinterface

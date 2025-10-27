interface Evm_intercase(input clk,rst);
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
	logic [WIDTH-1:0] results;
	logic voting_in_progress;
	logic voting_done;
	clocking drv_cb
		@(posedge clk);
		output rst,
		output vote_candidate_1,
		output vote_candidate_2,
		output vote_candidate_3,
		output switch_on_evm,         
		output candidate_ready,
		output voting_session_done,
		output display_results,
		output display_winner,
	endclocking
	clocking mon_cb
		@(posedge clk);
		input rst,
		input vote_candidate_1,
		input vote_candidate_2,
		input vote_candidate_3,
		input switch_on_evm,         
		input candidate_ready,
		input voting_session_done,
		input display_results,
		input display_winner,

		input candidate_name;
		input invalid_results;
		input results;
		input voting_in_progress;
		input voting_done;
	endclocking
	modport drv_mod(clocking drv_cb);
		modport mon_mod(clocking mon_cb);
endinterface

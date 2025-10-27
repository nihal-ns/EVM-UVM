program evm_assertion (clk, rst, vote_candidate_1, vote_candidate_2, vote_candidate_3, switch_on_evm, candidate_ready, voting_session_done, display_results, display_winner, candidate_name, invalid_results, results, voting_in_progress, voting_done);

	input clk, rst;
	input vote_candidate_1, vote_candidate_2, vote_candidate_3;
	input switch_on_evm;
	input candidate_ready;
	input voting_session_done;
	input display_results; // width
	input display_winner;

	output candidate_name; // width
	output invalid_results; 
	output results; // width 
	output voting_in_progress;
	output voting_done;
	
	property pro1;
		@(posedge clk) !rst |-> (!invalid_results	&& !voting_in_progress && voting_done ; //candidate_name and results pending
	endproperty


endprogram: evm_assertion

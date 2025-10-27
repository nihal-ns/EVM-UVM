program evm_assertion (clk, rst, vote_candidate_1, vote_candidate_2, vote_candidate_3, switch_on_evm, candidate_ready, voting_session_done, display_results, display_winner, candidate_name, invalid_results, results, voting_in_progress, voting_done);

	input clk, rst;
	input vote_candidate_1, vote_candidate_2, vote_candidate_3;
	input switch_on_evm;
	input candidate_ready;
	input voting_session_done;
	input [1:0] display_results;
	input display_winner;

	input [1:0] candidate_name; 
	input invalid_results; 
	input [`WIDTH-1:0] results; 
	input voting_in_progress;
	input voting_done;
		
	// Reset check
	property pro1;
		@(posedge clk) !rst |-> (!invalid_results	&& !voting_in_progress && !voting_done && !candidate_name && !results);
	endproperty

	// isunknown check for inputs
	property pro2_1;
		@(posedge clk) disable iff(!rst) |-> ($isunknown(vote_candidate_1, vote_candidate_2, vote_candidate_3, switch_on_evm, candidate_ready, voting_session_done, display_results, display_winner)); 
	endproperty	

	// isunknown check for outputs
	property pro2_2;
		@(posedge clk) disable iff(!rst) |-> ($isunknown(candidate_name, invalid_results, results, voting_in_progress, voting_done));
	endproperty

	// voting in progress check
	property pro3;
		@(posedge clk) disable iff (!rst) candidate_ready |=> voting_in_progress until voting_done; // should check again
	endproperty

	// voting done check
	property pro4; 
		@(posedge clk) disable iff (!rst) voting_session_done |=> voting_done; 
	endproperty

	// display result check
	property pro5;
		@(posedge clk) disable iff (!rst) (display_results == 2'b00) |=> (candidate_name == 2'b00) || (display_results == 2'b01) |=> (candidate_name == 2'b01) || (display_results == 2'b10) |=> (candidate_name == 2'b10) 
	endproperty

	// invalid result check
	property pro6;
		@(posedge clk) disable iff (!rst) ($countones({vote_candidate_1, vote_candidate_2, vote_candidate_3}) > 1) |=> invalid_results; 
	endproperty

	reset_check: assert property(pro1)
		/* $info("Reset check passed"); */
	else
		$error("Reset check failed");

	isunknown_input_check: assert property(pro2_1)
		/* $info("All inputs are known signals"); */
	else
		$error("Assertion failed, inputs are unknown");

	isunknown_output_check: assert property(pro2_2)
		/* $info("All outputs are known signals"); */
	else
		$error("Assertion failed, outputs are unknown");

	progress_check: assert property(pro3)
		/* $info("Assertion passed, progress is proper"); */
	else
		$error("Assertion failed, voting_in_progress did not stay high until voting_done")

	voting_done_check: assert property(pro4)
		/* $info("Assertion passed, voting done transaction is proper"); */
	else
		$error("Assertion failed, voting done is not asserted");

	result_check: assert property(pro5)
		/* $info("Assertion passed, proper candidate names are displayed"); */
	else
		$error("Assertion failed, invalid candidate names");

	invalid_result_check: assert property(pro6)
		/* $info("Assertion passed, no multi vote is casted"); */
	else
		$error("Assertion failed, invalid result is not asserted");
endprogram: evm_assertion

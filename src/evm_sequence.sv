class evm_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_sequence)

	function new(string name = "evm_sequence");
		super.new(name);
	endfunction

	virtual task body();
		req = evm_seq_item::type_id::create("req");
		wait_for_grant();
		req.randomize();
		send_request(req);
		wait_for_item_done();	
	endtask
endclass

//-----------------------------------------------------------------------------------------------------------------------------
// Candidate vote count (c1 wins)
class evm_c1_win_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_c1_win_sequence)

	function new(string name = "evm_c1_win_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		repeat(20)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} dist {1:=7, 2:=2, 4:=1}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;);
	endtask
endclass
//-----------------------------------------------------------------------------------------------------------------------------
// Random candidate wins
class evm_rand_win_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_rand_win_sequence)

	function new(string name = "evm_rand_win_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		repeat(20)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} inside {1, 2, 4}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;);
	endtask
endclass
//-----------------------------------------------------------------------------------------------------------------------------
// Top 2 tie invalid
class evm_tie_max_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_tie_max_sequence)

	function new(string name = "evm_tie_max_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 4; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 1; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;);
	endtask
endclass
//-----------------------------------------------------------------------------------------------------------------------------
// Min 2 tie not invalid
class evm_tie_min_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_tie_min_sequence)

	function new(string name = "evm_tie_min_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 4; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {vreq.ote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 1; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		repeat(11)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 2; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;);
	endtask
endclass
//-----------------------------------------------------------------------------------------------------------------------------
// Sudden EVM off (EVM turns off mid voting)
class evm_off_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_off_sequence)

	function new(string name = "evm_off_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		repeat(2)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} dist {1:=7, 2:=2, 4:=1}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
			`uvm_do_with(req,{req.switch_on_evm == 0; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
	endtask
endclass
//-----------------------------------------------------------------------------------------------------------------------------
// Sudden voting done
class evm_sudden_done_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_sudden_done_sequence)

	function new(string name = "evm_sudden_done_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} dist {1:=7, 2:=2, 4:=1}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1}} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} dist {1:=7, 2:=2, 4:=1}; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});
	endtask
endclass

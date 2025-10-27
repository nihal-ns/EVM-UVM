class Evm_sequence extends uvm_sequence #(Evm_seq_item);
	`uvm_object_utils(Evm_sequence)

	function new(string name = "Evm_sequence");
		super.new(name);
	endfunction

	virtual task body();
		req = Evm_seq_item::type_id::create("req");
		wait_for_grant();
		req.randomize();
		send_request(req);
		wait_for_item_done();	
	endtask
endclass

//-----------------------------------------------------------------------------------------------------------------------------
// Candidate vote count (c1 wins)
class Evm_c1_win_sequence extends uvm_sequence #(Evm_seq_item);
	`uvm_object_utils(Evm_c1_win_sequence)

	function new(string name = "Evm_c1_win_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		repeat(20)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1} dist {1:=7, 2:=2, 4:=1}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;);
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 1;);
	endtask
endclass
//-----------------------------------------------------------------------------------------------------------------------------
// Random candidate wins
class Evm_rand_win_sequence extends uvm_sequence #(Evm_seq_item);
	`uvm_object_utils(Evm_rand_win_sequence)

	function new(string name = "Evm_rand_win_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		repeat(20)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1} inside {1, 2, 4}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;);
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 1;);
	endtask
endclass
//-----------------------------------------------------------------------------------------------------------------------------
// Top 2 tie invalid
class Evm_tie_max_sequence extends uvm_sequence #(Evm_seq_item);
	`uvm_object_utils(Evm_tie_max_sequence)

	function new(string name = "Evm_tie_max_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1} == 4; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1} == 1; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;);
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 1;);
	endtask
endclass
//-----------------------------------------------------------------------------------------------------------------------------
// Min 2 tie not invalid
class Evm_tie_min_sequence extends uvm_sequence #(Evm_seq_item);
	`uvm_object_utils(Evm_tie_min_sequence)

	function new(string name = "Evm_tie_min_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1} == 4; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1} == 1; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		repeat(11)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; req.{vote_candidate_3, vote_candidate_2, vote_candidate_1} == 2; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;);
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;);
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;  req.{vote_candidate_3, vote_candidate_2, vote_candidate_1}} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 1;);
	endtask
endclass


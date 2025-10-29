class evm_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_sequence)

	function new(string name = "evm_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		req = evm_seq_item::type_id::create("req");
		wait_for_grant();
		req.randomize();
		send_request(req);
		wait_for_item_done();	
	endtask: body
endclass: evm_sequence

//-----------------------------------------------------------------------------------------------------------------------------
// Candidate vote count (c1 wins)
class evm_c1_win_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_c1_win_sequence)

	function new(string name = "evm_c1_win_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		repeat(20)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} dist {1:=7, 2:=2, 4:=1}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;});
	endtask: body
endclass: evm_c1_win_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Random candidate wins
class evm_rand_win_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_rand_win_sequence)

	function new(string name = "evm_rand_win_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		repeat(20)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} inside {1, 2, 4}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;});
	endtask: body
endclass: evm_rand_win_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Top 2 tie invalid
class evm_tie_max_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_tie_max_sequence)

	function new(string name = "evm_tie_max_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 4; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 1; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;});
	endtask: body
endclass: evm_tie_max_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Min 2 tie not invalid
class evm_tie_min_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_tie_min_sequence)

	function new(string name = "evm_tie_min_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 4; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 1; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		repeat(11)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 2; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;});
	endtask: body
endclass: evm_tie_min_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Sudden EVM off (EVM turns off mid voting)
class evm_off_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_off_sequence)

	function new(string name = "evm_off_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		repeat(9)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} dist {1:=7, 2:=2, 4:=1}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
	
			`uvm_do_with(req,{req.switch_on_evm == 0; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 0; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} dist {1:=7, 2:=2, 4:=1}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});

			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
	endtask: body
endclass: evm_off_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Sudden voting done
class evm_sudden_done_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_sudden_done_sequence)

	function new(string name = "evm_sudden_done_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		repeat(10)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} dist {1:=7, 2:=2, 4:=1}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} dist {1:=7, 2:=2, 4:=1}; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});
	endtask: body
endclass: evm_sudden_done_sequence


//-----------------------------------------------------------------------------------------------------------------------------
// Candidate vote count
class evm_count_cast_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_count_cast_sequence)

	function new(string name = "evm_count_cast_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		repeat(25)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} inside {1, 2, 4}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 1; req.display_winner == 0;});
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 2; req.display_winner == 0;});
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;});
	endtask: body
endclass: evm_count_cast_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Cast 2 votes
class evm_double_cast_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_double_cast_sequence)

	function new(string name = "evm_double_cast_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		repeat(3)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} inside {1, 2, 4}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 3; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});


			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 1; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 2; req.display_winner == 0;});

			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;});

	endtask: body
endclass: evm_double_cast_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Vote before ready
class evm_before_ready_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_before_ready_sequence)

	function new(string name = "evm_before_ready_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});

		repeat(7)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} inside {1, 2, 4}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end

		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} inside {1, 2, 4}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;});

	endtask: body
endclass: evm_before_ready_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Default display check
class evm_default_result_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_default_result_sequence)

	function new(string name = "evm_default_result_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		repeat(25)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} inside {1, 2, 4}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 3; req.display_winner == 0;});
	endtask: body
endclass: evm_default_result_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Timeout check
class evm_timeout_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_timeout_sequence)

	function new(string name = "evm_timeout_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});

		repeat(15)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} inside {1, 2, 4}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		repeat(15)  // Yet to calculate
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		end
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});

		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;});
	endtask: body
endclass: evm_timeout_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// To wait for candidate state loop condition
class evm_wait_candidate_sequence extends uvm_sequence #(evm_seq_item);
	`uvm_object_utils(evm_wait_candidate_sequence)

	function new(string name = "evm_wait_candidate_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});

		repeat(15)
		begin
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
			`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} inside {1, 2, 4}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 1;});
		end

		`uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;});
	endtask: body
endclass: evm_wait_candidate_sequence

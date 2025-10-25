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
		`uvm_do_with(req,{req.switch_on_evm == 1;});
		`uvm_do_with(req,{req.candidate_ready == 1;});
		repeat(20)
			`uvm_do_with(req,{req.{vote_candidate_1, vote_candidate_2, vote_candidate_3} dist {1:=7, 2:=2, 4:=1};});
		`uvm_do_with(req,{req.voting_session_done == 1;});
		`uvm_do_with(req,{req.display_results == 0;});
		`uvm_do_with(req,{req.display_winner == 0;});
	endtask
endclass


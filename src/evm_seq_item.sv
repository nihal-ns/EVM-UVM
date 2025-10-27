class evm_seq_item extends uvm_sequence_item;
	`uvm_object_utils(evm_seq_item)
	function new(string name="evm_seq_item");
		super.new(name);
	endfunction
	`uvm_object_utils_begin(evm_seq_item);
		`uvm_field_int(vote_candidate_1,UVM_ALL_ON);
		`uvm_field_int(vote_candidate_2,UVM_ALL_ON);
		`uvm_field_int(vote_candidate_3,UVM_ALL_ON);
		`uvm_field_int(switch_on_evm,UVM_ALL_ON);
		`uvm_field_int(candidate_ready,UVM_ALL_ON);
		`uvm_field_int(voting_session_done,UVM_ALL_ON);
		`uvm_field_int(display_results,UVM_ALL_ON);
		`uvm_field_int(display_winner,UVM_ALL_ON);
		`uvm_field_int(candidate_name,UVM_ALL_ON);
		`uvm_field_int(invalid_results,UVM_ALL_ON);
		`uvm_field_int(results,UVM_ALL_ON);
		`uvm_field_int(voting_in_progress ,UVM_ALL_ON);
		`uvm_field_int(voting_done,UVM_ALL_ON);
	`uvm_object_utils_end
endclass

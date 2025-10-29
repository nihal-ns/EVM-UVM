class evm_test extends uvm_test;
	evm_env env;
	`uvm_component_utils(evm_test)

	function new(string name = "evm_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = evm_env::type_id::create("env", this);
	endfunction: build_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: evm_test

//----------------------------------------------------------------------------------------------------------------------

class c1_win_test extends evm_test;	// Call this
	`uvm_component_utils(c1_win_test)

	function new(string name = "c1_win_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	virtual task run_phase(uvm_phase phase);
		evm_c1_win_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		phase.phase_done.set_drain_time(this, 20ns);
			seq = evm_c1_win_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: c1_win_test

//----------------------------------------------------------------------------------------------------------------------

class rand_win_test extends evm_test;
	`uvm_component_utils(rand_win_test)

	function new(string name = "rand_win_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	virtual task run_phase(uvm_phase phase);
		evm_rand_win_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		phase.phase_done.set_drain_time(this, 20ns);
			seq = evm_rand_win_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: rand_win_test

//----------------------------------------------------------------------------------------------------------------------

class tie_max_test extends evm_test;
	`uvm_component_utils(tie_max_test)

	function new(string name = "tie_max_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	virtual task run_phase(uvm_phase phase);
		evm_tie_max_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		phase.phase_done.set_drain_time(this, 20ns);
			seq = evm_tie_max_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: tie_max_test

//----------------------------------------------------------------------------------------------------------------------

class tie_min_test extends evm_test;
	`uvm_component_utils(tie_min_test)

	function new(string name = "tie_min_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	virtual task run_phase(uvm_phase phase);
		evm_tie_min_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		phase.phase_done.set_drain_time(this, 20ns);
			seq = evm_tie_min_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: tie_min_test

//----------------------------------------------------------------------------------------------------------------------

class sudden_off_test extends evm_test;
	`uvm_component_utils(sudden_off_test)

	function new(string name = "sudden_off_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	virtual task run_phase(uvm_phase phase);
		evm_off_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		phase.phase_done.set_drain_time(this, 20ns);
			seq = evm_off_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: sudden_off_test

//----------------------------------------------------------------------------------------------------------------------

class sudden_done_test extends evm_test;
	`uvm_component_utils(sudden_done_test)

	function new(string name = "sudden_done_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	virtual task run_phase(uvm_phase phase);
		evm_sudden_done_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		phase.phase_done.set_drain_time(this, 20ns);
			seq = evm_sudden_done_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: sudden_done_test

//----------------------------------------------------------------------------------------------------------------------

class vote_count_test extends evm_test;
	`uvm_component_utils(vote_count_test)

	function new(string name = "vote_count_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	virtual task run_phase(uvm_phase phase);
		evm_count_cast_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		phase.phase_done.set_drain_time(this, 30ns);
			seq = evm_count_cast_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: vote_count_test

//----------------------------------------------------------------------------------------------------------------------

class double_vote_test extends evm_test;
	`uvm_component_utils(double_vote_test)

	function new(string name = "double_vote_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	virtual task run_phase(uvm_phase phase);
		evm_double_cast_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		phase.phase_done.set_drain_time(this, 20ns);
			seq = evm_double_cast_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: double_vote_test

//----------------------------------------------------------------------------------------------------------------------

class vote_before_ready_test extends evm_test;
	`uvm_component_utils(vote_before_ready_test)

	function new(string name = "vote_before_ready_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	virtual task run_phase(uvm_phase phase);
		evm_before_ready_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		phase.phase_done.set_drain_time(this, 20ns);
			seq = evm_before_ready_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: vote_before_ready_test

//----------------------------------------------------------------------------------------------------------------------

class default_display_test extends evm_test;
	`uvm_component_utils(default_display_test)

	function new(string name = "default_display_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	virtual task run_phase(uvm_phase phase);
		evm_default_result_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		phase.phase_done.set_drain_time(this, 20ns);
			seq = evm_default_result_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: default_display_test

//----------------------------------------------------------------------------------------------------------------------

class timeout_test extends evm_test;
	`uvm_component_utils(timeout_test)

	function new(string name = "timeout_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	virtual task run_phase(uvm_phase phase);
		evm_timeout_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		phase.phase_done.set_drain_time(this, 20ns);
			seq = evm_timeout_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: timeout_test

//----------------------------------------------------------------------------------------------------------------------

class wait_candidate_loop_test extends evm_test;
	`uvm_component_utils(wait_candidate_loop_test)

	function new(string name = "wait_candidate_loop__test", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	virtual task run_phase(uvm_phase phase);
		evm_wait_candidate_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		phase.phase_done.set_drain_time(this, 20ns);
			seq = evm_wait_candidate_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: wait_candidate_loop_test

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
			seq = evm_sudden_done_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask: run_phase

	virtual function void end_of_elaboration();
		print();
	endfunction: end_of_elaboration
endclass: sudden_done_test

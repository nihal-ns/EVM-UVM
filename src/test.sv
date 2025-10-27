class Evm_test extends uvm_test;

	Evm_env env;

	`uvm_component_utils(Evm_test)

	function new(string name = "Evm_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = Evm_env::type_id::create("env", this);
	endfunction

	virtual function void end_of_elaboration();
		print();
	endfunction
endclass
//----------------------------------------------------------------------------------------------------------------------
class c1_win_test extends Evm_test;	// Call this
	`uvm_component_utils(c1_win_test)

	function new(string name = "c1_win_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		Evm_c1_win_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
			seq = Evm_c1_win_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask

	virtual function void end_of_elaboration();
		print();
	endfunction
endclass
//----------------------------------------------------------------------------------------------------------------------
class rand_win_test extends Evm_test;
	`uvm_component_utils(rand_win_test)

	function new(string name = "rand_win_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		Evm_rand_win_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
			seq = Evm_rand_win_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask

	virtual function void end_of_elaboration();
		print();
	endfunction
endclass
//----------------------------------------------------------------------------------------------------------------------
class tie_max_test extends Evm_test;
	`uvm_component_utils(tie_max_test)

	function new(string name = "tie_max_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		Evm_tie_max_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
			seq = Evm_tie_max_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask

	virtual function void end_of_elaboration();
		print();
	endfunction
endclass
//----------------------------------------------------------------------------------------------------------------------
class tie_min_test extends Evm_test;
	`uvm_component_utils(tie_min_test)

	function new(string name = "tie_min_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		Evm_tie_min_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
			seq = Evm_tie_min_sequence::type_id::create("seq");	
			seq.start(env.agt_act.sqr_h);
		phase.drop_objection(this, "Objection Dropped");
		$display("############################################################################################################################");
	endtask

	virtual function void end_of_elaboration();
		print();
	endfunction
endclass

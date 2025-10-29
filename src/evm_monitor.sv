////////////////////////////////////
/////// Active monitor
///////////////////////////////////
class evm_monitor_act extends uvm_monitor; 
	`uvm_component_utils(evm_monitor_act)   

	virtual evm_interface vif;    
	uvm_analysis_port #(evm_seq_item) mon_act_port;  

	function new(string name = "Evm_monitor_act", uvm_component parent);     
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		mon_act_port = new("mon_act_port",this);         
		if(!uvm_config_db#(virtual evm_interface)::get(this,"","vif",vif)) 
			`uvm_fatal("NO_VIF","virtual interface failed to get from config");
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		repeat(2)@(vif.mon_cb);
		forever begin
			evm_seq_item item = evm_seq_item::type_id::create("item");
			@(vif.mon_cb);
			item.vote_candidate_1 = vif.vote_candidate_1;
			item.vote_candidate_2 = vif.vote_candidate_2;
			item.vote_candidate_3 = vif.vote_candidate_3;
			item.switch_on_evm = vif.switch_on_evm;
			item.candidate_ready = vif.candidate_ready;
			item.voting_session_done = vif.voting_session_done;
			item.display_results = vif.display_results; 
			item.display_winner = vif.display_winner;
			mon_act_port.write(item);
			`uvm_info(get_type_name(), $sformatf("\nMonitor active: switch on:%0b | ready:%0b | candidate_1/2/3: %0d | session done:%0b | display results:%0d | display winner :%0d\n", item.switch_on_evm, item.candidate_ready, {item.vote_candidate_3,item.vote_candidate_2,item.vote_candidate_1}, item.voting_session_done, item.display_results, item.display_winner), UVM_LOW)
		end
	endtask: run_phase	

endclass: evm_monitor_act

////////////////////////////////////
/////// Passive monitor
////////////////////////////////////
class evm_monitor_pass extends uvm_monitor; 
	`uvm_component_utils(evm_monitor_pass)   

	virtual evm_interface vif;             
	uvm_analysis_port #(evm_seq_item) mon_pass_port;      

	function new(string name = "Evm_monitor_pass", uvm_component parent);     
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		mon_pass_port = new("mon_pass_port",this);         
		if(!uvm_config_db#(virtual evm_interface)::get(this,"","vif",vif))        
			`uvm_fatal("NO_VIF","virtual interface failed to get from config");
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		repeat(2)@(vif.mon_cb);
		forever begin
			evm_seq_item item = evm_seq_item::type_id::create("item");
			@(vif.mon_cb);
			item.candidate_name = vif.candidate_name;
			item.invalid_results = vif.invalid_results;
			item.results = vif.results;
			item.voting_in_progress = vif.voting_in_progress;
			item.voting_done = vif.voting_done; 
			mon_pass_port.write(item);
			`uvm_info(get_type_name(), $sformatf("\nMonitor passive: candidate name:%0d | invalid results:%0b | results:%0d | progess:%0b | done:%0b\n", item.candidate_name, item.invalid_results, item.results, item.voting_in_progress, item.voting_done), UVM_LOW)
		end
	endtask: run_phase	

endclass: evm_monitor_pass

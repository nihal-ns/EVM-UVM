class Evm_monitor_act extends uvm_monitor; 
	`uvm_component_utils(Evm_monitor_act)   

	virtual _intf vif;                   // CHANGE THE NAME
	uvm_analysis_port #(_seq_item) mon_act_port;          // CHANGE THE NAME

	function new(string name = "Evm_monitor_act", uvm_component parent);     
		super.new(name,parent);
	endfunction	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		mon_act_port = new("mon_act_port",this);         
		if(!uvm_config_db#(virtual _intf)::get(this,"","vif",vif))              // CHANGE THE NAME
			`uvm_fatal("NO_VIF","virtual interface failed to get from config");
	endfunction	

	task run_phase(uvm_phase phase);
		forever begin
						
		end
	endtask	
	
	


endclass: Evm_monitor_act  // CHANGE THE NAME

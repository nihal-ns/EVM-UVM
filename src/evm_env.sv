 class evm_env extends uvm_env;
`uvm_component_utils(evm_env)

evm_agent_active agt_act;
evm_agent_passive agt_pass;
evm_scb scb;
evm_cov cov;

function new(string name = "evm_env", uvm_component parent);
	super.new(name, parent);
endfunction
	
function void build_phase(uvm_phase phase);
super.build_phase(phase);

agt_act = evm_agent_active::type_id::create("agt_act", this);
agt_pass = evm_agent_passive::type_id::create("agt_pass", this);
scb = evm_scb::type_id::create("scb", this);
cov = evm_cov::type_id::create("cov", this);

uvm_config_db#(uvm_active_passive_enum)::set(this, "agt_act", "is_active", UVM_ACTIVE);
uvm_config_db#(uvm_active_passive_enum)::set(this, "agt_pass", "is_active", UVM_PASSIVE);
endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);

agt_act.act_mon_h.mon_act_port.connect(scb.item_act_port);
agt_pass.pas_mon_h.mon_pass_port.connect(scb.item_pass_port);

agt_act.act_mon_h.mon_act_port.connect(cov.item_act_port);
agt_pass.pas_mon_h.mon_pass_port.connect(cov.item_pass_port);

endfunction
endclass

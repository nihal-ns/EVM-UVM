class evm_agent_active extends uvm_agent;
 `uvm_component_utils(evm_agent_active)

 evm_driver drv_h;
 evm_sequencer sqr_h;
 evm_monitor_act act_mon_h;

 function new(string name = "evm_agent_active", uvm_component parent = null);
  super.new(name, parent);
 endfunction: new

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  uvm_config_db#(uvm_active_passive_enum)::get(this,"", "is_active", UVM_ACTIVE);
  if(get_is_active() == UVM_ACTIVE) begin
   drv_h = evm_driver::type_id::create("drv_h", this);
   sqr_h = evm_sequencer::type_id::create("sqr_h", this);
   act_mon_h = evm_monitor_act::type_id::create("act_mon_h", this);
  end

 endfunction: build_phase

 function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(get_is_active() == UVM_ACTIVE) begin
   drv_h.seq_item_port.connect(sqr_h.seq_item_export);
  end
 endfunction: connect_phase

endclass: evm_agent_active


////////////////////////////////////
///////// Passive Agent
/////////////////////////////////////
class evm_agent_passive extends uvm_agent;
 `uvm_component_utils(evm_agent_passive)

 evm_monitor_pass pas_mon_h;

 function new(string name = "evm_agent_passive", uvm_component parent = null);
  super.new(name, parent);
 endfunction: new

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  uvm_config_db#(uvm_active_passive_enum)::get(this,"", "is_active", UVM_PASSIVE);
  /* if(get_is_active() == UVM_PASSIVE) begin */
   pas_mon_h = evm_monitor_pass::type_id::create("pas_mon_h", this);
  /* end */

 endfunction: build_phase

endclass: evm_agent_passive




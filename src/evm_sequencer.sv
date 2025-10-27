class evm_sequencer extends uvm_sequencer#(evm_seq_item);
 `uvm_component_utils(evm_sequencer)

 function new(string name = "evm_sequencer", uvm_component parent);
  super.new(name,parent);
 endfunction: new

endclass: evm_sequencer

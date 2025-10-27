`define WIDTH 8
package evm_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "evm_seq_item.sv"
  `include "evm_sequence.sv"
  `include "evm_sequencer.sv"
  `include "evm_driver.sv"
  `include "evm_monitor.sv"
  `include "evm_agent.sv"
  `include "evm_scoreboard.sv"
  `include "evm_subscriber.sv"
  `include "evm_env.sv"
  `include "test.sv"
endpackage

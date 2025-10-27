`define WIDTH 8
`include "uvm_macros.svh"
`include "evm_interface.sv"
`include "evm_tto.v"
`include "evm_assertion.sv"

module top;
  import uvm_pkg::*;
  import evm_pkg::*;

  bit clk;
  bit rst;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  evm_interface intf(clk, rst);

	evm DUT (
		.clk(clk),
		.rst(rst),
		.vote_candidate_1(intf.vote_candidate_1),
		.vote_candidate_2(intf.vote_candidate_2),
		.vote_candidate_3(intf.vote_candidate_3),
		.switch_on_evm(intf.switch_on_evm),
		.candidate_ready(intf.candidate_ready),
		.voting_session_done(intf.voting_session_done),
		.display_results(intf.display_results),
		.display_winner(intf.display_winner),
		.candidate_name(intf.candidate_name),
		.invalid_results(intf.invalid_results),
		.results(intf.results),
		.voting_in_progress(intf.voting_in_progress),
		.voting_done(intf.voting_done)
  );

  bind intf evm_assertion ASSERT(.*);
                  
  initial begin
    rst = 0;
		repeat(2) @(posedge clk);
		rst = 1;
  end

  initial begin
    uvm_config_db#(virtual evm_interface)::set(null, "*", "vif", intf);
    run_test();
  end

endmodule

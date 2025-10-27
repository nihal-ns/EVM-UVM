`include "uvm_macros.svh"
/* `include "interface.sv" */
/* `include "apbtop.v" */
/* `include "apb_assertion.sv" */
module top;
  import uvm_pkg::*;
  /* import apb_pkg::*; */

  bit clk;
  bit rst;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  evm_interface intf(clk, rst);

  Desing DUT ( 
  );

  bind intf evm_assertion ASSERT(.*);
                  
  initial begin
    rst = 0;
    @(posedge clk) rst = 1;

  end
  initial begin
    uvm_config_db#(virtual evm_interface)::set(null, "*", "apb_intf", intf);
    run_test("wr_test");
  end

endmodule

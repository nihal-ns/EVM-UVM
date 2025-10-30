`uvm_analysis_imp_decl(_act_mon)
`uvm_analysis_imp_decl(_pass_mon)
class evm_scb extends uvm_scoreboard;
  `uvm_component_utils(evm_scb)
  evm_seq_item expect_q[$];
  evm_seq_item actual_q[$];

  static bit [7:0] counter1, counter2, counter3;
  static bit [7:0] candidate_ready_timeout, waiting_for_vote_timeout;

  static int pass_count, fail_count;
  bit [7:0] vote[3];
  bit ready_flag;

  uvm_analysis_imp_act_mon #(evm_seq_item, evm_scb) expect_item;
  uvm_analysis_imp_pass_mon #(evm_seq_item, evm_scb) actual_item;

  function new(string name = "evm_scb", uvm_component parent);
    super.new(name, parent);
    expect_item = new("expect_item", this);
    actual_item = new("actual_item", this);
  endfunction

  function void write_act_mon(evm_seq_item req);
    expect_q.push_back(req);
  endfunction

  function void write_pass_mon(evm_seq_item req);
    actual_q.push_back(req);
  endfunction

  task run_phase(uvm_phase phase);
    evm_seq_item scb_act_item = evm_seq_item::type_id::create("scb_act_item");
    evm_seq_item scb_pass_item = evm_seq_item::type_id::create("scb_pass_item");
    evm_seq_item scb_expect_item = evm_seq_item::type_id::create("scb_expect_item");

    forever begin
      fork
        begin
          wait(expect_q.size()>0);
          scb_act_item  = expect_q.pop_front();
        end
        begin
          wait(actual_q.size()>0);
          scb_pass_item = actual_q.pop_front();
        end
      join
      compute_expect_result(scb_act_item, scb_expect_item);
      compare_exp_actual(scb_pass_item, scb_expect_item);
    end
  endtask

  task compute_expect_result(input evm_seq_item act_item, ref evm_seq_item exp_item);
    if(!act_item.scb_rst) begin
      exp_item.candidate_name = 0;
      exp_item.results = 0;
      exp_item.invalid_results = 0;
      counter1 = 0;
      counter2 = 0;
      counter3 = 0;
    end
    else if(!act_item.switch_on_evm) begin
      exp_item.candidate_name = 0;
      exp_item.results = 0;
      exp_item.invalid_results = 0;
      counter1 = 0;
      counter2 = 0;
      counter3 = 0;
    end
    else begin

      //Time out condition for the WAITING FOR CANDIDATE
      if(act_item.candidate_ready) begin
        candidate_ready_timeout = 0;
        ready_flag = 1;
      end
      else if(act_item.switch_on_evm && !act_item.candidate_ready) begin
        candidate_ready_timeout ++;
      end

      if (ready_flag && !act_item.candidate_ready) begin
        case ({act_item.vote_candidate_1, act_item.vote_candidate_2, act_item.vote_candidate_3})
          3'b100, 3'b110, 3'b101: counter1++;
          3'b010, 3'b011:         counter2++;
          3'b001:                 counter3++;
          default: ;
        endcase
        ready_flag = 0;
        waiting_for_vote_timeout = 0;
      end
      else if(!act_item.switch_on_evm) begin
        counter1 = 0;
        counter2 = 0;
        counter3 = 0;
        ready_flag = 0;
      end
      else if(ready_flag && !act_item.candidate_ready) begin
       /* counter1 = counter1;
        counter2 = counter2;
        counter3 = counter3;*/
        waiting_for_vote_timeout ++;
      end

      //Display candidate and votes
      if(act_item.voting_session_done && act_item.display_results == 2'b00) begin
        exp_item.candidate_name = 2'b01;
        exp_item.results = counter1;
      end
      else if(act_item.voting_session_done && act_item.display_results == 2'b01) begin
        exp_item.candidate_name = 2'b10;
        exp_item.results = counter2;
      end
      else if(act_item.voting_session_done && act_item.display_results == 2'b10) begin
        exp_item.candidate_name = 2'b11;
        exp_item.results = counter3;
      end
      else begin
        exp_item.candidate_name = 2'b00;
        exp_item.results = 0;
      end

      //Display winner and vote count
      vote = '{counter1, counter2, counter3};
      vote.sort();
      if(act_item.voting_session_done && act_item.display_winner) begin
        if(vote[2] == vote[1]) begin
          exp_item.invalid_results = 1;
          exp_item.results = 0;
          exp_item.candidate_name = 0;
        end
        else begin
          exp_item.results = vote[2];
          exp_item.candidate_name = (vote[2] == counter1)?2'b01:((vote[2] == counter2)?2'b10:2'b11);
          exp_item.invalid_results = 0;
        end
      end

      if(waiting_for_vote_timeout == 100) begin
        waiting_for_vote_timeout = 0;
        $display("Time out waitng to vote");
      end

      if(candidate_ready_timeout == 100) begin
        candidate_ready_timeout = 0;
        $display("Time out waitng for candidate");
        exp_item.voting_done = 1;
      end
    end
  endtask

  task compare_exp_actual (input evm_seq_item actual_output, evm_seq_item expected_output);
    if( actual_output.voting_done) begin
      `uvm_info("SCB", $sformatf("VOTE COUNT | C1 VOTES: %0d | C2 VOTES: %0d | C3 VOTES: %0d",counter1, counter2, counter3 ), UVM_NONE)

      if(actual_output.candidate_name == expected_output.candidate_name) begin
        `uvm_info("SCB", $sformatf("THE CANDIDATE NAME MATCH | ACTUAL CANDIDATE : %0d | EXPECTED CANDIDATE : %0d",actual_output.candidate_name, expected_output.candidate_name ), UVM_NONE)
      end
      else begin
        `uvm_info("SCB", $sformatf("THE CANDIDATE NAME MISSMATCH | ACTUAL CANDIDATE : %0d | EXPECTED CANDIDATE : %0d",actual_output.candidate_name, expected_output.candidate_name ), UVM_NONE)
      end

      if(actual_output.results == expected_output.results) begin
        `uvm_info("SCB", $sformatf("THE RESULTS MATCH | ACTUAL RESULT : %0d | EXPECTED RESULT : %0d",actual_output.results, expected_output.results), UVM_NONE)
      end
      else begin
        `uvm_info("SCB", $sformatf("THE RESULTS MISSMATCH | ACTUAL RESULT : %0d | EXPECTED RESULT : %0d",actual_output.results, expected_output.results), UVM_NONE)
      end

      if(actual_output.invalid_results == expected_output.invalid_results) begin
        `uvm_info("SCB", $sformatf("THE INVALID RESULTS MATCH | ACTUAL INVALID RESULT :%0d | EXPECTED INVALID RESULT : %0d", actual_output.invalid_results, expected_output.invalid_results), UVM_NONE)
      end
      else begin
        `uvm_info("SCB", $sformatf("THE INVALID RESULTS MISSMATCH | ACTUAL INVALID RESULT :%0d | EXPECTED INVALID RESULT : %0d", actual_output.invalid_results, expected_output.invalid_results), UVM_NONE)
      end

      if(actual_output.candidate_name == expected_output.candidate_name && actual_output.results == expected_output.results && actual_output.invalid_results == expected_output.invalid_results) begin
        pass_count ++;
        `uvm_info("SCB", "MATCHED", UVM_NONE)
      end
      else begin
        fail_count ++;
        `uvm_info("SCB", "MISSMATCH", UVM_NONE)
      end
    end
    $display("\n========================================================================================\n");
  endtask

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCB", $sformatf("||| TOTAL MATCHES     : %0d |||", pass_count), UVM_NONE)
    `uvm_info("SCB", $sformatf("||| TOTAL MISSMATCHES : %0d |||", fail_count), UVM_NONE)
  endfunction

endclass

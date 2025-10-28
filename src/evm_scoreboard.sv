`uvm_analysis_imp_decl(_act_mon)
`uvm_analysis_imp_decl(_pass_mon)
class evm_scb extends uvm_scoreboard;
  `uvm_component_utils(evm_scb)
  evm_seq_item expect_q[$];
  evm_seq_item actual_q[$];

  static bit [7:0] counter1, counter2, counter3;

  bit [7:0] votes[int];
  bit ready_flag;

  uvm_analysis_imp_act_mon #(evm_scb, evm_seq_item) expect_item;
  uvm_analysis_imp_pass_mon #(evm_scb, evm_seq_item) actual_item;

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
    evm_seq_item scb_act_item;
    evm_seq_item scb_pass_item;
    evm_seq_item scb_expect_item;

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

  task compute_expect_result(input evm_seq_item act_item, output evm_seq_item exp_item);

    /*if(act_item.candidate_ready || !act_item.voting_process_done)
      exp_item.voting_in_progress = 1;
      */


      if(act_item.candidate_ready)
        ready_flag = 1;

    /*    //For voting done
    if(act_item.voting_process_done == 1)
    exp_item.voting_done = 1;
      else if(!act_item.switch_on_evm)
    exp_item.voting_done = 0;
    */

    //Vote counter
    if(ready_flag && !act_item.candidate_ready && act_item.vote_candidate_1 && ~act_item.vote_candidate_2 && ~act_item.vote_candidate_3) begin
      counter1 ++;
      ready_flag = 0;
    end
    else if(ready_flag && !act_item.candidate_ready && ~act_item.vote_candidate_1 && act_item.vote_candidate_2 && ~act_item.vote_candidate_3) begin
      counter2 ++;
      ready_flag = 0;
    end
    else if(ready_flag && !act_item.candidate_ready && ~act_item.vote_candidate_1 && ~act_item.vote_candidate_2 && act_item.vote_candidate_3) begin
      counter3++;
      ready_flag = 0;
    end
    else if(!act_item.switch_on_evm) begin
      counter1 = 0;
      counter2 = 0;
      counter3 = 0;
      ready_flag = 0;
    end
    else begin
      counter1 = counter1;
      counter2 = counter2;
      counter3 = counter3;
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

    //Display winner and vote count
    vote = '{counter1, counter2, counter3};
    vote.sort();
    if(act_item.voting_session_done && act_item.display_winner) begin
      if(vote[2] == vote[1])
        exp_item.invalid_results == 1;
      else begin
        exp_item.results = vote[2];
        exp_item.candidate_name = (vote[2] == counter1)?2'b01:((vote[2] == counter2)?2'b10:2'b11);
      end
    end
  endtask

  task compare_exp_actual (input evm_seq_item actual_output, input evm_seq_item expected_output);
    if(actual_output.candidate_name == expected_output.candidate_name) begin
      `uvm_info("SCB", "THE CANDIDATE NAME MATCHES", UVM_NONE)
    end
    else begin
      `uvm_info("SCB", "THE CANDIDATE NAME MISSMATCH", UVM_NONE)
    end

    if(actual_output.results == expected_output.results) begin
      `uvm_info("SCB", "THE RESULTS MATCHES", UVM_NONE)
    end
    else begin
      `uvm_info("SCB", "THE RESULTS MISSMATCH", UVM_NONE)
    end

    if(actual_output.invalid_results == expected_output.invalid_results) begin
      `uvm_info("SCB", "THE INVALID RESULTS MATCHES", UVM_NONE)
    end
    else begin
      `uvm_info("SCB", "THE INVALID RESULTS MISSMATCH", UVM_NONE)
    end

    if(expected_output.compare(actual_output)) begin
      `uvm_info("SCB", "MATCHED", UVM_NONE)
    end
    else begin
      `uvm_info("SCB", "MISSMATCH", UVM_NONE)
    end
  endtask

endclass

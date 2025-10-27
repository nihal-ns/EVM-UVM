 `uvm_analysis_imp_decl(_mon_act_cg)
class Evm_subscriber extends uvm_subscriber#(Evm_seq_item);
  `uvm_component_utils(Evm_subscriber)
  
  uvm_analysis_imp_mon_input_cg#(Evm_seq_item, Evm_subscriber) mon_act_cg_port;
  uvm_analysis_imp#(Evm_seq_item, Evm_subscriber) mon_pass_cg_port;

	Evm_seq_item mon_input_seq, mon_output_seq;

  real input_cov, output_cov;

 
  covergroup input_cvg;
    
    vote_candidate: coverpoint mon_input_seq.vote_candidate {
      bins candidate_1 = {0};
      bins candidate_2 = {1};
      bins candidate_3 = {2};
    }

    switch_on_evm_cp: coverpoint mon_input_seq.switch_on_evm {
      bins off = {0};
      bins on  = {1};
    }

    candidate_ready_cp: coverpoint mon_input_seq.candidate_ready {
      bins not_ready = {0};
      bins ready     = {1};
    }

    voting_session_done_cp: coverpoint mon_input_seq.voting_session_done {
      bins not_done = {0};
      bins done     = {1};
    }

    display_results_cp: coverpoint mon_input_seq.display_results {
      bins off = {0};
      bins on  = {1};
    }

    display_winner_cp: coverpoint mon_input_seq.display_winner {
      bins off = {0};
      bins on  = {1};
    }

  endgroup : input_cvg

  covergroup output_cvg;

   
    candidate_name_cp: coverpoint mon_output_seq.candidate_name {
      bins candidate_1 = {2'b01};
	  bins candidate_2 = {2'b10};
      bins candidate_3 = {2'b11};
    }

    invalid_results_cp: coverpoint mon_output_seq.invalid_results {
      bins valid   = {0};
      bins invalid = {1};
    }

    
    results_cp: coverpoint mon_output_seq.results {
      bins result_low  = {[0:31]};
      bins result_mid  = {[32:63]};
      bins result_high = {[64:127]};
    }

    voting_in_progress_cp: coverpoint mon_output_seq.voting_in_progress {
      bins no  = {0};
      bins yes = {1};
    }

    
    voting_done_cp: coverpoint mon_output_seq.voting_done {
      bins not_done = {0};
      bins done     = {1};
    }

  endgroup : output_cvg

  
  function new(string name = "Evm_subscriber", uvm_component parent);
    super.new(name, parent);
    input_cvg = new;
    output_cvg = new;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_input_cg_port  = new("mon_input_cg_port", this);
    mon_output_cg_port = new("mon_output_cg_port", this);
  endfunction

  function void write_mon_input_cg(Evm_seq_item t);
    mon_input_seq = t;
    input_cvg.sample();
  endfunction

 
  function void write(Evm_seq_item t);
    mon_output_seq = t;
    output_cvg.sample();
  endfunction

  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    input_cov  = input_cvg.get_coverage();
    output_cov = output_cvg.get_coverage();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name, $sformatf("Input Coverage  ------> %0.2f%%",  input_cov),  UVM_MEDIUM)
    `uvm_info(get_type_name, $sformatf("Output Coverage ------> %0.2f%%", output_cov), UVM_MEDIUM)
  endfunction

endclass

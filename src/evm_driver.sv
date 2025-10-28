class evm_driver extends uvm_driver;
        `uvm_component_utils(evm_driver)

        virtual evm_interface vif;

        function new(string name = "evm_driver", uvm_component parent = null);
                super.new(name, parent);
        endfunction: new

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                if(!uvm_config_db#(virtual evm_interface)::get(this, "", "vif", vif))
                        `uvm_error("No_vif in driver","virtual interface get failed from config db")
        endfunction: build_phase

        virtual task run_phase(uvm_phase phase);
                repeat(2)@(vif.drv_cb);
                forever begin
                        seq_item_port.get_next_item(req);
                        drive_to_dut();
                        seq_item_port.item_done();
                end
        endtask: run_phase

        task drive_to_dut;
        //      repeat(2)@(vif.drv_cb);
                vif.switch_on_evm    <= req.switch_on_evm;
                vif.candidate_ready  <= req.candidate_ready;
                vif.vote_candidate_1 <= req.vote_candidate_1;
                vif.vote_candidate_2 <= req.vote_candidate_2;
                vif.vote_candidate_3 <= req.vote_candidate_3;

                vif.voting_session_done <= req.voting_session_done;
                vif.display_results     <= req.display_results;
                vif.display_winner      <= req.display_winner;
                $display("");
                `uvm_info(" DRV ", $sformatf("switch_on_evm = %0d | candidate_ready = %0d | vote_candidate_1 = %0d | vote_candidate_2 = %0d | vote_candidate_3 = %0d ", req.switch_on_evm, req.candidate_ready, req.vote_candidate_1, req.vote_candidate_2, req.vote_candidate_3), UVM_LOW)
				`uvm_info(" DRV ", $sformatf("voting_session_done = %0d | display_results = %0d | display_winner = %0d", req.voting_session_done, req.display_results, req.display_winner), UVM_LOW);

                if(req.voting_session_done) begin
                        $display(" VOTING SESSION IS DONE");
                end
                repeat(1)@(vif.drv_cb);
        endtask: drive_to_dut

endclass: evm_driver



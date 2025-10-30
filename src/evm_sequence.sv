class evm_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_sequence)

        function new(string name = "evm_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                req = evm_seq_item::type_id::create("req");
                wait_for_grant();
                req.randomize();
                send_request(req);
                wait_for_item_done();
        endtask: body
endclass: evm_sequence

//-----------------------------------------------------------------------------------------------------------------------------
// To waiting for candidate state sequence
class to_waiting_candidate_state extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(to_waiting_candidate_state)

        function new(string name = "to_waiting_candidate_state");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
        endtask: body
endclass: to_waiting_candidate_state

//-----------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------State Sequences------------------------------------------
// waiting for candidate state |-> waiting to vote state sequence
class waiting_candidate_2_waiting_vote_state_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(waiting_candidate_2_waiting_vote_state_sequence)

        function new(string name = "waiting_candidate_2_waiting_vote_state_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
        endtask: body
endclass: waiting_candidate_2_waiting_vote_state_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// To process done state sequence
class to_voting_process_done_state extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(to_voting_process_done_state)

        function new(string name = "to_voting_process_done_state");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;});
        endtask: body
endclass: to_voting_process_done_state
//-----------------------------------------------------------------------------------------------------------------------------
// Turn off machine
class turn_off_machine extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(turn_off_machine)

        function new(string name = "turn_off_machine");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do_with(req,{req.switch_on_evm == 0;});
        endtask: body
endclass: turn_off_machine
//-----------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------Voting sequences-----------------------------------------------------
// random candidate wins
class random_candidate_win extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(random_candidate_win)

        function new(string name = "random_candidate_win");
                super.new(name);
        endfunction: new

        virtual task body();
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} inside {1, 2, 4}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
        endtask: body
endclass: random_candidate_win
//-----------------------------------------------------------------------------------------------------------------------------
//  candidate 3 wins dist
class candidate1dist_win extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(candidate1dist_win)

        function new(string name = "candidate1dist_win");
                super.new(name);
        endfunction: new

        virtual task body();
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} dist {1:=6, 2:=3, 4:=1}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
        endtask: body
endclass: candidate1dist_win
//-----------------------------------------------------------------------------------------------------------------------------
//  candidate 1 wins
class candidate1_win extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(candidate1_win)

        function new(string name = "candidate1_win");
                super.new(name);
        endfunction: new

        virtual task body();
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 1; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
        endtask: body
endclass: candidate1_win
//-----------------------------------------------------------------------------------------------------------------------------
//  candidate 2 wins
class candidate2_win extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(candidate2_win)

        function new(string name = "candidate2_win");
                super.new(name);
        endfunction: new

        virtual task body();
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 2; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
        endtask: body
endclass: candidate2_win
//-----------------------------------------------------------------------------------------------------------------------------
//  candidate 3 wins
class candidate3_win extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(candidate3_win)

        function new(string name = "candidate3_win");
                super.new(name);
        endfunction: new

        virtual task body();
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 4; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
        endtask: body
endclass: candidate3_win
//-----------------------------------------------------------------------------------------------------------------------------
//  Double vote
class double_vote extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(double_vote)

        function new(string name = "double_vote");
                super.new(name);
        endfunction: new

        virtual task body();
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 3; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
        endtask: body
endclass: double_vote

//-----------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------Sequences-------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------
// Candidate vote count (c1 wins)
class evm_c1_win_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_c1_win_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        candidate1dist_win candidate1dist_win;
        to_voting_process_done_state to_voting_process_done_state;

        function new(string name = "evm_c1_win_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(20)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(candidate1dist_win);
                end
                `uvm_do(to_waiting_for_candidate_state);
                `uvm_do(to_voting_process_done_state);
        endtask: body
endclass: evm_c1_win_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Random candidate wins
class evm_rand_win_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_rand_win_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        random_candidate_win random_candidate_win;
        to_voting_process_done_state to_voting_process_done_state;

        function new(string name = "evm_rand_win_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(23)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(random_candidate_win);
                end
                `uvm_do(to_waiting_for_candidate_state);
                `uvm_do(to_voting_process_done_state);
        endtask: body
endclass: evm_rand_win_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Top 2 tie invalid
class evm_tie_max_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_tie_max_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        to_voting_process_done_state to_voting_process_done_state;
        candidate3_win candidate3_win;
        candidate1_win candidate1_win;

        function new(string name = "evm_tie_max_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(10)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(candidate3_win);
                end
                repeat(10)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(candidate1_win);
                end
                `uvm_do(to_waiting_for_candidate_state);
                `uvm_do(to_voting_process_done_state);
        endtask: body
endclass: evm_tie_max_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Min 2 tie not invalid
class evm_tie_min_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_tie_min_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        to_voting_process_done_state to_voting_process_done_state;
        candidate1_win candidate1_win;
        candidate2_win candidate2_win;
        candidate3_win candidate3_win;

        function new(string name = "evm_tie_min_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(10)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(candidate3_win);
                end
                repeat(10)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(candidate2_win);
                end
                repeat(11)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(candidate1_win);
                end
                `uvm_do(to_waiting_for_candidate_state);
                `uvm_do(to_voting_process_done_state);
        endtask: body
endclass: evm_tie_min_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Sudden EVM off (EVM turns off mid voting)
class evm_off_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_off_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        random_candidate_win random_candidate_win;
        to_voting_process_done_state to_voting_process_done_state;

        function new(string name = "evm_off_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(9)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(random_candidate_win);
                end
                        `uvm_do_with(req,{req.switch_on_evm == 0;});
                        `uvm_do_with(req,{req.switch_on_evm == 0;});
        endtask: body
endclass: evm_off_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Sudden voting done
class evm_sudden_done_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_sudden_done_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        to_voting_process_done_state to_voting_process_done_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
  random_candidate_win random_candidate_win;
        function new(string name = "evm_sudden_done_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(7)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(random_candidate_win);
                end
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} dist {1:=7, 2:=2, 4:=1}; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});
        endtask: body
endclass: evm_sudden_done_sequence


//-----------------------------------------------------------------------------------------------------------------------------
// Candidate vote count
class evm_count_cast_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_count_cast_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        to_voting_process_done_state to_voting_process_done_state;
        random_candidate_win random_candidate_win;

        function new(string name = "evm_count_cast_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(25)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(random_candidate_win);
                end
                `uvm_do(to_waiting_for_candidate_state);
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 1; req.display_winner == 0;});
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 2; req.display_winner == 0;});
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;});
        endtask: body
endclass: evm_count_cast_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Cast 2 votes
class evm_double_cast_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_double_cast_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        to_voting_process_done_state to_voting_process_done_state;
        double_vote double_vote;
        random_candidate_win random_candidate_win;

        function new(string name = "evm_double_cast_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(3)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(random_candidate_win);
                end
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(double_vote);
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 6; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 5; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 7; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});

                        `uvm_do(to_waiting_for_candidate_state);
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 1; req.display_winner == 0;});
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 2; req.display_winner == 0;});
                        `uvm_do(to_voting_process_done_state);
        endtask: body
endclass: evm_double_cast_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Vote before ready
class evm_before_ready_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_before_ready_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        to_voting_process_done_state to_voting_process_done_state;
        random_candidate_win random_candidate_win;

        function new(string name = "evm_before_ready_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(7)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(random_candidate_win);
                end
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} inside {1, 2, 4}; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
                `uvm_do(to_voting_process_done_state);

                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 1; req.display_winner == 0;});
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 2; req.display_winner == 0;});
        endtask: body

endclass: evm_before_ready_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Default display check
class evm_default_result_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_default_result_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        to_voting_process_done_state to_voting_process_done_state;
        random_candidate_win random_candidate_win;

        function new(string name = "evm_default_result_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(25)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(random_candidate_win);
                end
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 3; req.display_winner == 0;});
        endtask: body
endclass: evm_default_result_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Timeout check
class evm_timeout_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_timeout_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        to_voting_process_done_state to_voting_process_done_state;
        random_candidate_win random_candidate_win;

        function new(string name = "evm_timeout_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(16)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(random_candidate_win);
                end
                `uvm_do(waiting_candidate_2_waiting_vote);
                repeat(100)
                begin
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
                end
                `uvm_do(to_waiting_for_candidate_state);
                `uvm_do(to_voting_process_done_state);
        endtask: body
endclass: evm_timeout_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// To wait for candidate state loop condition
class evm_wait_candidate_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_wait_candidate_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        to_voting_process_done_state to_voting_process_done_state;
        random_candidate_win random_candidate_win;

        function new(string name = "evm_wait_candidate_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(15)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(random_candidate_win);
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 1;});
                end
                `uvm_do(to_voting_process_done_state);
        endtask: body
endclass: evm_wait_candidate_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Counter overflow
class evm_counter_overflow_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_counter_overflow_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        to_voting_process_done_state to_voting_process_done_state;
        candidate1_win candidate1_win;
        candidate2_win candidate2_win;
        candidate3_win candidate3_win;

        function new(string name = "evm_counter_overflow_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(50)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(candidate1_win);
                end
                repeat(130)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(candidate2_win);
                end
                repeat(100)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(candidate3_win);
                end
                `uvm_do(to_waiting_for_candidate_state);
                `uvm_do(to_voting_process_done_state);
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 0;});
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 1; req.display_winner == 0;});
                `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 2; req.display_winner == 0;});
        endtask: body
endclass: evm_counter_overflow_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Timeout2 check
class evm_timeout2_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(evm_timeout2_sequence)

        to_waiting_candidate_state to_waiting_for_candidate_state;
        waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
        to_voting_process_done_state to_voting_process_done_state;
        random_candidate_win random_candidate_win;

        function new(string name = "evm_timeout2_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(to_waiting_for_candidate_state);
                repeat(16)
                begin
                        `uvm_do(waiting_candidate_2_waiting_vote);
                        `uvm_do(random_candidate_win);
                end
                repeat(100)
                begin
                        `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
                end
                `uvm_do(to_waiting_for_candidate_state);
                `uvm_do(to_voting_process_done_state);
        endtask: body
endclass: evm_timeout2_sequence

//-----------------------------------------------------------------------------------------------------------------------------

// Coverage1 Sequence
class evm_coverage1_sequence extends uvm_sequence #(evm_seq_item);
  `uvm_object_utils(evm_coverage1_sequence)

  to_waiting_candidate_state to_waiting_for_candidate_state;
  waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
  to_voting_process_done_state to_voting_process_done_state;
  candidate1_win candidate1_win;
  candidate2_win candidate2_win;
  candidate3_win candidate3_win;

  function new(string name = "evm_coverage1_sequence");
    super.new(name);
  endfunction: new

  virtual task body();
    `uvm_do(to_waiting_for_candidate_state);
    repeat(10)
    begin
      `uvm_do(waiting_candidate_2_waiting_vote);
      `uvm_do(candidate1_win);
    end
    repeat(12)
    begin
      `uvm_do(waiting_candidate_2_waiting_vote);
      `uvm_do(candidate2_win);
    end
    repeat(12)
    begin
      `uvm_do(waiting_candidate_2_waiting_vote);
      `uvm_do(candidate3_win);
    end
    `uvm_do(to_waiting_for_candidate_state);
    `uvm_do(to_voting_process_done_state);
  endtask: body
endclass: evm_coverage1_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Coverage
class evm_coverage2_sequence extends uvm_sequence #(evm_seq_item);
  `uvm_object_utils(evm_coverage2_sequence)

  to_waiting_candidate_state to_waiting_for_candidate_state;
  waiting_candidate_2_waiting_vote_state_sequence waiting_candidate_2_waiting_vote;
  to_voting_process_done_state to_voting_process_done_state;
  random_candidate_win random_candidate_win;

  function new(string name = "evm_coverage2_sequence");
    super.new(name);
  endfunction: new

  virtual task body();
    `uvm_do(to_waiting_for_candidate_state);
    repeat(25)
    begin
      `uvm_do(waiting_candidate_2_waiting_vote);
      `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0;req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
    end
    repeat(25)
    begin
      `uvm_do(waiting_candidate_2_waiting_vote);
      `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 1; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
      `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; req.voting_session_done == 0; req.display_results == 0; req.display_winner == 0;});
    end
    `uvm_do_with(req,{req.switch_on_evm == 1; req.candidate_ready == 0; {req.vote_candidate_3, req.vote_candidate_2, req.vote_candidate_1} == 0; req.voting_session_done == 1; req.display_results == 0; req.display_winner == 1;});
  endtask: body
endclass: evm_coverage2_sequence
//-----------------------------------------------------------------------------------------------------------------------------
// Regression Sequence
class regression_sequence extends uvm_sequence #(evm_seq_item);
        `uvm_object_utils(regression_sequence)

        evm_c1_win_sequence evm_c1_win_sequence;
        evm_rand_win_sequence evm_rand_win_sequence;
        evm_tie_max_sequence evm_tie_max_sequence;
        evm_tie_min_sequence evm_tie_min_sequence;
        evm_off_sequence evm_off_sequence;
        evm_sudden_done_sequence evm_sudden_done_sequence;
        evm_count_cast_sequence evm_count_cast_sequence;
        evm_double_cast_sequence evm_double_cast_sequence;
        evm_before_ready_sequence evm_before_ready_sequence;
        evm_default_result_sequence evm_default_result_sequence;
        evm_timeout_sequence evm_timeout_sequence;
        evm_wait_candidate_sequence evm_wait_candidate_sequence;
        evm_counter_overflow_sequence evm_counter_overflow_sequence;
        evm_timeout2_sequence evm_timeout2_sequence;
        turn_off_machine turn_off_machine;
        evm_coverage1_sequence evm_coverage1_sequence;
        evm_coverage2_sequence evm_coverage2_sequence;

        to_waiting_candidate_state to_waiting_for_candidate_state;
        to_voting_process_done_state to_voting_process_done_state;

        function new(string name = "regression_sequence");
                super.new(name);
        endfunction: new

        virtual task body();
                `uvm_do(evm_c1_win_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_rand_win_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_tie_max_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_tie_min_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_off_sequence);
                // This is to safely turn off machine
                `uvm_do(to_waiting_for_candidate_state);
                `uvm_do(to_voting_process_done_state);

                `uvm_do(turn_off_machine);
                `uvm_do(evm_sudden_done_sequence);
                // This is to safely turn off machine
                `uvm_do(to_waiting_for_candidate_state);
                `uvm_do(to_voting_process_done_state);

                `uvm_do(turn_off_machine);
                `uvm_do(evm_count_cast_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_double_cast_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_before_ready_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_default_result_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_timeout_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_wait_candidate_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_counter_overflow_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_timeout2_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_coverage1_sequence);
                `uvm_do(turn_off_machine);
                `uvm_do(evm_coverage2_sequence);
        endtask: body
endclass: regression_sequence

# EVM-UVM
<img width="1086" height="668" alt="image" src="https://github.com/user-attachments/assets/1b20a8d8-2146-4cad-abb8-36058a43584c" />

## How to Run the UVM Testbench

All commands should be run from the `src/` directory (where the `makefile` is located).

### Running a Simulation

To compile and run the default test (`evm_test`):
```
make
```
To run a specific test, use the test variable. This will set the +UVM_TESTNAME for the simulation.
```
make test=your_test_name
```
Changing Simulation Verbosity
The default verbosity is NORMAL. You can change it using the VERBOSITY variable:
```
make test=your_test_name VERBOSITY=HIGH
```
Shortcut targets are also provided for HIGH and DEBUG verbosity:
Run the default test with HIGH verbosity
```
make h
```
Run a specific test with DEBUG verbosity
```
make test=your_test_name d
```
Running Coverage
To run a simulation with coverage collection and generate an report:
```
make cov
```
or
```
make cov test=your_test_name
```
Cleaning the Directory
To remove all generated files (log files, work directory, coverage reports, etc.):
```
make clean
```

## Project Structure
```
.
├── Doc/
│   └── doc_links.md        # Project documentation links
│
├── src/
│   ├── evm_tto.v           # Design Under Test (DUT)
│   ├── evm_interface.sv    # Interface for DUT-Testbench connection
│   ├── evm_pkg.sv          # UVM Package (imports all components)
│   ├── evm_seq_item.sv     # UVM Sequence Item (Transaction)
│   ├── evm_sequence.sv     # UVM Sequences (stimulus)
│   ├── evm_driver.sv       # UVM Driver
│   ├── evm_monitor.sv      # UVM Monitor
│   ├── evm_sequencer.sv    # UVM Sequencer
│   ├── evm_agent.sv        # UVM Agent (bundles Driver, Monitor, Sequencer)
│   ├── evm_scoreboard.sv   # UVM Scoreboard (for checking)
│   ├── evm_subscriber.sv   # UVM Subscriber (for functional coverage)
│   ├── evm_env.sv          # UVM Environment (top-level UVM component)
│   ├── evm_assertion.sv    # SystemVerilog Assertions (SVA) file
│   ├── test.sv             # UVM Test library (defines tests)
│   ├── top.sv              # Top-level module connecting DUT and Testbench
│   ├── makefile            # Makefile for compiling and running simulation
│   └── exclusion.do        # Coverage exclusion file
│
└── README.md
```

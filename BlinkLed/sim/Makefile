#Note: Il existe des variables dites speciales
#$@ : pointer to the target
#$< : pointer to the first dependency
#$^ : pointer to all dependencies
#$? : pointe sur la liste des dependances plus recentes que la cible 
#$* : pointer to the target name without extension file name


## Compiler to be be used for the generation of the shared library containing
## the golden reference model.
CC = gcc

## Directory containing the "svdpi.h" header.
_DPI_DIR_ = intelFPGA/19.1/modelsim_ase/include/svdpi.h

## Directory containing the C reference implementation of the respective
_MDL_SRC_ = ../mdl

## Compiler flags.
CFLAGS = -c -fPIC -I$(_DPI_DIR_) -I$(_MDL_SRC_)

## Path to the SystemVerilog source file containing the declarations (i.e., the
## "import" statements) of the C functions to be used. This file can be used in
## order to automatically generate the function declarations of the
## corresponding C code (i.e., its header file).
_DPI_SRC_ = ../tb/BlinkLed.sv

## Path to the C header file to be generated with the use of Questa
## Sim. Thereby, the function declarations of the C functions can be created
## automatically.
DPIDES = ../mdl/add.h
#<selection de tous les fichiers sources c>
SRC=$(wildcard *.c)
#<creation des objets sur la base des fichiers sources>
OBJ=$(SRC:.c = .o)

## C source files.
_CSRCS_ = \
	$(_MDL_SRC_)/add.c

## Derive the object names from the source file names.
COBJS = $(patsubst %.c, %.o, $(_CSRCS_))

## Name for the shared library containing the golden model.
_MDL_LIB_  = mdl_lib

## QuestaSim Makeifile for compiling and simulating RTL source code (VHDL and
## SystemVerilog) using the Direct Programming Interface (DPI) to connect to the
## golden reference model written in C for obtaining the expected responses.


## HDL SIMULATION SETTINGS:< Declare variables >
_VER_  = 93
_LIB_  = work
_REPORT_   = reports 
_VOPTARGS_ = +acc
_HDL_LOG_  = vcom_compile.log
_HVL_LOG_  = vlog_compile.log
_SIM_LOG_  = sim_report.log
_PLUSARGS_ = \
	   +LOG_INFO_FILE =simulation.log \
	   +LOG_WARN_FILE =simulation.log \
	   +LOG_ERROR_FILE=simulation.log 

_COVERAGE_ =+coverage

##VHDL SOURCE FILES OF THE DESIGN UNDER VERIFICATION(DUV).
_HDL_SRC_ = \
	    ../hdl/ClockGen.vhd \
	    ../hdl/BlinkLed_pkg.vhd \
	    ../hdl/BlinkLed.vhd

##THE SV/UMV SOURCE FILES OF THE TESTBENCH.
_HVL_SRC_ = \
	    ../tb/parameters.svh \
	    ../tb/BlinkLed_tb.sv

## 

all: sim


ref_mdl: $(_MDL_LIB_).so

$(_MDL_LIB_).so: $(COBJS) 
	@echo "**[MAKE]** Create the shared library containing the reference/golden model ($(_MDL_LIB).so)."
	@ld -shared -E -o $(_MDL_LIB_).so $(COBJS)

%.o : %.c
	@echo "**[MAKE]** Compiling candidate source file: $<"
	@$(CC) $(CFLAGS) -c $< -o $@


dpiheader: lib
## Calling this target is usually only required when the interface between the
## SystemVerilog testbench and the C reference model changes (i.e., the
## import/export declarations of the DPI functions in the SystemVerilog
## testbench gets altered) in order to generate the new DPI header file to be
## included in the C reference model.
	@echo "**[MAKE]** Create the DPI header."
	@vlog-$(VER) -work $(LIB) -l $(VLOG_LOG) -dpiheader $(DPIDES) $(DPISRC)


lib:
	@echo "**[MAKE]** Creating library $(_LIB_)."
	@if [ -d $(_LIB_) ]; then \
		rm -rf $(_LIB_); \
		echo "--[MAKE]-- Removed old library $(_LIB_)"; \
	fi
	vlib $(_LIB_);
	@mkdir -p ./$(_REPORT_)


rtl_mdl: lib 
	@echo "**[MAKE]** Compiling RTL sources."
	@vcom -$(_VER_) -work $(_LIB_) -l $(_HDL_LOG_) $(_HDL_SRC_)


tb_mdl: lib
	@echo "**[Make]** Compiling testbench environment(VHDL/SVerilog/UVM)."
	@vlog -sv -work $(_LIB_) -l $(_HVL_LOG_) $(_HVL_SRC_) 	


sim_ui: ref_mdl rtl_mdl tb_mdl 
	@echo "**[MAKE]** Start simulation in GUI mode."
	@vsim \
		-lib $(_LIB_) \
		-sv_lib $(_MDL_LIB_)\
		-gui \
		-voptargs='$(_VOPTARGS_)'\
		-l $(_SIM_LOG_)\
		$(PLUSARGS)\
		$(_COVERAGE_)\
		-do 'source wave.do; source run_blinkled.tcl' \
	        BlinkLed_tb &	
	         
	        
sim_sh: ref_mdl rtl_mdl tb_mdl
	@echo "**[MAKE]** start simulation in shell mode."
	@vsim \
	       	-lib $(_LIB_) \
		-c \
		-voptargs='$(_VOPTARGS_)'\
		$(PLUSARGS) \
		$(_COVERAGE_)\
		-l $(_SIM_LOG_) \
		-do 'source run_blinkled.tcl'\
		BlinkLed_tb
sim: sim_ui

clean:
	@echo "**[MAKE]** Cleaning simulation directory and library $(LIB)."
	if [ -d $(_LIB_) ]; then rm -rf $(_LIB_); fi
	rm -f $(_HDL_LOG_)
	rm -f $(_HVL_LOG_)
	rm -f $(_SIM_LOG_)
	rm -f *.rpt
	rm -f vsim.wlf
	rm -f transcript
	rm -f Makefile~
	rm -rf reports
	rm -f *.so
	rm -f *.o 
	#rm *~


help:
	@echo
	@echo "USAGE    : make [options] <target(s)>"
	@echo
	@echo "TARGETS  : help        - Show the help (this text)."
	@echo
	@echo "           (default)   - Compile and simulate the design (GUI-based)."
	@echo "           ref_mod_lib - Create the shared library containing the C reference model."
	@echo "           dpiheader   - Recreates the DPI header to be included in the C reference model."
	@echo "           cmp         - Compile the design."
	@echo "           sim         - Start default simulation (GUI-based)."
	@echo "           sim_sh      - Start shell-based simulation."
	@echo "           sim_ui      - Start GUI-based simulation.".
	@echo "           clean       - Clean simulation directory." 
	@echo


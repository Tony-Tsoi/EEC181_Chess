# Makefile for running Cadence simulation and Matlab
# on UC Davis ECE Linux machines
# Some adopted from Makefile used in EEC281, written by Prof Bevan Baas

# Parameters
NAME	:= eval_tb

# Default
default:
	@echo "TODO: write a brief help message"

# Run simulation in NCVerilog
run:
	ncverilog +access+r -l $(NAME).logv -f $(NAME).vfv

# View waveform
viewer:
	simvision &

# Start Matlab
ml:
	matlab -nosplash -nodesktop -sd $(CURDIR)
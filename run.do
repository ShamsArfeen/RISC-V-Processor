vlib  work
vlog *.v
vsim -novopt work.tb
view wave
add wave -r /*
run 80ns
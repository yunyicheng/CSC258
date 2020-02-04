vlib work
vlog -timescale 1ns/1ns mux_seven_to_one.v
vsim mux_seven_to_one
log {/*}
add wave {/*}

force {SW[9]} 0 0, 1 40 -repeat 80
force {SW[8]} 0 0, 1 20 -repeat 40
force {SW[7]} 0 0, 1 10 -repeat 20

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1

run 80 ns

force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 1

run 80 ns


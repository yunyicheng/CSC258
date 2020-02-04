vlib work
vlog -timescale 1ns/1ns ripple_carry_adder.v
vsim ripple_carry_adder
log {/*}
add wave {/*}

# Add 15 and 15
force {SW[0]} 0
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 1
force {SW[9]} 1
run 10 ns

# Add 0 and 0
force {SW[0]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
force {SW[9]} 0
run 10 ns

# Add 2 and 3
force {SW[0]} 0
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1
force {SW[8]} 0
force {SW[9]} 0
run 10 ns

# Add 5 and 8
force {SW[0]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 0
force {SW[8]} 1
force {SW[9]} 0
run 10 ns

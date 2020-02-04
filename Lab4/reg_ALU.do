vlib work

vlog -timescale 1ns/1ns reg_ALU.v

vsim reg_ALU

log {/*}
add wave {/*}

# Reset
force {SW[9]} 0
force {SW[7:5]} 2#000
force {SW[3:0]} 2#0000
force {KEY[0]} 0 0 ns, 1 5 ns -r 10
run 20ns

#
force {SW[9]} 1
force {SW[7:5]} 2#000 0, 2#001 10, 2#010 20, 2#011 30, 2#100 40, 2#101 50, 2#110 60 , 2#111 70 -r 80
force {SW[3:0]} 2#0001
force {KEY[0]} 0 0 ns, 1 5 ns -r 10
run 160ns

# Test reset_n
force {SW[9]} 0
force {SW[7:5]} 2#000
force {SW[3:0]} 2#0001 0, 2#0010 10 -r 20
force {KEY[0]} 0 0 ns, 1 5 ns -r 10
run 40ns

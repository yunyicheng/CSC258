vlib work

vlog -timescale 1ns/1ns ALU.v

vsim ALU

log {/*}
add wave {/*}


# Testcase 1
force {SW[7: 0]} 2#01010101
force {KEY[2: 0]} 2#101 0, 2#100 10, 2#011 20, 2#010 30, 2#001 40, 2#000 50, 2#111 60 -r 70
run 70ns

# Testcase 2
force {SW[7: 0]} 2#00001111
force {KEY[2: 0]} 2#101 0, 2#100 10, 2#011 20, 2#010 30, 2#001 40, 2#000 50, 2#111 60 -r 70
run 70ns

# Testcase 3
force {SW[7: 0]} 2#00110011
force {KEY[2: 0]} 2#101 0, 2#100 10, 2#011 20, 2#010 30, 2#001 40, 2#000 50, 2#111 60 -r 70
run 70ns

# Testcase 4
force {SW[7: 0]} 2#11111111
force {KEY[2: 0]} 2#101 0, 2#100 10, 2#011 20, 2#010 30, 2#001 40, 2#000 50, 2#111 60 -r 70
run 70ns

# Testcase 5
force {SW[7: 0]} 2#00000000
force {KEY[2: 0]} 2#101 0, 2#100 10, 2#011 20, 2#010 30, 2#001 40, 2#000 50, 2#111 60 -r 70
run 70ns

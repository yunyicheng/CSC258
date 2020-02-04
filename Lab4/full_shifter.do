vlib work
vlog -timescale 1ns/1ns full_shifter.v
vsim full_shifter

log {/*}
add wave {/*}

log {/*}
add wave {/*}

# ASR 1, ShiftRight 1
# SW[9] = reset_n;
force {SW[9]} 0 0, 1 5, 0 100, 1 105
# SW[7:0] = LoadVal[7:0];
force {SW[7: 0]} 10101010 0, 10101010 100
# KEY[0] = clk;
force {KEY[0]} 0 0, 1 5 -r 10
# KEY[1] = Load_n;
force {KEY[1]} 0 10, 1 20, 0 110, 1 120
# KEY[2] = ShiftRight;
force {KEY[2]} 1
# KEY[3] = ASR
force {KEY[3]} 1
run 180ns

# ASR 0, ShiftRight 0
# LEDR = q
# SW[9] = reset_n;
force {SW[9]} 0 0, 1 5, 0 100, 1 105
# SW[7:0] = LoadVal[7:0];
force {SW[7: 0]} 10101010 0, 10101010 100
# KEY[0] = clk;
force {KEY[0]} 0 0, 1 5 -r 10
# KEY[1] = Load_n;
force {KEY[1]} 0 10, 1 20, 0 110, 1 120
# KEY[2] = ShiftRight;
force {KEY[2]} 0
# KEY[3] = ASR
force {KEY[3]} 0
run 180ns

# ASR 0, ShiftRight 1
# LEDR = q
# SW[9] = reset_n;
force {SW[9]} 0 0, 1 5, 0 100, 1 105
# SW[7:0] = LoadVal[7:0];
force {SW[7: 0]} 10101010 0, 10101010 100
# KEY[0] = clk;
force {KEY[0]} 0 0, 1 5 -r 10
# KEY[1] = Load_n;
force {KEY[1]} 0 10, 1 20, 0 110, 1 120
# KEY[2] = ShiftRight;
force {KEY[2]} 1
# KEY[3] = ASR
force {KEY[3]} 0
run 180ns

# ASR 1, ShiftRight 0
# LEDR = q
# SW[9] = reset_n;
force {SW[9]} 0 0, 1 5, 0 100, 1 105
# SW[7:0] = LoadVal[7:0];
force {SW[7: 0]} 10101010 0, 10101010 100
# KEY[0] = clk;
force {KEY[0]} 0 0, 1 5 -r 10
# KEY[1] = Load_n;
force {KEY[1]} 0 10, 1 20, 0 110, 1 120
# KEY[2] = ShiftRight;
force {KEY[2]} 0
# KEY[3] = ASR
force {KEY[3]} 1
run 180ns

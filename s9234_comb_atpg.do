read_verilog s9234_comb.v
set_current_design s9234_comb


set system mode atpg

add_faults -all
create_patterns
write_patterns s9234_comb_tests.ascii
report_faults > s9234_comb_faults.txt

exit -d

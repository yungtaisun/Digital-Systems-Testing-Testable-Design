add clocks 0 CK

set test cycle 2

setup pin strobes 1

set system mode fault

set pattern source external s9234_scan.ascii

load faults s9234_hope.faults

run

report faults > sequential_sim.faults
report statistics
exit -d

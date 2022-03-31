# Clock on E3
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clock];

# reset
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports {reset}];

# inputs
set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports {in2}];
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {in1}];
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports {in0}];

set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {in_buy}];
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {is_insufficient}];

set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {seg_cat[6]}];
set_property -dict {PACKAGE_PIN R10 IOSTANDARD LVCMOS33} [get_ports {seg_cat[5]}];
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {seg_cat[4]}];
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {seg_cat[3]}];
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports {seg_cat[2]}];
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {seg_cat[1]}];
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports {seg_cat[0]}];

set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {seg_an[0]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {seg_an[1]}]
set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33}  [get_ports {seg_an[2]}]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {seg_an[3]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {seg_an[4]}]
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {seg_an[5]}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33}  [get_ports {seg_an[6]}]
set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {seg_an[7]}]

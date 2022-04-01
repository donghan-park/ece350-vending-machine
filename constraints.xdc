# Clock on E3
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clock];

# reset
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports {reset}];


set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {motor_in1}];
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports {motor_in0}];
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports {motor_out}];

# inputs
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports {in2}];
set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports {in1}];
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports {in0}];

set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {in_buy}];
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports {is_insufficient}];

set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports {seg_cat[7]}];
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports {seg_cat[6]}];
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {seg_cat[5]}];
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports {seg_cat[4]}];
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {seg_cat[3]}];
set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports {seg_cat[2]}];
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports {seg_cat[1]}];
set_property -dict {PACKAGE_PIN F18 IOSTANDARD LVCMOS33} [get_ports {seg_cat[0]}];

set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports {seg_an[0]}]
set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports {seg_an[1]}]
set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS33}  [get_ports {seg_an[2]}]
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports {seg_an[3]}]

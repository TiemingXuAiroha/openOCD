# Choose Altera USB-Blaster as JTAG interface
source [find ./tcl/interface/altera-usb-blaster.cfg]
usb_blaster pin6 1
usb_blaster pin8 1

# Configure the target
source [find ./tcl/target/or1k_vjtag.cfg]

# Set GDB port
gdb_port 50001

# Select the TAP core we are using
tap_select vjtag
#tap_select mohor

# Select the debug unit core we are using. This debug unit as an option.
# If ADBG_USE_HISPEED is set (options bit 1), status bits will be skipped
# on burst reads and writes to improve download speeds.
# This option must match the RTL configured option.

du_select adv 1
#du_select mohor

# Add a new register in the cpu register list. This register will be
# included in the generated target descriptor file.
# format is addreg [name] [address] [feature] [reg_group]

#addreg rtest 0x1234 group0 newgroup

# Override default init_reset
proc init_reset {mode} {
	soft_reset_halt
	resume
}

# Target initialization
init
echo "Halting processor"
halt

foreach name [target names] {
    set y [$name cget -endian]
    set z [$name cget -type]
    puts [format "Chip is %s, Endian: %s, type: %s" \
                  $name $y $z]
}

set c_blue  "\033\[01;34m"
set c_reset "\033\[0m"

puts [format "%sTarget ready...%s" $c_blue $c_reset]

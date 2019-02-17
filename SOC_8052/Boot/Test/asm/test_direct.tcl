# Script mostly from:
# http://quartushelp.altera.com/current/mergedProjects/tafs/tafs/tcl_pkg_jtag_ver_1.0_cmd_get_device_names.htm
#
# List all available programming hardwares, and select the USBBlaster.
# (Note: this example assumes only one USBBlaster connected.)
#puts "JTAG chains:"

if { [catch get_hardware_names] } {
	post_message -type error "USB-Blaster hardware not found."
	exit
}

foreach hardware_name [get_hardware_names] {
	post_message -type info "Hardware name: $hardware_name"
	if { [string match "USB-Blaster*" $hardware_name] } {
		set usbblaster_name $hardware_name
	}
	if { [string match "DE-SoC*" $hardware_name] } {
		set usbblaster_name $hardware_name
	}
}

# List all devices on the chain, and select the first device on the chain.
#puts "\nDevices available on JTAG chain:"
set target_device "0"
foreach device_name [get_device_names -hardware_name $usbblaster_name] {
	post_message -type info  "Device name: $device_name"
	if { [string match "@1*" $device_name] } {
		set target_device $device_name
	}
}

# The DE1-SoC's FPGA is device number 2
if { [string match "@1: SOCVHPS*" $target_device] } {
	set target_device "0"
	foreach device_name [get_device_names -hardware_name $usbblaster_name] {
		post_message -type info  "Device name: $device_name"
		if { [string match "@2*" $device_name] } {
			set target_device $device_name
		}
	}
}

if {$target_device==0} {
	post_message -type error "Target device not found."
	exit
}

set lastbyte "0"
set mem_list [get_editable_mem_instances -hardware_name $usbblaster_name -device_name $target_device]
foreach i $mem_list {
	# puts "[lindex $i 0],[lindex $i 1],[lindex $i 2],[lindex $i 3],[lindex $i 4],[lindex $i 5]"
	if {"DEBU"==[lindex $i 5]} {
		set myindex [lindex $i 0]
		set lastbyte [expr [lindex $i 1]-1]
		post_message -type info "Valid memory found. Name: [lindex $i 5], Index: $myindex, Size: $lastbyte"
	}
}

if {$lastbyte==0} {
	post_message -type error "'DEBU' memory not found in target device."
	exit
}

post_message -type info "Connecting to $usbblaster_name $target_device\n";
catch [begin_memory_edit -hardware_name $usbblaster_name -device_name $target_device]

#fconfigure stdin -translation binary -buffering none -blocking false
fconfigure stdin -blocking false

while {1} {
    gets stdin line
    set data_len [string length $line]
    
    if {"EXIT"==[string toupper $line]} {
	    break
    }
    
    # Send the received line to the target memory
    set hex_string ""
    if {$data_len != "0"} then {
		for {set i 0} {$i < [string length $line]} {incr i} {
			set char [string index $line $i]
			scan $char %c ascii
			set hex_string [format "%02X" $ascii]$hex_string
		}
		#puts "sending $hex_string, which has $i characters"
		write_content_to_memory -instance_index $myindex -start_address 1 -word_count $i -content "$hex_string" -content_in_hex
		set hex_string "[format "%02X" $i]"
		#puts "Setting first byte to $hex_string"
		write_content_to_memory -instance_index $myindex -start_address 0 -word_count 1 -content "$hex_string" -content_in_hex
    }

	set count [read_content_from_memory -instance_index $myindex -start_address 0x100 -word_count 1 -content_in_hex]
	#puts "Count: $count"
	set countd [expr 0x$count]
	set mystr ""
	if {$countd!=0} {
		set received [read_content_from_memory -instance_index $myindex -start_address 0x101 -word_count $countd -content_in_hex]
		for {set i 0} {$i<$countd} {incr i} {
			set ascii_hex [string range $received [expr $i*2] [expr $i*2+1]]
			set mystr [format "%c" [expr 0x$ascii_hex]]$mystr
		}
		puts -nonewline "$mystr\r\n"
		write_content_to_memory -instance_index $myindex -start_address 0x100 -word_count 1 -content "00" -content_in_hex
	}
}
end_memory_edit

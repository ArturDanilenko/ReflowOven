puts ""
puts "Connecting to memory..."
begin_memory_edit -hardware_name "USB-Blaster \[USB-1\]" -device_name "@1: 5CE(BA4|FA4) (0x02B050DD)"
puts "Uploading HEX file '[lindex $argv 0]'..."
update_content_to_memory_from_file -instance_index 0 -mem_file_path "[lindex $argv 0]" -mem_file_type hex
puts "Sending command to copy hex file to 'flash' memory..."
write_content_to_memory -instance_index 0 -start_address 0x7fff -word_count 1 -content "55" -content_in_hex
end_memory_edit
puts "Done.."
puts ""


set system_name "NudleOS"
set system_version "1.0.0"
set system_architecture "x86_64"
proc get_system_info {} {
    global system_name system_version system_architecture
    return "Name: $system_name, Version: $system_version, Architecture: $system_architecture"
}
puts ("Hello World!")
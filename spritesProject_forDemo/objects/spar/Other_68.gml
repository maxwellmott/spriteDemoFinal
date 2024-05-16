/// @description Insert description here
// You can write your code in this editor

if (async_load[? "size"] > 0) {
	var buff = async_load[? "buffer"];
	var msg = buffer_read(buff, buffer_string);
	
	show_debug_message(msg);
	
	data = json_decode(msg);
	
	var t = data[? "type"];
	
	online_message_handler(t);
	
	ds_map_clear(data);
}
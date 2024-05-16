/// @description Insert description here
// You can write your code in this editor

var i_d = ds_map_find_value(async_load, "id");
if (i_d == searchID) {
	if (ds_map_find_value(async_load, "status")) {
		if (ds_map_find_value(async_load, "result") != "") {
			join_private_room_begin(ds_map_find_value(async_load, "result"));	
		}
	}
}
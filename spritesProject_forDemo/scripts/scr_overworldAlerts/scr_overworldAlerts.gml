// enumerator containing overworld alert IDs
enum overworldAlerts {
	swimStart,
	swimStop,
	doorLocked,
	doorUnlocked,
	noRoom,
	height
}

// enumerator containing overworld alert params
enum overworldAlertParams {
	ID,
	text,
	ynPrompt,
	func,
	height
}

// get all the text concerning overworldAlerts from the attached csv file
var textGrid = load_csv("overworldAlerts_english.csv");

// initialize overworldAlertsGrid
global.overworldAlertsGrid = ds_grid_create(overworldAlertParams.height, overworldAlerts.height);

// create the master grid add function
function master_grid_add_overworld_alert(_id, _text, _ynPrompt, _function) {
	var i = 0; repeat (overworldAlertParams.height) {
		global.overworldAlertsGrid[# i, _id] = argument[i];
		
		i++;
	}
}

///@desc This function is called when an overworld alert of the type START SWIMMING is pushed
function start_swimming() {
	switch (player.facing) {
		case directions.east:	var xx = player.x + 32;	var yy = player.y;	break;
		case directions.south:	var yy = player.y + 32;	var xx = player.x;	break;
		case directions.west:	var xx = player.x - 32;	var yy = player.y;	break;
		case directions.north:	var yy = player.y - 32;	var xx = player.x;	break;
	}
	
	if (check_water_get_in(xx, yy)) {
		player.x = xx;
		player.y = yy;
		player.swimming = true;
	}	else	{
		ds_list_push(overworld.alertStack, overworldAlerts.noRoom);
	}
}

///@desc This function is called when an overworld alert of the type STOP SWIMMING is pushed
function stop_swimming() {	
	switch (player.facing) {
		case directions.east:	var xx = player.x + 32;	var yy = player.y;	break;
		case directions.south:	var yy = player.y + 32;	var xx = player.x;	break;
		case directions.west:	var xx = player.x - 32;	var yy = player.y;	break;
		case directions.north:	var yy = player.y - 32;	var xx = player.x;	break;
	}
	
	if (check_water_get_out(xx, yy)) {
		player.x = xx;
		player.y = yy;
		player.swimming = false;
	}	else	{
		ds_list_push(overworld.alertStack, overworldAlerts.noRoom);
	}
}

// add all overworldAlerts to the master grid
master_grid_add_overworld_alert(overworldAlerts.swimStart,		textGrid[# 1, overworldAlerts.swimStart],		true,	start_swimming);
master_grid_add_overworld_alert(overworldAlerts.swimStop,		textGrid[# 1, overworldAlerts.swimStop],		true,	stop_swimming);
master_grid_add_overworld_alert(overworldAlerts.doorLocked,		textGrid[# 1, overworldAlerts.doorLocked],		false,	noone);
master_grid_add_overworld_alert(overworldAlerts.doorUnlocked,	textGrid[# 1, overworldAlerts.doorUnlocked],	false,	noone);
master_grid_add_overworld_alert(overworldAlerts.noRoom,			textGrid[# 1, overworldAlerts.noRoom],			false,	noone);

// encode master grid
global.allOverworldAlerts = encode_grid(global.overworldAlertsGrid);

// destroy temp grids
ds_grid_destroy(global.overworldAlertsGrid);
ds_grid_destroy(textGrid);
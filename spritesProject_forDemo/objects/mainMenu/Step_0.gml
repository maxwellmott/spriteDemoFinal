/// @desc

// fade in
if (alpha < targetAlpha) {
	alpha += 0.05;
}

// get button names
if (index == 0) {tbName = nameList[| ds_list_size(nameList) - 1];}
else {tbName = nameList[| index - 1];}

cbName = nameList[| index];

if (index == ds_list_size(nameList) - 1) {bbName = nameList[| 0];}
else {bbName = nameList[| index + 1];}

// @TODO get button functions

// @TODO SET BUTTON FUNCTIONS

// process menu movement
index += global.menu_down;
index -= global.menu_up;

// wrap index
if (index >= ds_list_size(nameList)) {index -= ds_list_size(nameList);}
if (index < 0) {index += ds_list_size(nameList);}

// correct the hours for non-military time
drawHours = string(player.hours mod 12);
drawMinutes = string(player.minutes);
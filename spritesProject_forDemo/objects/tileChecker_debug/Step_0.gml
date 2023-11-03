/// @description Insert description here
// You can write your code in this editor

x = mouse_x;
y = mouse_y;

if !(tile_meeting(x, y, overworld.tilemapList[|1], waterTileChecker)) && !(tile_meeting(x, y, overworld.tilemapList[|2], collidableTileChecker)) {
	image_blend = c_green;	
}	else	{
	image_blend = c_red;
}
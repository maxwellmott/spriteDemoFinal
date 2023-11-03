// inherit parent create event
event_inherited();

sprite_index	= sendportMask;
spriteID		= spr_sendport;

// initialize arrivingNPCs list
arrivingNPCs = ds_list_create();

spawnReady	= true;
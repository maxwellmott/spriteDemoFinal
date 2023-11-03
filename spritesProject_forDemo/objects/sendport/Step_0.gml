// inherit parent event
event_inherited();

// if there are arrivingNPCs and spawnReady is true, 
// generate the next npc and set the alarm
if (ds_list_size(arrivingNPCs) > 0) {
	if spawnReady sendport_spawn_npcs();	
	
	if !spawnReady 
	&& alarm[0] < 0		alarm[0] = 60;
}
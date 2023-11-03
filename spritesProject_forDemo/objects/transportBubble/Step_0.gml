if !(playerTransport) {
	if arriving 
	&& targetHuman >= 0 {
		var spawn = instance_create_depth(x, y - 1, depth - 1, npc);
		spawn.ID = targetHuman;
		ds_list_add(scheduleManager.presentNPCs, spawn);
		
		instance_destroy(id);
	}
}
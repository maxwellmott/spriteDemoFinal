// delete teamList
ds_list_destroy(teamList);

// delete spriteGrid
ds_grid_destroy(spriteGrid);

// if you're online, move to spellbook builder
if (instance_exists(onlineEnemy)) {
	room_transition(player.x, player.y, player.facing, rm_spellbookBuilder, bgm_menuTheme);	
}	else	{
	room_transition(player.x, player.y, player.facing, rm_overworld, bgm_springRelaxSunny);	
}
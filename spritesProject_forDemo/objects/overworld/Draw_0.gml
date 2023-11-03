/// @desc

if !(global.roomBuilt) {
	overworld_create_all_npc_sprites();
	overworld_create_player_sprite();
	global.roomBuilt = true;
}
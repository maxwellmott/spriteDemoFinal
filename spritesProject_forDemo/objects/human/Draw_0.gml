// must contain empty draw event

if (instance_exists(overworld)) {
	if (object_index == npc)		draw_npc();

	if (object_index == player)		player_draw_from_state();
}
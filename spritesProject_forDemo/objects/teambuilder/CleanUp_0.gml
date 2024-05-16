// delete teamList
ds_list_destroy(teamList);

// delete spriteGrid
ds_grid_destroy(spriteGrid);

// if you're online, move to spellbook builder
// FOR TESTING PURPOSES, IGNORE THIS HEURISTIC

// if you're in the main menu, go back to the main menu

room_transition(player.x, player.y, player.facing, rm_spellbookBuilder);
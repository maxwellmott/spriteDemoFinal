/// @description Insert description here
// You can write your code in this editor

// check if either player has an extra spell 
// that needs to be removed
if (ds_list_size(player.spellBook) > 8) {
	ds_list_delete(player.spellBook, 8);	
}

if (playerTwo == enemyAI) {
	if (ds_list_size(playerTwo.spellBook) > 8) {
		ds_list_delete(playerTwo.spellBook, 8);
	}
}

// reset spellBook and spellBookGrid for player
player.spellBookString = encode_list(player.spellBook);

ds_list_destroy(player.spellBook);
ds_grid_destroy(player.spellBookGrid);

// destroy turn grid
ds_grid_destroy(spar.turnGrid);

player.miasma = false;
player.hum = false;
player.rust = false;
player.currentHP = MAX_HP;
player.currentMP = MAX_MP;
ds_list_destroy(player.teamList);
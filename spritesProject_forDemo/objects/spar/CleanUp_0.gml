/// @description Insert description here
// You can write your code in this editor

// reset opponent
global.opponent = -1;

ds_list_destroy(player.spellBookList);
ds_grid_destroy(player.spellBookGrid);

// destroy turn grid
ds_grid_destroy(spar.turnGrid);

// reset all player spar params
player.miasma = false;
player.hum = false;
player.rust = false;
player.currentHP = MAX_HP;
player.currentMP = MAX_MP;

ds_list_destroy(player.teamList);
ds_list_destroy(player.spellBookList);
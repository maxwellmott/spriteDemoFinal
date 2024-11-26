// create an enumerator for the enemy ai grid's x axis
enum ENEMY_AI_PARAMS {
	NPC_ID,
	ROSTER_LIST,
	SPELLBOOK_LIST,
	SELECTION_ALGO_LIST,
	HEIGHT
}

	/*	
		the enemy ai grid will contain lists of different items used to construct their
		enemy ai during a spar. 
		
		each list will collectively house groups of items with matching indeces. I may end up creating
		enumerators for each NPCs respective ai parameter groups to make it easier.
		
		the idea is that when the player passes certain landmarks in the game, different NPCs might become
		stronger or more experienced. When this happens, the next group of ai parameters should be taken from
		the lists on this grid and placed on the npc grid (which will then be saved/loaded by the player)
	*/ 

// create the enemy ai grid
global.enemyAiGrid = ds_grid_create(ENEMY_AI_PARAMS.HEIGHT, npcs.height);

// create a function to add to the enemy ai grid
function master_grid_add_enemy_ai(_ID) {
	// use a repeat loop to add all items
	var i = 0;	repeat (ENEMY_AI_PARAMS.HEIGHT) {
		ds_grid_add(global.enemyAiGrid, i, _ID, argument[i]);
	
		// increment i
		i++;
	}
}

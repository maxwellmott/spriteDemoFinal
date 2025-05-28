/// @description Insert description here
// You can write your code in this editor
tied = false;

winner = -1;

p1 = spar.playerOne;
p2 = spar.playerTwo;

if (p2.currentHP <= 0) {
	winner = p1;	
	text = "YOU WIN!";
}

if (p1.currentHP <= 0) {
	winner = p2;	
	text = "YOU LOSE!";
}

// check if this is a local match
if !(instance_exists(onlineEnemy)) {
	var npcID = player.enemy.ID;
	
	// if the player won
	if (winner == p1) {
		var pWon = true;
	}
	// if the player lost
	else {
		var pWon = false;		
	}
	
	// adjust the player's lastMatchResultsList
	player_update_last_match_results_list(npcID, pWon);
	
	// perform a todo list check for spar complete
	player_check_update_todo_list(TODO_LIST_CHECK_TYPES.SPAR_COMPLETE);
}
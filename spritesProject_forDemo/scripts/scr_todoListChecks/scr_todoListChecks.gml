// declare an enum containing all types of todoListChecks
enum TODO_LIST_CHECK_TYPES {					// ARGUMENTS EXPECTED ON THE TRIGGER LISTS (EXCLUDING ID) ANY TRIGGER LIST CAN BE OVERLOADED WITH A LIST OF PARAMETERS FOR FAILURE
	SPAR_WON,									// NPC TO SPAR,				LIST OF SPRITES TO USE (IF ANY)	
	SPAR_LOST,									// NPC TO SPAR,				LIST OF SPRITES TO USE (IF ANY)
	SPAR_COMPLETE,								// NPC TO SPAR				LIST OF SPRITES TO USE (IF ANY)
	DIALOGUE_PERFORMED,							// DIALOGUE KEY
	RESPONSE_GIVEN,								// NPC TO SPEAK TO,			DIALOGUE KEY,	RESPONSE TO SELECT
	BOOK_PAGE_READ,								// BOOK TO READ,			PAGE TO READ
	TASK_PROGRESS,								// TASK TO PROGRESS IN,		STEP TO PROGRESS PAST
	TASK_COMPLETION,							// TASK TO COMPLETE
	TASK_FAILURE,								// TASK TO FAIL,			STEP FAILED ON
	ITEM_GIVEN,									// ITEM TO GIVE,			NPC TO GIVE ITEM TO
	DOOR_USED,									// DOOR TO USE
	GATE_USED,									// LOCATION TO EXIT,		DIRECTION TO EXIT FROM
	SPELL_USED_SPAR,							// SPELL TO USE,			NPC TO USE SPELL AGAINST (IF ANY),		SPRITE TO USE SPELL WITH (IF ANY),				SPRITE TO USE SPELL AGAINST (IF ANY)
	SPELL_USED_OVERWORLD,						// SPELL TO USE,			LOCAITON TO USE SPELL IN (IF ANY),		LIST OF BBOX VALS FOR CAST REGION (IF ANY),		OBJECT CAST NEAR (IF ANY),		NPC CAST NEAR (IF ANY),		SPRITE CAST NEAR (IF ANY)
	DAY_BEGINS,									// DAY OF THE SEASON,		SEASON (IF ANY)
	HOUR_BEGINS,								// HOUR OF THE DAY,			DAY (IF ANY)
	SEASON_BEGINS,								// SEASON TO BEGIN,			YEAR (IF ANY)
	YEAR_BEGINS,								// YEAR TO BEGIN
	SPELL_UNLOCKED,								// SPELL ID
	SPRITE_UNLOCKED,							// SPRITE ID
	CLOTHING_UNLOCKED,							// APPEARANCE PARAM ID,		ID OF THAT APPEARANCE PARAM TYPE (OUTFITS.____)
	HEIGHT	
}

function player_check_update_todo_list(_todoListCheckType) {
	// store args in locals
	var type = _todoListCheckType;
	
	// decode the player's todo list
	var l = ds_list_create();
	decode_list(player.todoList, l);
	
	// decode the tasks grid
	var g = ds_grid_create(TASK_PARAMS.HEIGHT, TASKS.HEIGHT);
	decode_grid(global.allTasks, g);
	
	switch (type) {
		case TODO_LIST_CHECK_TYPES.SPAR_WON:
			// use a repeat loop to check each item on the player's todo list
			
			// get arguments from list
			
			// check if the current values match the respective values given in the arguments
				
				// if all conditionals are satisfied, 
			
		break;
		
		case TODO_LIST_CHECK_TYPES.SPAR_LOST:
		
		break;
		
		case TODO_LIST_CHECK_TYPES.SPAR_COMPLETE:
			// use a repeat loop to check each item on the player's todo list
			var i = 0;	repeat (ds_list_size(l)) {
				// get the next task id
				var tid = i;
				
				// correct the value for -1 and nonreal
				if (l[| tid] == "-1") {
					l[| tid] = -1;
				}
				else {
					l[| tid] = real(l[| tid]);	
				}
				
				// get the next step id
				var sid = l[| tid];
				
				// get the full trigger list
				var ftl = ds_list_create();
				decode_list(g[# TASK_PARAMS.TRIGGER_LIST, tid], ftl);
				
				// get the arguments list for the current step off the full trigger list
				var args = ds_list_create();
				decode_list(ftl[| sid], args);
				
				// get arguments from list
				var npcID = real(args[| 1]);
				var spriteList = -1;
			
				// check if there is a spriteList to decode
				if (args[| 2] != "-1") {
					// decode spriteList
					spriteList = ds_list_create();
					decode_list(args[| 2], spriteList);
				}
				
				// initialize the allSpritesPresent boolean variable
				var allSpritesPresent = true;
				
				// check if there is a spriteList
				if (spriteList != -1) {
					// use a repeat loop to check if all sprites are present
					var j = 0;	repeat (ds_list_size(spriteList)) {
						// check if the given sprite is NOT on the player's team
						if (ds_list_find_index(player.teamList, spriteList[| j]) == -1) {
							// set allSpritesPresent to false
							allSpritesPresent = false;
							
							// break the loop
							break;
						}
						
						// increment j
						j++;
					}
				}
				
				// check if the current values match the respective values given in the arguments
				if (spar.playerTwo.ID == npcID)
				&& (allSpritesPresent) {
					// if all conditionals are satisfied, 
					player_update_todoList(tid, false);
				}
				
				// increment i
				i++;
				
				// destroy temp lists
				ds_list_destroy(ftl);
				ds_list_destroy(args);
			}
		break;
		
		case TODO_LIST_CHECK_TYPES.DIALOGUE_PERFORMED:
			var i = 0;	repeat (ds_list_size(l)) {
				// get the next task id
				var tid = i;
				
				// correct the value for -1 and nonreal
				if (l[| tid] == "-1") {
					l[| tid] = -1;
				}
				else {
					l[| tid] = real(l[| tid]);	
				}
				
				// get the next step id
				var sid = l[| tid];
				
				// get the full trigger list
				var ftl = ds_list_create();
				decode_list(g[# TASK_PARAMS.TRIGGER_LIST, tid], ftl);
				
				// get the arguments list for the current step off the full trigger list
				var args = ds_list_create();
				decode_list(ftl[| sid], args);
				
				// check if dialogueKey is equal to the first arg
				if (dialogueKey == args[| 1]) {
					player_update_todoList(tid, false);	
				}
				
				// increment i
				i++;
				
				// destroy the temp lists
				ds_list_destroy(ftl);
				ds_list_destroy(args);
			}
		break;
	}
	
	// destroy the temp list and temp grid
	ds_list_destroy(l);
	ds_grid_destroy(g);
}
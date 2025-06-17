// create a list of nonPostGameTasks
var npgtList = ds_list_create();

// populate list
//ds_list_add(npgtList,		);

// encode the now populated npgtList
global.nonPostGameTasks = "";

// create a list of postGameAlternateTasks pairings
var pgatList = ds_list_create();

// populate list			// MAIN GAME TASK							// RESPECTIVE POSTGAME TASK
//ds_list_add(pgatList,		string(TASKS.PREFESTIVAL_JITTERS)+","+		string(TASKS.HEIGHT));

// declare an enumerator to contain all task IDs
enum TASKS {
	PREFESTIVAL_JITTERS,
	HEIGHT
}

// declare an enumerator to contain all task parameters
enum TASK_PARAMS {
	ID,
	NAME,
	TRIGGER_LIST,
	INSTRUCTIONS_LIST,
	MULLIGAN,
	HEIGHT
}

// get all text from csv file
var textGrid = load_csv("TASKS_ENGLISH.csv");

// create all trigger lists
var prefestivalJittersTriggers = ds_list_create();

// populate all trigger lists			ID															ARG 1									ARG 2
ds_list_add(prefestivalJittersTriggers,	"<`"+string(TODO_LIST_CHECK_TYPES.DIALOGUE_PERFORMED)+""+	"`bookishTaskPrompt>",
										"<`"+string(TODO_LIST_CHECK_TYPES.SPAR_COMPLETE)+""+		"`"+string(npcs.mercurioGallant)+""+	"`"+string(-1)+">");

// create the task master grid
global.taskGrid = ds_grid_create(TASK_PARAMS.HEIGHT, TASKS.HEIGHT);

// create a function to add tasks to the master grid
function master_grid_add_task(_ID, _name, _instructionsList, _mulligan) {
	var i = 0;	repeat (TASK_PARAMS.HEIGHT) {
		// set next param on the grid
		global.taskGrid[# i, _ID] = argument[i];
		
		// increment i
		i++;
	}
}

// add all tasks	 ID							NAME										TRIGGER LIST										INSTRUCTIONS LIST
master_grid_add_task(TASKS.PREFESTIVAL_JITTERS, textGrid[# 1, TASKS.PREFESTIVAL_JITTERS],	encode_list(prefestivalJittersTriggers),			textGrid[# 2, TASKS.PREFESTIVAL_JITTERS],	false);

// encode the master grid
global.allTasks = encode_grid(global.taskGrid);

// delete the taskGrid
ds_grid_destroy(global.taskGrid);

// create all functions pertaining to tasks

///@desc This function is called whenever the player completes a step in a task
function player_update_todoList(_taskID, _failed) {
	// store args in locals
	var tid = _taskID;
	var f	= _failed;
	
	// decode the player's todoList
	var tdList = ds_list_create();
	decode_list(player.todoList, tdList);
	
	// check that this is not a failure
	if !(f) {
		// increment the given task
		if (tdList[| tid] == "-1") {
			tdList[| tid] = 0;
		}	else	{
			tdList[| tid] = real(tdList[| tid]) + 1;
		}
		
		// get the number of steps for this task
		var s = task_get_step_count(tid);
		
		// check if the player has surpassed the final step
		if (real(tdList[| tid]) >= s) {
			player_add_completed_task(tid);
		}
		
	}
	// if this was a failure
	else {
		// reset the 
		tdList[| tid] = -1;
		
		// add the failed task
		player_add_failed_task(tid);
	}
	
	// push an unlockAlert for todoList update
	player_push_unlock_alert(UNLOCK_TYPES.TODO_LIST_UPDATE);
	
	// encode the todoList
	player.todoList = encode_list(tdList);
}

function player_add_completed_task(_taskID) {
	// store args in locals
	var tid = _taskID;
	
	// decode player's completedTasks list
	var l = ds_list_create();
	decode_list(player.failedTasks, l);
	
	// add this task to the player's completed tasks
	ds_list_add(l, tid);
	
	// encode player's completedTasks list
	player.completedTasks = encode_list(l);
}

function player_add_failed_task(_taskID) {
	// store args in locals
	var tid = _taskID;
	
	// decode player's failedTasks list
	var l = ds_list_create();
	decode_list(player.failedTasks, l);
	
	// add this task to the player's failed tasks
	ds_list_add(l, tid);
	
	// encode player's failedTasks list
	player.failedTasks = encode_list(l);
}

function player_task_check_failed(_taskID) {
	// store args in locals
	var tid = _taskID;
	
	// decode the player's list of failedTasks
	var l = ds_list_create();
	decode_list(player.failedTasks, l);
	
	// check if this task is on the player's failedTasks list
	if (ds_list_find_index(l, tid) != -1) {
		// return that this task has been failed
		return true;
	}
	// if this task is not on the player's failedTasks list
	else {
		// return that this task has NOT been failed
		return false;
	}
}

function player_task_check_completed(_taskID) {
	// store args in locals
	var tid = _taskID;
	
	// decode the player's list of completedTasks
	var l = ds_list_create();
	decode_list(player.completedTasks, l);
	
	// check if this task is on the player's completedTasks list
	if (ds_list_find_index(l, tid) != -1) {
		// return that this task has been completed
		return true;
	}
	// if this task is not on the player's completedTasks list
	else {
		// return that this task has NOT been failed
		return false;
	}
}

function player_task_check_active(_taskID) {
	// store args in locals
	var tid = _taskID;
	
	// check if this task is failed, completed, or not started
	if (player_task_check_failed(tid))
	|| (player_task_check_completed(tid))
	|| (player_task_get_step_num(tid) == -1) {
		// return that this task is NOT active
		return false;
	}
	// if this task has not been failed or completed, and has been started
	else {
		// return that this task IS active
		return true;
	}
}

function player_task_get_step_num(_taskID) {
	// store args in locals
	var tid = _taskID;
	
	// decode the player's todoList
	var tdList = ds_list_create();
	decode_list(player.todoList, tdList);
	
	// get the current step for the given task
	var s = tdList[| tid];
	
	// check if the task is unstarted
	if (s == "-1") {
		// return -1 to indicate that the task is not started
		return -1
	}
	// if the task has been started
	else {
		// return the current step num
		return real(s);
	}
}

///@desc This function will be called when the player
/// finally moves into the postgame phase. Any nonPostGameTasks
/// will be auto-failed, and any postGameAlternateTasks will swap
/// their progress value with their respective mainGame counterparts
function player_update_todo_list_for_postgame() {
	
}

///@desc This function will be called when the player
/// decides or is forced to reset the time loop. All task
/// progress will be reset (excluding completed tasks)
function player_update_todo_list_time_loop() {
	
}

function task_get_step_count(_taskID) {
	// decode the task grid
	var g = ds_grid_create(TASK_PARAMS.HEIGHT, TASKS.HEIGHT);
	decode_grid(global.allTasks, g);
	
	// get the number of steps for this task
}






///@desc This function is used to draw the surface for the player's todoList menu
function player_todo_list_create_surface() {
	// decode nameList and descriptionList
	
	// initialize windowWidth and windowHeight
	
	// initialize surfaceWidth
	surfaceWidth = guiWidth - 24;

	// initialize surfaceHeight
	
	// initialize surfaceDrawX and surfaceDrawY
	
	// initialize nameDrawX and descriptionDrawX
	
	// intialize textDrawY
	
	// initialize surfaceWindowRatio 
	
	// use a repeat loop to draw each item
	
		// draw name from name list
		
		// draw description from description list
		
		// draw separator
		
}
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
ds_list_add(prefestivalJittersTriggers,	"<`"+string(TODO_LIST_CHECK_TYPES.DIALOGUE_PERFORMED)+		"`bookishTaskPrompt>",
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
	player_push_unlock_alert(UNLOCK_TYPES.todoList_UPDATE);
	
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
function player_update_todoList_for_postgame() {
	
}

///@desc This function will be called when the player
/// decides or is forced to reset the time loop. All task
/// progress will be reset (excluding completed tasks)
function player_update_todoList_time_loop() {
	
}

function task_get_step_count(_taskID) {
	// store args in locals
	var tid = _taskID;
	
	// decode the task grid
	var g = ds_grid_create(TASK_PARAMS.HEIGHT, TASKS.HEIGHT);
	decode_grid(global.allTasks, g);
	
	// decode the list of steps for this task
	var l = ds_list_create();
	decode_list(g[# TASK_PARAMS.TRIGGER_LIST, tid], l);
	
	// return the number of steps for this task
	return ds_list_size(l);
}






///@desc This function is used to draw the surface for the player's todoList menu
function todoList_create_surface() {
	// check if there is any text
	if (text != "") {
		// initialize windowWidth and windowHeight
		windowWidth = 224;
		windowHeight = 160;
		
		// initialize surfaceWidth
		surfaceWidth = 224;
		
		// initialize surfaceDrawX and surfaceDrawY
		surfaceDrawX = 16;
		surfaceDrawY = 24
		
		// initialize nameDrawX and descriptionDrawX
		nameDrawX = 64;
		descriptionDrawX = 192;
		
		// get surfaceHeight
		surfaceHeight = string_height(text) + 8 + (string_width(text) / (windowWidth - 16));
		
		// get textDrawY
		textDrawY = 8;
		
		// surfaceWindowRatio
		surfaceWindowRatio = surfaceHeight / windowHeight;
		
		// initialize scrollBarStartY
		scrollBarStartY = 48;
		
		// initialize scrollBarEndY
		scrollBarEndY = 136;
		
		// get scrollBarHeight
		scrollBarHeight = (scrollBarEndY - scrollBarStartY) * surfaceWindowRatio;
		
		// initialize scrollBarIndex
		scrollBarIndex = 0;
		
		// initialize scrollBarBottom
		scrollBarBottom = scrollBarIndex + scrollBarHeight + scrollBarStartY;
		
		// create the textSurface
		textSurface = surface_create(surfaceWidth, surfaceHeight);
	}
}

///@desc This function is used to build the text for the player's todoList menu
function todoList_build_text() {
	// initialize text
	text = "";
	
	// decode task grid
	var tg = ds_grid_create(TASK_PARAMS.HEIGHT, TASKS.HEIGHT);
	decode_grid(global.allTasks, tg);
	
	// decode player todoList
	var tdl = ds_list_create();
	decode_list(player.todoList, tdl);
	
	// check if there are any started tasks
	if (ds_list_size(tdl) > 0) {
		// use a repeat loop to add each item
		var i = 0;	repeat (ds_list_size(tdl)) {
			// check if the task has been started
			if (tdl[| i] != "-1") {
				// decode instructions list for this item
				var il = ds_list_create();
				decode_list(tg[# TASK_PARAMS.INSTRUCTIONS_LIST, i], il);
				
				// get the name and description of the task
				var name = tg[# TASK_PARAMS.NAME, i];
				var description = il[| i];
				
				// add name and description to text
				text += name;
				text += "\n";
				text += "\n";
				text += description;
				text += "\n";
				text += "\n";
				text += "\n";
				
				// increment i
				i++;
			}
		}
	}
	
	/*
	// decode completed tasks list
	var ctl = ds_list_create();
	decode_list(player.completedTasks, ctl);
	
	// check if there are any completed tasks
	if (ds_list_size(ctl) > 0) {
		// add header
		text += "COMPLETED TASKS";
		text += "\n";
		text += "\n";
		
		// use a repeat loop to add each item
		var i = 0;	repeat (ds_list_size(tdl)) {
			// get the name of the task
			var name = tg[# TASK_PARAMS.NAME, ctl[| i]];
			
			// add the name
			text += name;
			text += "\n";
			
			i++;
		}
		
		text += "\n";
	}
	
	// decode failed tasks list
	var ftl = ds_list_create();
	decode_list(player.failedTasks, ftl);
	
	// check if there are any failed tasks
	if (ds_list_size(ftl) > 0) {
		// add header
		text += "FAILED TASKS";
		text += "\n";
		text += "\n";
		
		// use a repeat loop to add each item
		var i = 0;	repeat (ds_list_size(tdl)) {
			// get the name of the task
			var name = tg[# TASK_PARAMS.NAME, ftl[| i]];
			
			// add the name
			text += name;
			text += "\n";
			
			i++;
		}
		
		text += "\n";
	}
	*/
}

///@desc This function is called in the step event of the todoMenu. It gets and
/// processes any input that would alter the position of the scrollBar
function todoList_check_scrollBar() {
	// check if scrollBar has not reached the bottom
	if (scrollBarBottom < scrollBarEndY) {
		// check for controller input
		if (global.menuDown) {
			// increment scrollBarIndex
			scrollBarIndex++;		
		}
		
		// check for mouse click
			// check for mouse collision
				// move it to mouse y
					// clamp it to scrollBarEndY
	}
	
	// check if scrollBar has not reached the top
	if (scrollBarIndex > 0) {
		// check for controller input
		if (global.menuUp) {	
			// decrement scrollBarIndex
			scrollBarIndex--;	
		}
		
		// check for mouse click
			// check for mouse collision
				// move it to mouse y
					// clamp it to scrollBarEndY
	}
}

function todoList_draw_text() {
	// ensure that the surface exists
	if !(surface_exists(textSurface)) {
		textSurface = surface_create(surfaceWidth, surfaceHeight);
	}
	
	// draw surface part
	draw_surface_part(textSurface, 0, scrollBarIndex, windowWidth, windowHeight, surfaceDrawX, surfaceDrawY);
}

function todoList_create_text_surface() {
	// ensure that the textSurface exists
	if !(surface_exists(textSurface)) {
		textSurface = surface_create(surfaceWidth, surfaceHeight);
	}
	
	// set surface target
	surface_set_target(textSurface);
	
		// set draw params
		draw_set(fa_center, fa_top, 1.0, $0ecc2e);
	
		// draw the text to the surface
		draw_text_pixel_perfect(surfaceWidth / 2, textDrawY, text, 9, surfaceWidth - 16);
		
	// reset surface target
	surface_reset_target();
}

function todoList_draw_scrollBar() {
	
}
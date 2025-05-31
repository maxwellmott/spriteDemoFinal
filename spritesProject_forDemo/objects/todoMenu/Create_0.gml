// decode player's todoList
todoList = ds_list_create();
decode_list(player.todoList, todoList);

// decode player's failedTasks list
failedList = ds_list_create();
decode_list(player.failedTasks, failedList);

// decode player's completedTasks list
completedList = ds_list_create();
decode_list(player.completedTasks, completedList);

// initialize scrollBarStartY
scrollBarStartY = 32;

// initialize scrollBarTop
scrollBarTop = 0;

// draw the player's todoList surface
player_todo_list_create_surface();

/*  To trigger a callback function use the SetStruct() and include the value 
of the corresponding callback, for example : CallBackID: 100
will fire the CallBack100 function when data is returned from the 
SendStructure() network event. We are open to a better way to do this but 
could not figure anything else out that was reletively simple.
*/

function CallBack100(ReturnStructure){
	
	var name	= ds_map_find_value(ReturnStructure, "name");
	
	var token1	= ds_map_find_value(ReturnStructure, "token1");
	var token2	= ds_map_find_value(ReturnStructure, "token2");
	var token3	= ds_map_find_value(ReturnStructure, "token3");
	var token4	= ds_map_find_value(ReturnStructure, "token4");
	
	playerOther.characterName	= name;
	
	playerOther.team_list[| 0]	= token1;
	playerOther.team_list[| 1]	= token2;
	playerOther.team_list[| 2]	= token3;
	playerOther.team_list[| 3]	= token4;
	
	playerOther.listSet = true;	
	
}

function CallBack101(ReturnStructure){
	
	var user1	= ds_map_find_value(ReturnStructure, "user1");
	var move1	= ds_map_find_value(ReturnStructure, "move1");
	var target1 = ds_map_find_value(ReturnStructure, "target1");
	
	var user2	= ds_map_find_value(ReturnStructure, "user2");
	var move2	= ds_map_find_value(ReturnStructure, "move2");
	var target2 = ds_map_find_value(ReturnStructure, "target2");
	
	var user3	= ds_map_find_value(ReturnStructure, "user3");
	var move3	= ds_map_find_value(ReturnStructure, "move3");
	var target3 = ds_map_find_value(ReturnStructure, "target3");
	
	var user4	= ds_map_find_value(ReturnStructure, "user4");
	var move4	= ds_map_find_value(ReturnStructure, "move4");
	var target4 = ds_map_find_value(ReturnStructure, "target4");
	
	
	global.turn_grid[# 0, 4]	=	user1;
	global.turn_grid[# 0, 5]	=	user2;
	global.turn_grid[# 0, 6]	=	user3;
	global.turn_grid[# 0, 7]	=	user4;
	
	global.turn_grid[# 1, 4]	=	move1;
	global.turn_grid[# 1, 5]	=	move2;
	global.turn_grid[# 1, 6]	=	move3;
	global.turn_grid[# 1, 7]	=	move4;
	
	global.turn_grid[# 2, 4]	=	target1;
	global.turn_grid[# 2, 5]	=	target2;
	global.turn_grid[# 2, 6]	=	target3;
	global.turn_grid[# 2, 7]	=	target4;
	
	global.playerTwo.gridSet = true;
	
}
function CallBack102(ReturnStructure){
	obj_Enemy_Online.chosen_tea = ds_map_find_value(ReturnStructure, "_index");
	obj_Enemy_Online.teaSelected = true;
}
function CallBack103(ReturnStructure){
	global.fasterPlayer = ds_map_find_value(ReturnStructure, "_player");
	global.fasterPlayerSet = true;
}
function CallBack104(ReturnStructure){
	
}

function PlayerJoinedRoom(NewPlayerID,NewX,NewY){
	//this function is fired when a new player comes into the room
	//in our example here, we add the playerOther object to the room
	//and set its ID so it can update itself as new positions comein
	var inst = instance_create_layer(NewX, NewY, "Instances", playerOther);
	inst.MyPlayerID=NewPlayerID;	
	
	//send my location back to the newly registered player
	MultiPlayer.SetHeroXY(MultiPlayer.PlayerID,x+1,y+1);
}

function PlayerLeftRoom(OldPlayerID){
	//you can put code here or write hooks to call object functions and variables	
	with playerOther {
		//tell it to destroy itself
		if MyPlayerID==OldPlayerID then MyPlayerID=-1;		
	}
}
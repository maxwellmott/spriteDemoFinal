#macro	SERVER_ADDRESS		"20.119.8.57"

enum CLIENT_TYPES {
	HOST,
	GUEST,
	HEIGHT
}

enum CLIENT_SCOPES {
	PRIVATE,
	RANKED,
	HEIGHT
}

// create message type enum
enum MESSAGE_TYPES  {
    QUEUE_ADD_CLIENT,		// a client queued up for matchmaking and a new host or guest must be added to the proper list
    CLIENT_GET_HOSTS,		// a guest was added to the guest list and must be sent the host list to find a host
	CLIENT_JOIN_HOST,		// a client received the client queue and sent back the ID of the client it would like to join
    CLIENT_END_SESSION,		// a client has decided to remove themselves from matchmaking
    PRIVATE_HOST_CREATE,	// a client is hosting a private room and must be assigned an ID
    GUEST_JOIN_PRIVATE,		// a client is submitting the ID of a private room to search for and join
    CLIENT_SUBMIT_TEAM,		// a client is sending their selected team to the other player in the room
    CLIENT_SUBMIT_TURN,		// a client is submitting their turn to the other player in the room
    CLIENT_REQUEST_TEAM,	// a client has submitted their team and is now requesting the other player's team
    CLIENT_REQUEST_TURN,	// a client has submitted their turn and is now requestin the other player's turn
    CONNECTION_TEST,		// the server is sending a message to initiate a handshake between two clients
    CLIENT_TEAM_RECEIPT,    // the client is sending a message confirming that they received the enemyTeam
    CLIENT_TURN_RECEIPT,    // the client is sending a message confirming that they received the enemyTurn
    HOST_CHECK_FOR_GUEST,   // the host is checking the current state of the server RE finding a guest
    ROOM_JOIN_FAILURE,		// the server is sending a message to a client stating that they failed to join the room
	READY_FOR_MATCH,		// the client is sending a message to the server stating that they are ready to begin the match
	CHECK_ENEMY_READY,		// the client is sending a message to the server checking if their opponent is also ready to begin
    HEIGHT              
}

// create all session beginning functions (called by the onlineLobby mainMenu buttons)
function request_turn_begin() {
	show_debug_message("Checking if opponent's turn has been submitted...");
	
	ds_map_add(data, "type",		MESSAGE_TYPES.CLIENT_REQUEST_TURN);
	ds_map_add(data, "clientID",	player.clientID);
	ds_map_add(data, "enemyTurn",	"");
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, 80, onlineBuffer, buffer_tell(onlineBuffer));
}

function client_set_match_ready() {
	show_debug_message("Alerting server that client is ready to begin!");
	
	ds_map_add(data, "clientID",	player.clientID);
	ds_map_add(data, "type",		MESSAGE_TYPES.READY_FOR_MATCH);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, 80, onlineBuffer, buffer_tell(onlineBuffer));
}

function ready_check_begin() {
	show_debug_message("Checking if opponent is ready to begin...");
	
	ds_map_add(data, "type",		MESSAGE_TYPES.CHECK_ENEMY_READY);
	ds_map_add(data, "clientID",	player.clientID);
	ds_map_add(data, "ready",		false);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, 80, onlineBuffer, buffer_tell(onlineBuffer));
}

function request_team_begin() {
	show_debug_message("Checking if opponent's team has been submitted...");
	
	ds_map_add(data, "type",		MESSAGE_TYPES.CLIENT_REQUEST_TEAM);
	ds_map_add(data, "clientID",	player.clientID);
	ds_map_add(data, "enemyTeam",	"");
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, 80, onlineBuffer, buffer_tell(onlineBuffer));
}

function submit_team_begin() {
	show_debug_message("Submitting team selection...");
	
	ds_map_add(data, "type",		MESSAGE_TYPES.CLIENT_SUBMIT_TEAM);
	ds_map_add(data, "team",		player.teamString);
	ds_map_add(data, "clientID",	player.clientID);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, 80, onlineBuffer, buffer_tell(onlineBuffer));
}

function connection_test_begin() {
	show_debug_message("Beginning connection test...");
	
	ds_map_add(data, "type", MESSAGE_TYPES.CONNECTION_TEST);
	ds_map_add(data, "time", get_timer());
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, 80, onlineBuffer, buffer_tell(onlineBuffer));
}

function private_room_search_prompt() {
	searchID = get_string_async("Enter roomID to search for!", "");
}

function find_ranked_match_begin() {
	ds_map_add(data, "name", player.name);
	ds_map_add(data, "rank", player.onlineRating);
	ds_map_add(data, "type", MESSAGE_TYPES.QUEUE_ADD_CLIENT);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, 80, onlineBuffer, buffer_tell(onlineBuffer));
}

function create_private_room_begin() {
	ds_map_add(data, "rank", player.onlineRating);
	ds_map_add(data, "type", MESSAGE_TYPES.PRIVATE_HOST_CREATE);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, 80, onlineBuffer, buffer_tell(onlineBuffer));
}

function join_private_room_begin(_roomID) {
	var rid = _roomID;
	
	ds_map_add(data, "clientID",	-1);
	
	ds_map_add(data, "roomID",		rid);
	ds_map_add(data, "name",		player.name);
	ds_map_add(data, "rank",		player.onlineRating);
	ds_map_add(data, "type",		MESSAGE_TYPES.GUEST_JOIN_PRIVATE);
	
	ds_map_add(data, "hostID",		-1);
	ds_map_add(data, "hostRank",	-1);
	ds_map_add(data, "hostName",	-1);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, 80, onlineBuffer, buffer_tell(onlineBuffer));
}

function send_guest_check() {
	ds_map_add(data, "clientID",	player.clientID);
	ds_map_add(data, "guestFound",	false);
	ds_map_add(data, "guestName",	-1);
	ds_map_add(data, "guestRank",	-1);
	ds_map_add(data, "type",		MESSAGE_TYPES.HOST_CHECK_FOR_GUEST);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, 80, onlineBuffer, buffer_tell(onlineBuffer));
}

// create message manager
function online_message_handler(_type) {
	var type = _type;
	
	switch (type) {
		case MESSAGE_TYPES.QUEUE_ADD_CLIENT:
			queue_add_client();
		break;
		
		case MESSAGE_TYPES.CLIENT_GET_HOSTS:
			client_get_hosts();
		break;
		
		case MESSAGE_TYPES.CLIENT_JOIN_HOST:
			client_join_host();
		break;
		
		case MESSAGE_TYPES.CLIENT_END_SESSION:
			client_end_session();
		break;
		
		case MESSAGE_TYPES.PRIVATE_HOST_CREATE:
			private_host_create();
		break;
		
		case MESSAGE_TYPES.GUEST_JOIN_PRIVATE:
			guest_join_private();
		break;
		
		case MESSAGE_TYPES.CLIENT_SUBMIT_TEAM:
			client_submit_team();
		break;
		
		case MESSAGE_TYPES.CLIENT_SUBMIT_TURN:
			client_submit_turn();
		break;
		
		case MESSAGE_TYPES.CLIENT_REQUEST_TEAM:
			client_request_team();
		break;
		
		case MESSAGE_TYPES.CLIENT_REQUEST_TURN:
			client_request_turn();
		break;
		
		case MESSAGE_TYPES.CONNECTION_TEST:
			connection_test();
		break;
		
		case MESSAGE_TYPES.CLIENT_TEAM_RECEIPT:
			client_team_receipt();
		break;
		
		case MESSAGE_TYPES.CLIENT_TURN_RECEIPT:
			client_turn_receipt();
		break;
		
		case MESSAGE_TYPES.HOST_CHECK_FOR_GUEST:
			host_check_for_guest();
		break;
		
		case MESSAGE_TYPES.ROOM_JOIN_FAILURE:
			room_join_failure();
		break;
		
		case MESSAGE_TYPES.READY_FOR_MATCH:
			ready_for_match();
		break;
		
		case MESSAGE_TYPES.CHECK_ENEMY_READY:
			check_enemy_ready();
		break;
	}
}

#region MESSAGE RECEIPT FUNCTIONS
function queue_add_client() {
	player.clientID		= data[? "clientID"];
	player.clientType	= data[? "clientType"];
	player.clientScope	= CLIENT_SCOPES.RANKED;
	
	inLobby = true;
	
	show_debug_message("Player successfully joined the matchmaking queue!");
}

function client_get_hosts() {
	
}

function client_join_host() {
}

function client_end_session() {
}

function private_host_create() {
	player.clientID		= data[? "clientID"];
	player.roomID		= data[? "roomID"];
	player.clientScope	= CLIENT_SCOPES.PRIVATE;
	player.clientType	= CLIENT_TYPES.HOST;
	
	inLobby = true;
	
	show_debug_message("Player successfully created a private online room!");
}

function guest_join_private() {
	player.clientID		= data[? "clientID"];
	player.roomID		= data[? "roomID"];
	player.clientType	= CLIENT_TYPES.GUEST;
	player.clientScope	= CLIENT_SCOPES.PRIVATE;
	
	var inst = instance_create_depth(0, 0, get_layer_depth(LAYER.meta), onlineEnemy);

	inst.name			= data[? "hostName"];
	inst.onlineRating	= data[? "hostRank"];
	inst.onlineID		= data[? "hostID"];
	inst.roomID			= data[? "roomID"];
	
	inLobby = true;
	
	show_debug_message("Player successfully joined a private online room!");
}

function client_submit_team() {
	show_debug_message("Team successfully submitted to server!");
}

function client_submit_turn() {
	show_debug_message("Turn " + string(spar.turnCounter) + " successfully submitted to server!");
}

function client_request_team() {
	if (data[? "enemyTeam"] != "") 
	&& (data[? "enemyTeam"] != -1) {
		show_debug_message("Enemy team has been received!");
		
		onlineEnemy.teamString = data[? "enemyTeam"];
		
		room_transition(player.x, player.y, player.facing, rm_spellbookBuilder);
	}
	else {
		show_debug_message("Enemy team has not yet been submitted...");	
	}
}

function client_request_turn() {
	if (data[? "enemyTurn"] != "") 
	&& (data[? "enemyTurn"] != -1) {
		show_debug_message("Enemy turn has been received!");
		
		// get turnGrid string
		var g = ds_grid_create(4, 4);
		
		// decode turnGrid string
		decode_grid(data[? "enemyTurn"], g);
		
		var i = 0;	repeat (4) {
		
			var inst = spar.spriteList[| 4 + i];
			
			var s =	g[# selectionPhases.ally,	i];
			var a =	g[# selectionPhases.action,	i];
			var t =	g[# selectionPhases.target,	i];
			var l =	g[# selectionPhases.height,	i];
			
			if (t != "-1") {
				t = real(t);
			}
			else {
				t = -1;	
			}
			
			s = real(s);
			a = real(a);
			l = real(l);
		
			// add all turn data to spar.turnGrid
			spar.turnGrid[# selectionPhases.ally,	inst.spotNum] = 4 + s;	
			spar.turnGrid[# selectionPhases.action,	inst.spotNum] = a;
			
			if (t > 3) {
				spar.turnGrid[# selectionPhases.target, inst.spotNum] = t - 4;	
			}
			
			if (t < 4) {
				spar.turnGrid[# selectionPhases.target, inst.spotNum] = t + 4;	
			}
			
			spar.turnGrid[# selectionPhases.height,	inst.spotNum] = l;
			
			// increment i
			i++;
		}
		
		spar.onlineWaiting = false;
		onlineEnemy.ready = true;
	}
	else {
		show_debug_message("Enemy turn has not yet been submitted...");
	}
}

function connection_test() {
	var newTime = get_timer();
	
	var oldTime = data[? "time"];
	
	var diff = newTime - oldTime;
	
	// if this test is being done by two clients in a private room
	if (player.clientScope == CLIENT_SCOPES.PRIVATE) {
		// check if time difference is greater than 30 seconds
		if (diff >= 800000) {
			// connection test failed
			show_debug_message("Connection test failed!");
		}
		else {
			// connection test success
			show_debug_message("Connection test success!");
			
			// transition to teambuilder
			room_transition(player.x, player.y, player.facing, rm_teambuilder);	
		}
		
	}
}

function client_turn_receipt() {
}

function host_check_for_guest() {
	var guestBool = data[? "guestFound"];
	
	if (guestBool) {
		var inst = instance_create_depth(0, 0, get_layer_depth(LAYER.meta), onlineEnemy);
		
		inst.name			= data[? "guestName"];
		inst.onlineRating	= data[? "guestRank"];
		inst.onlineID		= data[? "guestID"];
		
		show_debug_message("Host player has successfully been connected with guest!");
	}
	
	if !(guestBool) {
		show_debug_message("Host player still searching for guest...");
	}
}

function ready_for_match() {
	show_debug_message("matchReady successfully updated!");
}

function check_enemy_ready() {
	if (data[? "ready"]) {
		show_debug_message("Both players are ready to begin!");
		
		room_transition(player.x, player.y, player.facing, rm_battleScene);
	}
	else {
		show_debug_message("Enemy is not yet ready to begin...");
	}
}

function room_join_failure() {
}

#endregion

#region MESSAGE SENDING FUNCTIONS
	
#endregion
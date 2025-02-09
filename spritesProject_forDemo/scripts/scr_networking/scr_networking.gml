// this macro currently returns the shared IP of the azure web app I had been working on. Eventually
// it will have to change to the shared IP of the VM that Brendan set up.
#macro	SERVER_ADDRESS		"20.120.169.102"
#macro	PORT_NUM			3000
// this is an enumerator with an identical twin on the server-side. These values are used
// to indicate whether a player is a host or a guest. this value is initially determined
// server-side
enum CLIENT_TYPES {
	HOST,
	GUEST,
	HEIGHT
}

// this is an enumerator with an identical twin on the server-side. These values are used
// to indicate whether a player is searching for a ranked match or a private room. This value
// is initially determined client-side
enum CLIENT_SCOPES {
	PRIVATE,
	RANKED,
	HEIGHT
}

// this is an enumerator with an identical twin on the server-side. These values are used
// to indicate the "type" of a message that is being sent/received. This is the index of the state
// machine being used to manage the whole server
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
	CLIENT_CANCEL_TEAM,		// the client is backing out of team selection
	CLIENT_CANCEL_SPELLBOOK,	// the client is backing out of spellbook selection
	CLIENT_CANCEL_TURN,		// the client is backing out of turn selection
	HEIGHT              
}

///@desc This function contains the switch statement central to the client-side state machine that manages online
/// communications. Each potential state has a matching function named in lower case that is called when the client 
/// receives a message of that type
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
		break;
		
		case MESSAGE_TYPES.CLIENT_TURN_RECEIPT:
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
		
		case MESSAGE_TYPES.CLIENT_CANCEL_TEAM:
			client_cancel_team();
		break;
		
		case MESSAGE_TYPES.CLIENT_CANCEL_SPELLBOOK:
			client_cancel_spellbook();
		break;
		
		case MESSAGE_TYPES.CLIENT_CANCEL_TURN:
			client_cancel_turn();
	}
}

#region FUNCTIONS CALLED WHEN A MESSAGE FROM THE SERVER IS RECEIVED 

///@desc This function is called when the client receives a message from the server indicating that this client
/// was successfully added to the matchmaking queue. The function stores the given values (client ID, type, and 
/// scope) and puts the player in an online waiting room.
function queue_add_client() {
	player.clientID		= data[? "clientID"];
	player.clientType	= data[? "clientType"];
	player.clientScope	= CLIENT_SCOPES.RANKED;
	
	inLobby = true;
	
	show_debug_message("Player successfully joined the matchmaking queue!");
}

///@desc This function is called when the client receives a message from the server indicating that this client
/// is a guest and must therefore download a list of hosts to choose from. The function will check through the
/// list to find a few adequate matches. It will then check if the first choice is still available
function client_get_hosts() {
	
}

///@desc This function is called when the client receives a message from the server indicating that the host this
/// client chose as a matchmaking partner does not have a partner already and can therefore go ahead with a 
/// connection test
function client_join_host() {
}

///@desc This function is called when this client or their partner has ended the session, resulting in the game being
/// closed and the player returning to the onlineMenu
function client_end_session() {
}

///@desc This function is called when the client receives a message from the server indicating that this client
/// has successfully created a private room. The function stores the given values (client Id, scope, type, and
/// roomID) and puts the player in an online waiting room
function private_host_create() {
	player.clientID		= data[? "clientID"];
	player.roomID		= data[? "roomID"];
	player.clientScope	= CLIENT_SCOPES.PRIVATE;
	player.clientType	= CLIENT_TYPES.HOST;
	
	// get the message that confirms the update system is working through github pushes
	var updateMsg = data[? "updateMsg"];
	
	inLobby = true;
	
	show_debug_message("Player successfully created a private online room!");
	
	show_debug_message(updateMsg);
}

///@desc This function is called when the client receives a message from the server indicating that this client
/// has successfully joined a private room. The function stores the given values (client ID, scope, type, and
/// roomID) as well as information regarding the host (name, rank, clientID) then puts the player in an 
/// online waiting room.
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

///@desc This function is called when the client receives a message from the server indicating that this client
/// has successfully joined a private room. It is merely here as an indicator as nothing needs to change 
/// client-side upon receiving this message
function client_submit_team() {
	show_debug_message("Team successfully submitted to server!");
}

///@desc This function is called when the client receives a message from the server indicating that this client
/// has successfully sugmitted their turn. It is merely here as an indicator as nothing needs to change
/// client-side upon receiving this message
function client_submit_turn() {
	show_debug_message("Turn " + string(spar.turnCounter) + " successfully submitted to server!");
}

///@desc This function is called when the client receives a message from the server indicating that this client
/// has successfully requested the enemy team from the server. If the enemyTeam was present server-side, then 
/// the function will store the enemy team and move the player into the spellBookBuilder
function client_request_team() {
	if (data[? "enemyTeam"] != "") 
	&& (data[? "enemyTeam"] != -1) {
		show_debug_message("Enemy team has been received!");
		
		onlineEnemy.teamString = data[? "enemyTeam"];
		
		room_transition(player.x, player.y, player.facing, rm_spellbookBuilder, bgm_menuTheme);
	}
	else {
		show_debug_message("Enemy team has not yet been submitted...");	
	}
}

///@desc This function is called when the client receives a message from the server indicating that this client
/// has successfully requested the enemy turn from the server. If the enemyTurn was present server-side, then
/// the function will add the enemy turn data to the turnGrid and the next turn in the spar will begin being processed
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
			
			var s =	g[# TURN_GRID.ALLY,		i];
			var a =	g[# TURN_GRID.ACTION,	i];
			var t =	g[# TURN_GRID.TARGET,	i];
			var l =	g[# TURN_GRID.LUCK,	i];
			
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
			spar.turnGrid[# TURN_GRID.ALLY,	inst.spotNum] = 4 + s;	
			spar.turnGrid[# TURN_GRID.ACTION,	inst.spotNum] = a;
			
			if (t != -1) {
				if (t > 3) {
					spar.turnGrid[# TURN_GRID.TARGET, inst.spotNum] = t - 4;	
				}
				
				if (t < 4) {
					spar.turnGrid[# TURN_GRID.TARGET, inst.spotNum] = t + 4;	
				}
			}
			
			spar.turnGrid[# TURN_GRID.LUCK,	inst.spotNum] = l;
			
			// increment i
			i++;
		}

		onlineEnemy.ready = true;
	}
	else {
		show_debug_message("Enemy turn has not yet been submitted...");
	}
}

///@desc This function is called when the client receives a message from the server indicating that this client
/// has successfully executed a connection_test. The function will get the time sent by this client earlier, and
/// compare it with the current time to determine if the connection between this client and the server is fast
/// enough to begin a spar
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
			room_transition(player.x, player.y, player.facing, rm_teambuilder, bgm_menuTheme);	
		}
		
	}
}

///@desc This function is called when the client receives a message from the server indicating that this client
/// has successfully sent the periodic message asking if their is a guest present in the room being hosted by
/// this client. If there was a guest present server-side, this function will store the given values (guest name,
/// rank, and clientID) in a new instance of onlineEnemy
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

///@desc This function is called when the client receives a message from the server indicating that this client
/// has successfully notified the server that they are ready to begin a spar. It is merely here as an indicator
/// as nothing needs to change client-side upon receiving this message
function ready_for_match() {
	show_debug_message("matchReady successfully updated!");
}

///@desc This function is called when the client receives a message from the server indicating that this client
/// has successfully checked with the server to see if their opponent is ready to begin the spar. If their opponent
/// is ready, the player will be placed in a spar.
function check_enemy_ready() {
	if (data[? "ready"]) {
		show_debug_message("Both players are ready to begin!");
		
		room_transition(player.x, player.y, player.facing, rm_battleScene, bgm_sparNormal);
	}
	else {
		show_debug_message("Enemy is not yet ready to begin...");
	}
}

///@desc This function is called when the client receives a message from the server indicating that this client
/// has failed to join whatever room they were attempting to join. This will create a notification that once
/// closed will put the player back in the onlineMenu
function room_join_failure() {
}

#endregion

#region FUNCTIONS THAT SEND MESSAGES TO THE SERVER

///@desc This function is called periodically when this client has submitted their
/// turn in an online match. The function sends a message to the server asking if 
/// their opponent has submitted their turn yet.
function request_turn_begin() {
	show_debug_message("Checking if opponent's turn has been submitted...");
	
	ds_map_add(data, "type",		MESSAGE_TYPES.CLIENT_REQUEST_TURN);
	ds_map_add(data, "clientID",	player.clientID);
	ds_map_add(data, "enemyTurn",	"");
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, PORT_NUM, onlineBuffer, buffer_tell(onlineBuffer));
}

///@desc This function is called when this client has finalized their spellbook selections for
/// the match. It tells the server that they are ready to enter the match whenever their opponent
/// is ready.
function client_set_match_ready() {
	show_debug_message("Alerting server that client is ready to begin!");
	
	ds_map_add(data, "clientID",	player.clientID);
	ds_map_add(data, "type",		MESSAGE_TYPES.READY_FOR_MATCH);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, PORT_NUM, onlineBuffer, buffer_tell(onlineBuffer));
}

///@desc This function is called when the client has backed out of their spellbook selection
/// for the match. It tells the server that they are no longer ready to enter the match as
/// they would like to reselect their spells.
function player_cancel_spellbook() {
	show_debug_message("Cancelling spellbook selection...");
	
	ds_map_add(data, "clientID",	player.clientID);
	ds_map_add(data, "type",		MESSAGE_TYPES.CLIENT_CANCEL_SPELLBOOK);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, PORT_NUM, onlineBuffer, buffer_tell(onlineBuffer));
}

///@desc This function is called periodically once this client has told the server
/// that they are ready to begin the match. The function sends a message to the 
/// server asking if their opponent is ready to begin the match as well.
function ready_check_begin() {
	show_debug_message("Checking if opponent is ready to begin...");
	
	ds_map_add(data, "type",		MESSAGE_TYPES.CHECK_ENEMY_READY);
	ds_map_add(data, "clientID",	player.clientID);
	ds_map_add(data, "ready",		false);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, PORT_NUM, onlineBuffer, buffer_tell(onlineBuffer));
}

///@desc This function is called periodically once this client has submitted their
/// team selection to the server. The function sends a message to the server asking
/// if their opponent has submitted their team yet.
function request_team_begin() {
	show_debug_message("Checking if opponent's team has been submitted...");
	
	ds_map_add(data, "type",		MESSAGE_TYPES.CLIENT_REQUEST_TEAM);
	ds_map_add(data, "clientID",	player.clientID);
	ds_map_add(data, "enemyTeam",	"");
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, PORT_NUM, onlineBuffer, buffer_tell(onlineBuffer));
}

///@desc This function is called when this client has finalized their team selection for the match.
/// It sends a message containing an encoded version of the client's team list
function submit_team_begin() {
	show_debug_message("Submitting team selection...");
	
	ds_map_add(data, "type",		MESSAGE_TYPES.CLIENT_SUBMIT_TEAM);
	ds_map_add(data, "team",		player.teamString);
	ds_map_add(data, "clientID",	player.clientID);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, PORT_NUM, onlineBuffer, buffer_tell(onlineBuffer));
}

///@desc This function is called when the player hits tab after submitting their
/// turn. This cancels their turn submissiona and allows them to reselect
function player_cancel_team() {
	show_debug_message("Cancelling team selection...");
	
	ds_map_add(data, "type",		MESSAGE_TYPES.CLIENT_CANCEL_TEAM);
	ds_map_add(data, "clientID",	player.clientID);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, PORT_NUM, onlineBuffer, buffer_tell(onlineBuffer));
	
	cancelled = true;
}

///@desc This function is called when the server thinks they have found a proper match for this client.
/// The function sends a message to the server containing the current time in microseconds so that the 
/// server can do a speed-check on the connection with this client
function connection_test_begin() {
	show_debug_message("Beginning connection test...");
	
	ds_map_add(data, "type", MESSAGE_TYPES.CONNECTION_TEST);
	ds_map_add(data, "time", get_timer());
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, PORT_NUM, onlineBuffer, buffer_tell(onlineBuffer));
}

///@desc This function creates an async prompt wherein the user can enter the roomId for which they want to search.
/// This will be replaced by a function that creates something more appealing than a proprietary dialogue box.
function private_room_search_prompt() {
	searchID = get_string_async("Enter roomID to search for!", "");
}

///@desc This function is called when the user selects "Find Ranked Match" in the onlineMenu. It sends a message to
/// the server indicating that this client would like to join the matchmaking queue.
function find_ranked_match_begin() {
	ds_map_add(data, "name", player.name);
	ds_map_add(data, "rank", player.onlineRating);
	ds_map_add(data, "type", MESSAGE_TYPES.QUEUE_ADD_CLIENT);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, PORT_NUM, onlineBuffer, buffer_tell(onlineBuffer));
}

///@desc This function is called when the user selects "Create Private Room" in the onlineMenu. It sends a message to
/// the server indicating that this client would like to begin hosting a private room.
function create_private_room_begin() {
	ds_map_add(data, "rank", player.onlineRating);
	ds_map_add(data, "type", MESSAGE_TYPES.PRIVATE_HOST_CREATE);
	
	var dataJson = json_encode(data);
	
	ds_map_clear(data);
	
	buffer_seek(onlineBuffer, buffer_seek_start, 0);
	
	buffer_write(onlineBuffer, buffer_text, dataJson);
	
	network_send_udp_raw(client, SERVER_ADDRESS, PORT_NUM, onlineBuffer, buffer_tell(onlineBuffer));
}

///@desc This function is called when the user has entered a viable roomID into the dialogue box after selecting
/// "Join Private Room" in the onlineMenu. It then sends a message to the server indicating that it would like to
/// join the given room
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
	
	network_send_udp_raw(client, SERVER_ADDRESS, PORT_NUM, onlineBuffer, buffer_tell(onlineBuffer));
}

///@desc This function is called periodically if this client is hosting and waiting for a guest to join. It sends a 
/// message to the server asking if there is a guest in their room yet.
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
	
	network_send_udp_raw(client, SERVER_ADDRESS, PORT_NUM, onlineBuffer, buffer_tell(onlineBuffer));
}

///@desc This function is called when the player successfully cancels their team submission
function client_cancel_team() {
	ds_map_clear(data);
	
	show_debug_message("Player successfully cancelled their team selection!");
	
	onlineWaiting = false;
	
	cancelled = false;
}
	
function client_cancel_turn() {
	ds_map_clear(data);
	
	show_debug_message("Player successfully cancelled their turn selection!");
	
	player.ready = false;
	
	spar.onlineWaiting = false;
	
	spar.turnCancelled = false;
}

function client_cancel_spellbook() {
	ds_map_clear(data);
	
	show_debug_message("Player successfully cancelled their spellbook selection!");
	
	onlineWaiting = false;
	
	cancelled = false;
}
	
#endregion
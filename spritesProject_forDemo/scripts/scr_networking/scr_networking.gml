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
    HEIGHT              
}

// create message manager
function online_message_handler(_type) {
	var type = _type;
	
	switch (type) {
		case MESSAGE_TYPES.QUEUE_ADD_CLIENT:
		break;
		
		case MESSAGE_TYPES.CLIENT_GET_HOSTS:
		break;
		
		case MESSAGE_TYPES.CLIENT_JOIN_HOST:
		break;
		
		case MESSAGE_TYPES.CLIENT_END_SESSION:
		break;
		
		case MESSAGE_TYPES.PRIVATE_HOST_CREATE:
		break;
		
		case MESSAGE_TYPES.GUEST_JOIN_PRIVATE:
		break;
		
		case MESSAGE_TYPES.CLIENT_SUBMIT_TEAM:
		break;
		
		case MESSAGE_TYPES.CLIENT_SUBMIT_TURN:
		break;
		
		case MESSAGE_TYPES.CLIENT_REQUEST_TEAM:
		break;
		
		case MESSAGE_TYPES.CLIENT_REQUEST_TURN:
		break;
		
		case MESSAGE_TYPES.CONNECTION_TEST:
		break;
		
		case MESSAGE_TYPES.CLIENT_TEAM_RECEIPT:
		break;
		
		case MESSAGE_TYPES.CLIENT_TURN_RECEIPT:
		break;
		
		case MESSAGE_TYPES.HOST_CHECK_FOR_GUEST:
		break;
		
		case MESSAGE_TYPES.ROOM_JOIN_FAILURE:
		break;
	}
}

// create all online functions
function queue_add_client() {
}

function client_get_hosts() {
}

function client_join_host() {
}

function client_end_session() {
}

function private_host_create() {
}

function guest_join_private() {
}

function client_submit_team() {
}

function client_submit_turn() {
}

function client_request_team() {
}

function client_request_turn() {
}

function connection_test() {
}

function host_check_for_guest() {
}

function room_join_failure() {
}
///////////////////////////////////////////////////////////////////////////
//DO NOT MODIFY ANYTHING IN THIS OBJECT
///////////////////////////////////////////////////////////////////////////

if ds_map_find_value(async_load, "id") == __GetHTTP {
	if ds_map_find_value(async_load, "status") == 0 {
		__Results = ds_map_find_value(async_load, "result");
		__Results  =base64_decode(__Results);
		var SessionToken="";
		
		//note have to call the ResultMap twice for it to work, because GM2
		var ResultMap = json_decode(__Results);
		
		if ResultMap > -1 {
			if ds_map_find_value(ResultMap, "Type")==2 {
				PlayerID = ds_map_find_value(ResultMap, "PlayerID");
				SessionToken = ds_map_find_value(ResultMap, "SessionToken");
				APPServerID = ds_map_find_value(ResultMap, "APPServerID");	
				RoomID = ds_map_find_value(ResultMap, "RoomID");
				PrivateKey = ds_map_find_value(ResultMap, "PrivateKey");	
			}
			var ResultMap = json_decode(__Results);
			if ds_map_find_value(ResultMap, "Type")==2 {
				PlayerID = ds_map_find_value(ResultMap, "PlayerID");
				SessionToken = ds_map_find_value(ResultMap, "SessionToken");
				APPServerID = ds_map_find_value(ResultMap, "APPServerID");	
				RoomID = ds_map_find_value(ResultMap, "RoomID");
				PrivateKey = ds_map_find_value(ResultMap, "PrivateKey");
				//set auth after API return
				if SessionToken<>"" then __SendAuth(SessionToken);
			}
			
			
			var ResultMap = json_decode(__Results);
			if ds_map_find_value(ResultMap, "Type")==3 {
				RoomID = ds_map_find_value(ResultMap, "RoomID");
				PrivateKey = ds_map_find_value(ResultMap, "PrivateKey");	
			}
			var ResultMap = json_decode(__Results);
			if ds_map_find_value(ResultMap, "Type")==3 {
				RoomID = ds_map_find_value(ResultMap, "RoomID");
				PrivateKey = ds_map_find_value(ResultMap, "PrivateKey");	
			}

			
			var ResultMap = json_decode(__Results);
			if ds_map_find_value(ResultMap, "Type")==7 {
				LobbyPlayers = __Explode("|",ds_map_find_value(ResultMap, "LobbyPlayers"));
				LobbyPlayersInfo = __Explode("|",ds_map_find_value(ResultMap, "LobbyPlayersInfo"));
			}
			var ResultMap = json_decode(__Results);
			if ds_map_find_value(ResultMap, "Type")==7 {
				LobbyPlayers = __Explode("|",base64_decode(ds_map_find_value(ResultMap, "LobbyPlayers")));
				LobbyPlayersInfo = __Explode("|",base64_decode(ds_map_find_value(ResultMap, "LobbyPlayersInfo")));	
				
				for (var i=0;i<array_length_1d(LobbyPlayers);i++) {
					LobbyPlayersInfo[i]=base64_decode(base64_decode(LobbyPlayersInfo[i]));
					__DebugMessage(LobbyPlayers[i]);
					__DebugMessage(LobbyPlayersInfo[i]);
				}	
			}	
		}
	}
}	

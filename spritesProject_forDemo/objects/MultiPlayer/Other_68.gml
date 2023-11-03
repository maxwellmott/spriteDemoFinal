///////////////////////////////////////////////////////////////////////////
//DO NOT MODIFY ANYTHING IN THIS OBJECT
///////////////////////////////////////////////////////////////////////////
switch (ds_map_find_value(async_load, "type"))
{
	case network_type_data:
	buffer = ds_map_find_value(async_load,"buffer");
	buffer_seek(buffer,buffer_seek_start,0);
	
	var Inload = buffer_read(buffer, buffer_string);
	
	var ResultMap = json_decode(Inload);
	
	if  ds_map_find_value(ResultMap, "CallType")==1 {
		var ReturnedPlayerID = ds_map_find_value(ResultMap, "PlayerID");
		
		//loop through array of current players, update the one that matches
		var IsInArray=0;
		for (var i=0;i<array_length_1d(CurrentPlayerIDs);i++) {
			if ReturnedPlayerID == CurrentPlayerIDs[i] {
				CurrentPlayerIDs[i] = ds_map_find_value(ResultMap, "PlayerID");
				CurrentPlayerXs[i] = ds_map_find_value(ResultMap, "x");
				CurrentPlayerYs[i] = ds_map_find_value(ResultMap, "y");
				__LastMicro = ds_map_find_value(ResultMap, "Sequence");
				IsInArray=1;
			}
		} 
		
		//if no match add it to the list
		if IsInArray==0 {				
			
			array_push(CurrentPlayerIDs, ds_map_find_value(ResultMap, "PlayerID"));
			array_push(CurrentPlayerXs, ds_map_find_value(ResultMap, "x"));
			array_push(CurrentPlayerYs, ds_map_find_value(ResultMap, "y"));
			
			PlayerJoinedRoom(ds_map_find_value(ResultMap, "PlayerID"),ds_map_find_value(ResultMap, "x"),ds_map_find_value(ResultMap, "y"));		
		}		
	}
	
	
	//fire callback if a callbackid was provided in the user message	
	if  ds_map_find_value(ResultMap, "CallType")==3 {
		
		var StructData=json_decode(base64_decode(ds_map_find_value(ResultMap, "StructData")));
		
		if  ds_map_find_value(StructData, "CallBackID")==100 {
			CallBack100(StructData);
		}
		if  ds_map_find_value(StructData, "CallBackID")==101 {
			CallBack101(StructData);
		}
		if  ds_map_find_value(StructData, "CallBackID")==102 {
			CallBack102(StructData);
		}
		if  ds_map_find_value(StructData, "CallBackID")==103 {
			CallBack103(StructData);
		}
		if  ds_map_find_value(StructData, "CallBackID")==104 {
			CallBack104(StructData);
		}				
	}	
	
	
	if  ds_map_find_value(ResultMap, "CallType")==4 {
		if (TalkToPlayers){
			__LastAudioQTime = get_timer();	
			var IncomingStr = ds_map_find_value(ResultMap, "AudioData");
			var Localstr = "";
			for (var j = 1; j < 15; j += 1)
			{
				var strChar = string_char_at(IncomingStr, j);
				Localstr += strChar;
			}
			var audioIdx = "";
			while string_char_at(IncomingStr, 1) != ","
			{
				var strChar = string_char_at(IncomingStr, 1);
				audioIdx += strChar;
				IncomingStr = string_delete(IncomingStr, 1, 1);
			}
			//__DebugMessage("New Packet ="+ string(audioIdx) + ", " + Localstr + ", " +  + "-- " +
			//			string(ds_list_size(__AudioQList)) +"/"+
			//			string(ds_list_size(__TempAudioQList)));
		
			ds_list_add(__TempAudioQList, ds_map_find_value(ResultMap, "AudioData"));
			if (ds_list_size(__TempAudioQList) > __AudioQListCount){
				while (ds_list_size(__TempAudioQList) > 0) {
					if (TalkToPlayers && false)
						ds_list_add(__AudioQList, ds_list_find_value(__TempAudioQList, 0));
					ds_list_delete(__TempAudioQList, 0);
				}
			}
		}
	}
	
	
	if  ds_map_find_value(ResultMap, "CallType")==5 {
		//initiated from server broadcasting that a player left the room
		PlayerLeftRoom(ds_map_find_value(ResultMap, "PlayerID"));
		
	}	
	
	
	// IF THIS IS NOT IN HERE THEN THERE IS A MEMORY LEAK. I THINK YOU TOOK IT OUT BEFORE BECAUSE IT WAS CAUSING SOME PROBLEM.
	ds_map_destroy(ResultMap);
}	

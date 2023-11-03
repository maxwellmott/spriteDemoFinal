///////////////////////////////////////////////////////////////////////////
//DO NOT MODIFY ANYTHING IN THIS OBJECT
///////////////////////////////////////////////////////////////////////////


if (keyboard_check(vk_up))
{
	__MuteThreshold += 1;
}
else if (keyboard_check(vk_down))
{
	__MuteThreshold -= 1;
}	

//PLAYERCHAT ----------------------------------------------------

if TalkToPlayers == true
{
	if !__IsRecordingPlayer
	{
		__EnablePlayerSoundF99(true);
	}
}
else
{
	if __IsRecordingPlayer
	{
		__EnablePlayerSoundF99(false);
	}
}


// IN CASE NOTHING HAS COME THROUGH FOR 200 MILISECONDS CLEAR THE QUE
if (ds_list_size(__TempAudioQList) > 0){
	//__PlayingAudioQueue = false;
	
	while (ds_list_size(__TempAudioQList) > 0) {
		if (TalkToPlayers)
			ds_list_add(__AudioQList, ds_list_find_value(__TempAudioQList, 0));
		ds_list_delete(__TempAudioQList, 0);
		//__DebugMessage("ds_list_delete(__TempAudioQList, 0) CT = "+ string(__AudioIdxCnt) + ", -- " +
		//string(ds_list_size(__AudioQList)) +"/"+
		//string(ds_list_size(__TempAudioQList)));
		
	}
	//__DebugMessage("ds_list_add (Q Clear) = " + string(get_timer() - __LastAudioQTime) + "-- " +
	//string(ds_list_size(__AudioQList)) +"/"+
	//string(ds_list_size(__TempAudioQList)));
}

// PROCESS INCOMING CHAT AUDIO
if (!__PlayingAudioQueue && ds_list_size(__AudioQList) > 0){
	//__DebugMessage("Firing from Step (" + string(get_timer()/1000/1000) + ")-- " +
	//string(ds_list_size(__AudioQList)) +"/"+
	//string(ds_list_size(__TempAudioQList)));
	__PlayTheAudioChatQue();
}

///////////////////////////////////////////////////////////////////////////
//DO NOT MODIFY ANYTHING IN THIS OBJECT
///////////////////////////////////////////////////////////////////////////
//NOTE: If you do not want to use our server you can point the connection to your server or another client
//However, we offer no support for this and you woul dhave to write a socket server to manage the connections
//if any code below is modified the system
//warrenty is void and support is void.
//That said, if you want to use the code in this object as a learnign tool, go crazy
///////////////////////////////////////////////////////////////////////////


/*initialize the arrays, would not normally do this
	but GM2 seems picky about touching an array position for the first time
	if you need more than 10 players at the same time, good luck
	the real-time will start to lag due to local network limitations
	however, if you only need 'near' real-time (say a card game) then
	there is no realistic upper bound..
*/
randomize();

for(var i = 0; i < 10; ++i) {
	CurrentPlayerIDs[i] = 0;
	CurrentPlayerXs[i] = 0;
	CurrentPlayerYs[i] = 0;
}

PlayerID=0;
RoomID=0;
PrivateKey=0;
InLobby = false;
LobbyPlayers = [];
LobbyPlayersInfo = [];

__WhoAmI=irandom(99999999);

__OLDType1Outload="";
__OLDType3Outload="";
__OLDType4Outload="";

__GetHTTP="none";	
__Results="none";

__LastMicro=0;

__OutQueue = ds_list_create();


//register session and get session token	
__CallAPI = "https://api.f99.dev/api/token.php?k="+MasterKey+"=&t=1&w=" + string(__WhoAmI);
__GetHTTP = http_get(__CallAPI);


//make initial connection
__ClientSocket = network_create_socket(network_socket_ws);
network_connect_raw(__ClientSocket , "api.f99.dev", 8080);
__ClientBuffer = buffer_create(50000,buffer_fixed,1);


SetLobby = function(LobbyStatus){	
	__CallAPI = "https://api.f99.dev/api/token.php?k="+MasterKey+"=&t=5&f=0&w=1&p=" + string(PlayerID);
	if LobbyStatus == true then __CallAPI = "https://api.f99.dev/api/token.php?k="+MasterKey+"=&t=5&f=1&w=1&p=" + string(PlayerID);
	
	__GetHTTP = http_get(__CallAPI);
	
	InLobby = LobbyStatus;
}


SetDetails = function(Details){
	Details=base64_encode(Details);
	__CallAPI = "https://api.f99.dev/api/token.php?k="+MasterKey+"=&t=6&f=0&w=1&p=" + string(PlayerID);
	__CallAPI += "&myinfo="+Details;
	
	__GetHTTP = http_get(__CallAPI);
}


__Send = function(){	
	var LocalSend = "";
	while (ds_list_size(__OutQueue)>0) {
		//__DebugMessage(string(__OutQueue));
		LocalSend = "||||"+ds_list_find_value(__OutQueue,0)+"||||";
		ds_list_delete(__OutQueue, 0);	//pull from the top and delete
		buffer_seek(__ClientBuffer,buffer_seek_start,0);
		
		buffer_write(__ClientBuffer,buffer_string,LocalSend);
		network_send_packet(__ClientSocket,__ClientBuffer,buffer_get_size(__ClientBuffer));
	}	
}


SetHeroXY = function(F99PlayerID,F99PlayerX,F99PlayerY){
	//don't send if not in a room
	if RoomID>0 {
		var Outload = "{ 'CallType':'1', 'PlayerID':'"+string(round(F99PlayerID))+"', 'x':'"+string(round(F99PlayerX))+"', 'y':'"+string(round(F99PlayerY))+"', 'Sequence':'|UnixTime|', 'RoomID':'"+string(RoomID)+"' }";
		
		//only send if it is new information
		if __OLDType1Outload<>Outload {
			ds_list_add(__OutQueue, Outload);
			__Send();
			__OLDType1Outload=Outload;
		}
	}	
}


SetStruct = function (F99Struct) {
	var F99OutloadSendKey;
	F99Struct=base64_encode(F99Struct);
	
	F99OutloadSendKey = "{ 'CallType':'3', 'StructData':'"+F99Struct+"', 'Sequence':'|UnixTime|', 'RoomID':'"+string(RoomID)+"', 'PlayerID':'"+string(PlayerID)+"' }";
	
	if __OLDType3Outload<>F99Struct {
		ds_list_add(__OutQueue, F99OutloadSendKey);
		__Send();
		__OLDType3Outload=F99Struct;
	}		
}


__SendAuth = function (F99Struct) {
	var F99OutloadSendKey;
	F99Struct=base64_encode(F99Struct);
	
	F99OutloadSendKey = "{ 'CallType':'2', 'StructData':'"+F99Struct+"', 'Sequence':'|UnixTime|', 'RoomID':'"+string(RoomID)+"', 'PlayerID':'"+string(PlayerID)+"' }";	
	
	ds_list_add(__OutQueue, F99OutloadSendKey);
	__Send();
}	


SetNewRoom = function () {
	//call to add the othe rplayer to your room
	__CallAPI = "https://api.f99.dev/api/token.php?k="+MasterKey+"=&t=2&w=" + string(__WhoAmI);
	__GetHTTP = http_get(__CallAPI);	
}


ChangeRoom = function (NewRoom) {
	
	var __CallAPI = "https://api.f99.dev/api/token.php?k="+MasterKey+"=&t=3&w=" + string(__WhoAmI);
	__CallAPI += "&p="+NewRoom;
	__GetHTTP = http_get(__CallAPI);	
}	


GetLobby = function () {
	__CallAPI = "https://api.f99.dev/api/token.php?k="+MasterKey+"=&t=7&f=0&w=1&p=" + string(PlayerID);
	__DebugMessage(__CallAPI);
	__GetHTTP = http_get(__CallAPI);		
}


// PLAYER CHAT ---------------------------------------

__IsRecordingPlayer = false;
__RecordingSampleRate = 16000;
__RecordingAudioBuffer = undefined;
__AudioBufferAppend = undefined;
__OutGoingAudioQList = ds_list_create();
__ChannelIndex = undefined;
__AudioRecorder = 0;
__AudioBufferTemp = undefined;
__AudioQueue = undefined;
__AudioQList = ds_list_create();
__TempAudioQList = ds_list_create();
__AudioIdxCnt = 0;
__LastData = undefined;
__MicrophoneVolume = 0;
__AudioQListCount = 8;
__LastAudioQTime = 0;
__SendBlockCount = 0;
__LastRecordingBlockTime = 0;
__TextFile = undefined;
__MuteThreshold = 80;
__LastMicAboveTheshold = 0;
__LastRecordingSend = 0;
__PlayingAudioQueue = false;
__LocalAudioBufferTemp = undefined;

// MAR FOR DEBUGGING REMOVE LATER
/*
__MyTestCount = 0;
__MyTestBuff = buffer_create(500000000, buffer_fixed, 1);
*/
// MAR END

__EnablePlayerSoundF99 = function(Enable) {
	__PlayingAudioQueue = false;

	if file_exists("f99diag.txt")
	{
		file_delete("f99diag.txt");
	}
	var RecordingDeviceCount = audio_get_recorder_count();
	if RecordingDeviceCount > 0 && Enable
	{
		__DebugMessage("buffer_create CREATE");

		if (RecordingDeviceCount > 1)
			__AudioRecorder = 1;
		var mymap = audio_get_recorder_info(__AudioRecorder);            
		__RecordingSampleRate = mymap[? "sample_rate"];
		__ChannelIndex = audio_start_recording(__AudioRecorder);
		//if __RecordingAudioBuffer == undefined
		//__RecordingAudioBuffer = buffer_create(20000, buffer_fixed, 1);
		if __AudioBufferAppend == undefined
		__AudioBufferAppend = buffer_create(5000000, buffer_fixed, 1);
		
		if __AudioBufferTemp == undefined
			__AudioBufferTemp = buffer_create(50000, buffer_fixed, 1);
		
		if __AudioQueue == undefined
			__AudioQueue = audio_create_play_queue(buffer_s16, __RecordingSampleRate, audio_mono);
		
		__IsRecordingPlayer = true;
		TalkToPlayers = true;
	}	
	else 
	{
		audio_stop_recording(__AudioRecorder);
		__IsRecordingPlayer = false;
		TalkToPlayers = false;
	}
	return;
	// FOR DEVELOPMENT
	/*
		file = file_bin_open("data_buffer_in.bin",0);
		size = file_bin_size(file);
		__DebugMessage("size = "+ string(size));
		
		sound_buffer = buffer_create(5000000, buffer_grow, 1);
		for(var i=0;i<size;i++;){
		buffer_write(sound_buffer, buffer_u8, file_bin_read_byte(file));
		}
		file_bin_close(file);
		sound_buffer = buffer_load("data_buffer_in.bin");
		audio_queue1 = audio_create_play_queue(buffer_s16, __RecordingSampleRate, audio_mono);
		audio_queue_sound(audio_queue1, sound_buffer, 0, buffer_get_size(sound_buffer));
		var snd = audio_play_sound(audio_queue1, 10, 0);
		audio_sound_gain(snd, 1, 1);
		*/
	
}


__SendSoundBuffer = function (AudioBufIn) {
	var OutSendKey;
	
	// MAR TESTING
	/*
	var audioIdx = "";
	var TempAudioBufIn = AudioBufIn;
	while string_char_at(TempAudioBufIn, 1) != ","
	{
		var strChar = string_char_at(TempAudioBufIn, 1);
		audioIdx += strChar;
		TempAudioBufIn = string_delete(TempAudioBufIn, 1, 1);
	}
	TempAudioBufIn = string_delete(TempAudioBufIn, 1, 1); // GET RID OF THE COMMA
	var cmpBuff = buffer_base64_decode(TempAudioBufIn);
	var buffDecomp = buffer_decompress(cmpBuff);
		
	buffer_copy(buffDecomp, 0, buffer_get_size(buffDecomp), __MyTestBuff, __MyTestCount);
	__DebugMessage("mysize="+string(__MyTestCount));
	buffer_save(__MyTestBuff, "data_buffer_in.bin");
	__MyTestCount += buffer_get_size(buffDecomp);
	*/
	// MAR TESTING END
	
	OutSendKey = "{ 'CallType':'4', 'AudioData':'"+AudioBufIn+"', 'Sequence':'|UnixTime|', 'RoomID':'"+string(RoomID)+"', 'PlayerID':'"+string(PlayerID)+"' }";
	//__DebugMessage("OutSendKey = "+ string(OutSendKey));
	if __OLDType4Outload<>AudioBufIn {
		ds_list_add(__OutQueue, OutSendKey);
		__Send();
		__OLDType4Outload=AudioBufIn;
	}	
	
}


__PlayTheAudioChatQue = function () {
	if (__PlayingAudioQueue || !TalkToPlayers) return;
	__PlayingAudioQueue = true;
	
	var BufferPosTotal = 0;
	while ds_list_size(__AudioQList) > 0 {
		var AudioRec = ds_list_find_value(__AudioQList, 0);
		if (AudioRec == ""){
			ds_list_delete(__AudioQList, 0);
			continue;
		}
		
		var audioIdx = "";
		while string_char_at(AudioRec, 1) != ","
		{
			var strChar = string_char_at(AudioRec, 1);
			audioIdx += strChar;
			AudioRec = string_delete(AudioRec, 1, 1);
		}
		AudioRec = string_delete(AudioRec, 1, 1); // GET RID OF THE COMMA
		
		ds_list_delete(__AudioQList, 0);	//pull from the top and delete
		if (AudioRec == "") continue;
		var cmpBuff = buffer_base64_decode(AudioRec);
		if (cmpBuff == -1) continue;
		var buffDecomp = buffer_decompress(cmpBuff);
		buffer_delete(cmpBuff);
		if (buffDecomp == -1) continue;
		var len = buffer_get_size(buffDecomp);
		if len >= 1 {
			buffer_copy(buffDecomp, 0, len, __AudioBufferTemp, BufferPosTotal);
			buffer_delete(buffDecomp);
			
			BufferPosTotal += len;
			
			var Localstr = "";
			for (var j = 1; j < 15; j += 1)
			{
				var strChar = string_char_at(AudioRec, j);
				Localstr += strChar;
			}
		}		
	}
	
	if (BufferPosTotal != 0){
		if (__LocalAudioBufferTemp != undefined){
			buffer_delete(__LocalAudioBufferTemp);
		}
		__LocalAudioBufferTemp = buffer_create(BufferPosTotal, buffer_fixed, 1);
			//__DebugMessage("buffer_create __LocalAudioBufferTemp");
		buffer_copy(__AudioBufferTemp, 0, BufferPosTotal, __LocalAudioBufferTemp, 0);
		
		//__DebugMessage("play - ("+string(audioIdx)+") ="+string(BufferPosTotal) + ", " + Localstr);
		//__DebugMessage("      LIST - ("+string(audioIdx)+") =" + ", " + Localstr);
		audio_queue_sound(__AudioQueue, __LocalAudioBufferTemp, 0, 0);
		audio_play_sound(__AudioQueue, 10, 0);
	}
}


__DebugMessage = function (LocalStr) {
	show_debug_message(string(floor(get_timer()/1000)) + " - " + LocalStr);	
}


__WriteDiag = function(Mystr){
	return;
	__TextFile = file_text_open_append(working_directory + "f99diag.txt");
	file_text_write_string(__TextFile, Mystr);
	file_text_writeln(__TextFile);
	file_text_close(__TextFile);
}


__Explode = function (del,str) {
	// explode(delimiter,string)
	//
	//  Returns an array of strings parsed from a given 
	//  string of elements separated by a delimiter.
	//
	//      delimiter   delimiter character, string
	//      string      group of elements, string
	//
	/// GMLscripts.com/license
	{
		var arr;
		str = str + del;
		var len = string_length(del);
		var ind = 0;
		repeat (string_count(del, str)) {
			var pos = string_pos(del, str) - 1;
			arr[ind] = string_copy(str, 1, pos);
			str = string_delete(str, 1, pos + len);
			ind++;
		}
		return arr;
	}	
}	
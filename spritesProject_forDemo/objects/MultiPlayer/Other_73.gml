///////////////////////////////////////////////////////////////////////////
//DO NOT MODIFY ANYTHING IN THIS OBJECT
///////////////////////////////////////////////////////////////////////////

var Channel = async_load[? "channel_index"];

if __IsRecordingPlayer && Channel == __ChannelIndex
{
	//__DebugMessage("Block Time Length="+string(get_timer() - __LastRecordingBlockTime));
	//if (AudioChatSensitivity == 2)
	//	__MuteThreshold = 60;
	//else
	//	__MuteThreshold = 200;
	
	var len = async_load[? "data_len"];
	__SendBlockCount += 1;
	if (len >= 1) {
		
		if (__RecordingAudioBuffer != undefined){
			buffer_delete(__RecordingAudioBuffer);
			//__DebugMessage("buffer_delete xxx __RecordingAudioBuffer");
		}
		__RecordingAudioBuffer = buffer_create(len, buffer_fixed, 1);
		//__DebugMessage("buffer_create __RecordingAudioBuffer");

		buffer_copy(async_load[? "buffer_id"], 0, len, __RecordingAudioBuffer, 0);
		
		buffer_seek(__RecordingAudioBuffer, buffer_seek_start, 0);
		var SoundOffset = 0.003;
		var MaxMic = 0;
		var NumCleared = 0;
		var ThresholdExceededCount = 0;
		for (var j = 0; j < len/16; j++) {
		    var SoundItem = buffer_read(__RecordingAudioBuffer, buffer_s16);
		    SoundItem = abs(SoundItem);

		    if (__LastData == undefined) __LastData = SoundItem;
		    SoundItem = (1.0 - SoundOffset) * __LastData + SoundOffset * SoundItem;
		    __LastData = SoundItem;
    
		    __MicrophoneVolume = SoundItem;
			if (__MicrophoneVolume > MaxMic){
				MaxMic = __MicrophoneVolume;
				ThresholdExceededCount += 1;
			}
				
			if (__MicrophoneVolume < 1){
				NumCleared += 1;
				buffer_poke(__RecordingAudioBuffer, j*16, buffer_s16, 0);
			}
    
		}
		buffer_seek(__RecordingAudioBuffer, buffer_seek_start, 0);
		
		
		if (MaxMic > __MuteThreshold && ThresholdExceededCount > 100)
			__LastMicAboveTheshold = get_timer();
		var BufferQ = undefined;
		var BuffPos = 0;
		// LEAVE MIC OPEN FOR 2 SECONDS TO AVOID CLIPPING			if (ds_list_size(__OutGoingAudioQList) <= 3) cont;

		var TimeSinceAbove = get_timer() - __LastMicAboveTheshold;
		var TimeSinceLastRecordingSend = get_timer() - __LastRecordingSend;
		var ListLen = ds_list_size(__OutGoingAudioQList);
		if (((MaxMic > __MuteThreshold && ThresholdExceededCount > 100) || TimeSinceAbove < 2000000) &&
			(ds_list_size(__OutGoingAudioQList) >= 0 || TimeSinceLastRecordingSend > 1000000)) {
			if (ds_list_size(__OutGoingAudioQList) > 0 && false)
				__DebugMessage("PLAYING ("+string(ds_list_size(__OutGoingAudioQList))+") chunks, ListLen="+string(ListLen)+", MaxMic="+ string(MaxMic)+"/"+ string(ThresholdExceededCount)+
							   ", TimeSinceAbove="+ string(TimeSinceAbove)+", TimeSinceLastRecordingSend="+ string(TimeSinceLastRecordingSend)+
							   ", __SendBlockCount="+ string(__SendBlockCount));
			var b_str = buffer_base64_encode(__RecordingAudioBuffer, 0, len);
			ds_list_add(__OutGoingAudioQList, b_str);
			var SegmentCount = 0; // MAR TEST
			while (ds_list_size(__OutGoingAudioQList) > 0) {
				var str1 = ds_list_find_value(__OutGoingAudioQList, 0);
				var cmpBuffDecode = buffer_base64_decode(str1);
				if (BufferQ == undefined){
					BufferQ = buffer_create(buffer_get_size(cmpBuffDecode)+10000000, buffer_fixed, 1);
					//__DebugMessage("buffer_create BufferQ");
					buffer_copy(cmpBuffDecode, 0, buffer_get_size(cmpBuffDecode), BufferQ, 0);
					BuffPos = buffer_get_size(cmpBuffDecode);
				}
				else {
					buffer_copy(cmpBuffDecode, 0, buffer_get_size(cmpBuffDecode), BufferQ, BuffPos);
					BuffPos += buffer_get_size(cmpBuffDecode);
				}
				SegmentCount += 1; // MAR TEST
				ds_list_delete(__OutGoingAudioQList, 0);
				buffer_delete(cmpBuffDecode);
			}

			//BuffPos += buffer_get_size(__RecordingAudioBuffer);
			
			//__DebugMessage("PREVIOUS maxm="+string(MaxMic));
			var cmpBuff = buffer_compress(BufferQ, 0, BuffPos);
			
			var DataOut = string(__SendBlockCount) + "," + buffer_base64_encode(cmpBuff, 0, buffer_get_size(cmpBuff));
			buffer_delete(cmpBuff);
			//__DebugMessage("OutSendKey = "+ string_copy(DataOut,0,8)+", SegmentCount="+ string(SegmentCount));
			__SendSoundBuffer(DataOut);
			__LastRecordingSend = get_timer();
			
			//var recbufflen = string_length(buffer_base64_encode(BufferQ, 0, buffer_get_size(BufferQ)));
			//var cmpBufflen = string_length(buffer_base64_encode(cmpBuff, 0, buffer_get_size(cmpBuff)));
			//__DebugMessage("maxm="+string(MaxMic)+", buf/comp="+string(recbufflen)+"/"+string(cmpBufflen)+"/"+string(cmpBufflen/recbufflen) + "NumCleared="+string(NumCleared));
			if (BufferQ != undefined){
				buffer_delete(BufferQ);
				BufferQ = undefined;
			}
		}
		else {
			//__DebugMessage("SKIPPING ("+string(ds_list_size(__OutGoingAudioQList))+") chunks, ListLen="+string(ListLen)+", MaxMic="+ string(MaxMic)+
			//				", TimeSinceAbove="+ string(TimeSinceAbove)+", TimeSinceLastRecordingSend="+ string(TimeSinceLastRecordingSend)+
			//				", __SendBlockCount="+ string(__SendBlockCount));
			//__DebugMessage("Skipping="+string(MaxMic)+"/"+string(NumCleared));
			var b_str = buffer_base64_encode(__RecordingAudioBuffer, 0, len);
			while (ds_list_size(__OutGoingAudioQList) > 3) {
				//__DebugMessage("REMOVING");
				ds_list_delete(__OutGoingAudioQList, 0);
			}
			ds_list_add(__OutGoingAudioQList, b_str);
		}
	}
	else {
		__WriteDiag("Not Sent Length=0: "+string(__SendBlockCount));
	}
	__LastRecordingBlockTime = get_timer();

}

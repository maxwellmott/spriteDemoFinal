///////////////////////////////////////////////////////////////////////////
//DO NOT MODIFY ANYTHING IN THIS OBJECT
///////////////////////////////////////////////////////////////////////////

var Queue = async_load[? "queue_id"];

//while (ds_list_size(__AudioQList)>0) {
//}
if Queue = __AudioQueue
{
	__PlayingAudioQueue = false;
	buffer_fill(__AudioBufferTemp, 0, buffer_u16, 0, 50000);
	buffer_delete(__LocalAudioBufferTemp);
	__LocalAudioBufferTemp = undefined;
	//__DebugMessage("DonePlaying");
}



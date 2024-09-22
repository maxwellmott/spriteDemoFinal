// this is a ds list that is used to keep track of any
// sfx that have been pushed to eventually start playing
global.sfxQueue = ds_list_create();

// this is a ds list that is used to keep track of any
// emitters that have been pushed to eventually start playing.
// Each emitter on the queue will be stored as an encoded list
// of parameters that will be gotten by the audioManager and then
// used to create a new emitter.
global.emitterQueue = ds_list_create();

// this is an enumerator containing all parameters of emitters
// that will be stored on the emitterQueue
enum EMITTER_PARAMS {
	SENDER_ID,
	X,
	Y,
	SONG_ID,
	HEIGHT
}

//@TODO FINISH ALL OF THESE FUNCTIONS
function audio_push_emitter() {
	var senderID = id;
	var _x = x;
	var _y = y;
	var songID = wps_test;
	
	
}

function audio_push_sfx() {

}
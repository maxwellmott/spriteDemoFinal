#macro	AUDIO_SAMPLE_RATE		44100
#macro	CENTRAL_TONE			440
#macro	BITS_PER_SAMPLE			16

// this is an enum that stores all phases of an ADSR
// filter. This is used by the wavephoneController to
// navigate through different phases and gliding towards
// target values
enum FILTER_PHASES {
	ATTACK,
	DECAY,
	SUSTAIN,
	RELEASE,
	HEIGHT	
}

///@desc This function populates the lists containing all of the
/// bbox dimensions for each playable key.
function wavephone_build_note_boxes() {
	var i = 0;	repeat (pitchRange) {
		// initialize all bbox values
		var left	= -1;
		var right	= -1;
		var top		= -1;
		var bottom	= -1;
		
		// check if this is an accidental key
		if (ds_list_find_index(accidentals, i) != -1) {
			top = keyTopRowY - 	5;
			bottom = keyTopRowY + 4;
		}
		// if this is not an accidental key
		else {
			top = keyBottomRowY - 5;
			bottom = keyBottomRowY + 4;
		}
		
		// set left
		switch (i) {
			case 0:
				left = 3;
			break;
			
			case 1:
				left = 7;
			break;
			
			case 2:
				left = 11;
			break;
			
			case 3:
				left = 15;
			break;
			
			case 4:
				left = 23;
			break;
			
			case 5:
				left = 27;
			break;
			
			case 6:
				left = 31;
			break;
			
			case 7:
				left = 35;
			break;
			
			case 8:
				left = 39;
			break;
			
			case 9:
				left = 47;
			break;
			
			case 10:
				left = 51;
			break;
			
			case 11:
				left = 55;
			break;
			
			case 12:
				left = 59;
			break;
			
			case 13:
				left = 63;
			break;
			
			case 14:
				left = 67;
			break;
			
			case 15:
				left = 71;
			break;
			
			case 16:
				left = 79;
			break;
			
			case 17:
				left = 83;
			break;
			
			case 18:
				left = 87;
			break;
			
			case 19:
				left = 91;
			break;
			
			case 20:
				left = 95;
			break;
			
			case 21:
				left = 103;
			break;
			
			case 22:
				left = 107;
			break;
			
			case 23:
				left = 111;
			break;
			
			case 24:
				left = 115;
			break;
			
			case 25:
				left = 119;
			break;
			
			case 26:
				left = 123;
			break;
		}
		
		// correct left
		left = (left - 3) + 66;
		
		// get right from left
		right = left + 5;
		
		// add all dimensions to dimension lists
		leftList[| i]	= left;
		rightList[| i]	= right;
		topList[| i]	= top;
		bottomList[| i] = bottom;
		
		// increment i
		i++;
	}
}

///@desc This function checks for any collisions between the mouse
/// and any of the keys. It then sets noteNum depending on which key
/// was last touched by the mouse
function wavephone_set_notenum() {
	var i = 0;	repeat (pitchRange) {
		// get all bbox dimensions
		var left	= leftList[| i];
		var right	= rightList[| i];
		var top		= topList[| i];
		var bottom	= bottomList[| i];
	
		if (collision_rectangle(left, top, right, bottom, mouse, true, false)) {
			noteNum = i;
			break;
		}
		
		i++;
	}
}

///@desc This function draws all of the keys while making sure to draw
/// the correct sprite and frame for each.
function wavephone_draw_keys() {
	var i = 0;	repeat (pitchRange) {
		// initialize frame and sprite
		var frame	= 0;
		var spr		= -1;
		
		// check if this note is being played
		if (noteNum == i) {
			// set frame to 1
			frame = 1;	
		}
		
		// check if this is an accidental
		if (ds_list_find_index(accidentals, i) != -1) {
			// set sprite to accidental key
			spr = spr_accidentalKey;
		}
		// if this is a natural note
		else {
			// set sprite to natural key	
			spr = spr_naturalKey;
		}
		
		// get left and top
		var left	= leftList[| i];
		var top		= topList[| i];
		
		// draw this key
		draw_sprite(spr, frame, left, top);
		
		// increment i
		i++;
	}
}

///@desc This function takes a number that represents one of 26
/// with A 440 at the center. It returns the hertz value of the frequency
/// of that tone
function wavephone_get_note_frequency(_noteNum) {
	// store args in locals
	var n = _noteNum;
	
	// ensure that n doesn't go below 0
	if (n < 0)	n = 0;
	
	// use a switch statement to return the proper frequency
	switch (n) {
		case 0:
			return 207.65;
		break;
		
		case 1:
			return 220;
		break;
		
		case 2:
			return 233.08;
		break;
		
		case 3:
			return 246.94;
		break;
		
		case 4:
			return 261.63;
		break;
		
		case 5:
			return 277.18;
		break;
		
		case 6:
			return 293.66;
		break;
		
		case 7:
			return 311.13;
		break;
		
		case 8:
			return 329.63;
		break;
		
		case 9:
			return 349.23;
		break;
		
		case 10:
			return 369.99;
		break;
		
		case 11:
			return 392;
		break;
		
		case 12:
			return 415.3;
		break;
		
		case 13:
			return 440;
		break;
		
		case 14:
			return 466.16;
		break;
		
		case 15:
			return 493.88;
		break;
		
		case 16:
			return 523.25;
		break;
		
		case 17:
			return 554.37;
		break;
		
		case 18:
			return 587.33;
		break;
		
		case 19:
			return 622.25;
		break;
		
		case 20:
			return 659.25;
		break;
		
		case 21:
			return 698.46;
		break;
		
		case 22:
			return 739.99;
		break;
		
		case 23:
			return 783.99;
		break;
		
		case 24:
			return 830.61;
		break;
		
		case 25:
			return 880;
		break;
		
		case 26:
			return 932.33;
		break;
	}
}

// initialize accidentals list
global.accidentalsList = ds_list_create();

// build accidentals list
ds_list_add(global.accidentalsList,	0,
									2,
									5,
									7,
									10,
									12,
									14,
									17,
									19,
									22,
									24,
									26);
									
// encode accidentals list
global.allAccidentals = encode_list(global.accidentalsList);

// destroy accidentals list
ds_list_destroy(global.accidentalsList);

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
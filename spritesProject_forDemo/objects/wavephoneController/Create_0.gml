create_once(guiWidth / 2, guiHeight / 2, LAYER.mouse, mouse);

outroStarted = false;
introFinished = false;

// check if x isn't too close to the right side
if (player.x > ((sprite_width / 2))) {
	// set x if there are no positioning problems
	x = player.x;
}
// if x is too close to the right side
else {
	x = player.x + ((sprite_width / 2));	
}

// check if y isn't too close to the bottom
if (player.y < (room_height - sprite_height / 2) - 4) {
	// set y if there are no positioning problems
	y = round(player.y + (sprite_height / 2) + 8);
}
// if y is too close to the bottom
else {
	y = round(player.y - (sprite_height / 2) - 8);	
}

pausedAudio = audioManager.currentBGM;

audio = -1;
sound = -1;

pitchVal = 0;

pitchRange = 27;

currentTone = -1;

noteNum = 13;

targetGain_attack	= 1.0;
targetGain_sustain	= 1.0;

// increment added while approaching target gain
attackRate_gain		= 0.1;
decayRate_gain		= 0.1;
releaseRate_gain	= 0.1;

gain = 0.0;

playing = false;

filterPhase = FILTER_PHASES.ATTACK;

indicatorY = y;
indicatorX = x;

trackerLineFrame = 0;
trackerLineFrameCount = 9;

// decode accidentals list
accidentals = ds_list_create();
decode_list(global.allAccidentals, accidentals);

keyTopRowY		= (y + (sprite_height / 2) + 6);
keyBottomRowY	= keyTopRowY + 12;

leftList		= ds_list_create();
rightList		= ds_list_create();
topList			= ds_list_create();
bottomList		= ds_list_create();

audioBuffer = buffer_create(AUDIO_SAMPLE_RATE, buffer_fixed, 1);

bufferLength = buffer_get_size(audioBuffer);

// initialize sampleRate and hertz
var r = AUDIO_SAMPLE_RATE;
var h = CENTRAL_TONE;

buffer_seek(audioBuffer, buffer_seek_start, 0);

// initialize number to write to, length of buffer, and value to write
var n = r / h;
var v = 1;

// initialize waveLength
var wl = 0.125;

// use a repeat loop to write every sample in the waveform to the buffer
var i = 0;	repeat ((r / n) + 1) {
	var j = 0;	repeat (n) {
		var val = (h * (v * 255)) / 2;
		
		// write the current value of the waveform to the buffer using j
		buffer_write(audioBuffer, buffer_s16, val);
		
		j++;
	}
	v = 1 - v;
	
	// increment i
	i++;
}

wavephone_build_note_boxes();
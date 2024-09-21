// ensure that audio falloff is occurring due to linear distance
audio_falloff_set_model(audio_falloff_linear_distance);

// the id of the sfx currently playing
currentSFX = -1;

// the id of the bgm currently playing
currentBGM = -1;

// the id of a bgm that's supposed to play now
newBGM = -1;

// the volume of the bgm relative to the gross and selected volumes
bgmGain = 1.0;

// the volume of the sfx relative to the gross and selected volumes
sfxGain = 1.0;

// the volume of all audio as indicated by other factors in the game
// such as room transitions
grossGain = 1.0;

// the volumes of all audio as indicated by the number selected by
// the player in the options menu
selectedGain = 8;

// I'm simply arbitrating this pointer so that you don't forget that
// you don't need to create an audio bus for effects--this is the 
// application surface of audio
bus = audio_bus_main;

// but actually you will need one for the sfx because you don't want 
// effects to be layered over those
sfxBus = audio_bus_create();

// initialize currentEmitters
currentEmitters = ds_list_create();

// for testing only
cutoffValue = 0.1;
qValue = 2;
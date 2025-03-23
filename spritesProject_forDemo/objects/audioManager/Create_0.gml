// ensure that audio falloff is occurring due to linear distance
audio_falloff_set_model(audio_falloff_linear_distance);

// the id of the sfx currently playing
currentSFX = -1;

// the id of the bgm currently playing
currentBGM = -1;

// the volume of the bgm relative to the gross and selected volumes
bgmGain = 1.0;

// the volume of the sfx relative to the gross and selected volumes
sfxGain = 1.0;

// the volumes of all audio as indicated by the number selected by
// the player in the options menu
selectedGain = 8;

// I'm simply arbitrating this pointer so that you don't forget that
// you don't need to create an audio bus for effects--this is the 
// application surface of audio
bus = audio_bus_main;

// initialize currentEmitters
currentEmitters = ds_list_create();

// initialize sfxQueue
sfxQueue = ds_list_create();
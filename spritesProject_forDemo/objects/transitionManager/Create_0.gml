/// @desc

// reset the hapNum
global.hapNum = 0;

// set bgmGain to max for audioManager
audioManager.bgmGain = 1.0;

depth = LAYER.mouse;

alpha = 0.0;

enum transitionStates {
	fadingIn,
	transitioning,
	fadingOut,
	height
}

state = transitionStates.fadingIn;

newBGM = global.newBGM;

global.roomBuilt = false;
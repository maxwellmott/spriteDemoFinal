/// @description Insert description here
// You can write your code in this editor

targetSprite.currentPose = SPRITE_POSES.IDLE;
activeSprite.currentPose = SPRITE_POSES.IDLE;

if (instance_exists(spar)) {
	spar.turnMsg = "";
	spar.turnGrid[# TURN_GRID.ACTION, turnRow] = -1;
}
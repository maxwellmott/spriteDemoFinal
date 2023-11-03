/// @desc

// set playerOne and playerTwo
playerOne = player;
playerTwo = player.enemy;

// create AI object if this is not an online battle
if (playerTwo.ID > enemies.online) {
	create_once(0, 0, LAYER.meta, enemyAI);
}

// create sprite lists

// battle phases enum

// initialize battle phase

// initialize battleReady

// initialize battleComplete

// initialize turnCounter

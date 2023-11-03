/// @desc

// inherit human create event
event_inherited();

#region initialize base params
// initialize ID
ID = noone;

// initialize name
name = "";

// initialize talismans
talismans = "";

// initialize facing
facing = directions.south;

// initialize swimming
swimming = false;

// initialize moving
moving = false;

// initialize hmove and vmove
hmove = 0;
vmove = 0;

npcListIndex = -1;

walkingSprite		= -1;
eatingSprite		= -1;
drinkingSprite		= -1;
wavephoneSprite		= -1;
meditatingSprite	= -1;
swimmingSprite		= -1;

sprite = -1;
frame = 0;
frameCount = -1;

minFrame = -1;
maxFrame = -1;

// initialize state
state = humanStates.standard;

// initialize path
pathList = -1;
pathStep = 0;

nextCoords	= "";
nextX		= x;
nextY		= y;

finalDestX	= -1;
finalDestY	= -1;

// initialize depth
human_set_depth();

#endregion

parametersLoaded	= false;
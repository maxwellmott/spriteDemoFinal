/// @desc

/// IMPORTANT NOTE ABT NPCS
/// THE DECISION TO TRANSPORT TO A NEW LOCATION SHOULD COME AS
/// AN ACTION INDICATED ON THE NPCS PATH LIST. THIS SHOULD ALWAYS
/// OCCUR WHEN THE NPC HAS REACHED THE GIVEN MEANS OF TRANSPORT (DOOR,
/// STAIRWAY, EDGE OF SCREEN, ETC)

// inherit human create event
event_inherited();

#region initialize base params
// initialize ID
ID = -1;

// initialize name
name = "";

// initialize talismans
talismans = "";

// initialize roster
roster = ds_list_create();

// initialize team
team = ds_list_create();

// initialize facing
facing = DIRECTIONS.SOUTH;

// initialize swimming
swimming = false;

// initialize moving
moving = false;

// initialize hmove and vmove
hmove = 0;
vmove = 0;

// response map
responseMap = -1;

// response function
respondFunction = -1;

// behavior function
behaviorFunction = -1;

walkingSprite		= -1;
swimmingSprite		= -1;
musicSprite			= -1;
specialAnimations	= -1

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

loopCount = 0;		// 0 indicates a single cycle, -1 indicates infinite looping
loopsCompleted = 0;

// initialize currentSong
currentSong = -1;
songLoops = 0;		// 0 indicates a single cycle, -1 indicates infinite looping
songLoopsCompleted = 0;

#endregion

// tracks all dialogue spoken by this NPC since the player has been in this room
spokenDialogue = ds_list_create();

talkingSpeed		= -1;
voice				= -1;
vocalRange			= -1;

parametersLoaded	= false;
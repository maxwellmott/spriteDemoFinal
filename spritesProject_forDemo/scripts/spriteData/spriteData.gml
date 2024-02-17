global.targetSprite = 0;
global.attackerSprite = 0;
global.spellPower = 0;
global.spellType = 0;

enum allSprites {
	sparmate,
	gembo,
	hachaChacha,
	pondile,
	bookish,
	fisticogs,
	crustular,
	exonolith,
	gastronimo,
	mirrefract,
	songbird,
	shredator,
	durendoux,
	obsidual,
	glidrake,
	stagefrite,
	pleep,
	floopwalker,
	drumline,
	arraynge,
	tickdoff,
	joe,
	scrootineyes,
	revolture,
	heatsune,
	flotsu,
	blitzkrane,
	podric,
	doormaus,
	cleansage,
	pugiloon,
	fortuga,
	capnClops,
	splashguard,
	furvor,
	mrSudsy,
	jackhammer,
	canuki,
	demolitops,
	fishmonger,
	zephira,
	uprooter,
	plasmass,
	cragma,
	wyrmpool,
	corvolt,
	chromosilos,
	cenotomb,
	nintox,
	stewardrake,
	domino,
	anachronaut,
	shpupo,
	needlepaw,
	omnost,
	prismatter,
	kronarc,
	cosmalcos,
	height
}

enum spriteParams {
	ID,
	name,
	power,
	resistance,
	fire,
	water,
	storm,
	earth,
	agility,
	luck,
	size,
	height
}

enum spriteSizes {
	xSmall,
	small,
	medium,
	large,
	xLarge,
	height
}

global.spriteGrid = ds_grid_create(spriteParams.height, allSprites.height);

function sprite_add_to_grid(_ID) {
	var i = 0; repeat (spriteParams.height) {
		ds_grid_add(global.spriteGrid, i, _ID, argument[i]);
		
		i++;
	}
}
	
#region ALL SPRITE DATA
//				ID							NAME			POWER	RES		FIRE	WATER	STORM	EARTH	AGL		LUCK	SIZE
sprite_add_to_grid(allSprites.sparmate,		"SPARMATE",		180,	110,	65,		95,		70,		100,	145,	100,	spriteSizes.medium);
sprite_add_to_grid(allSprites.fisticogs,	"FISTICOGS",	170,	145,	95,		55,		95,		125,	90,		80,		spriteSizes.medium);
sprite_add_to_grid(allSprites.crustular,	"CRUSTULAR",	185,	120,	70,		150,	70,		90,		65,		90,		spriteSizes.large);
sprite_add_to_grid(allSprites.obsidual,		"OBSIDUAL",		170,	90,		150,	60,		60,		160,	130,	50,		spriteSizes.medium);
sprite_add_to_grid(allSprites.stagefrite,	"STAGEFRITE",	80,		90,		85,		85,		85,		85,		135,	150,	spriteSizes.small);
sprite_add_to_grid(allSprites.revolture,	"REVOLTURE",	105,	140,	75,		70,		85,		80,		85,		75,		spriteSizes.medium);
sprite_add_to_grid(allSprites.pugiloon,		"PUGILOON",		145,	80,		90,		100,	115,	75,		155,	80,		spriteSizes.small);
sprite_add_to_grid(allSprites.splashguard,	"SPLASHGUARD",	60,		60,		50,		165,	110,	95,		125,	100,	spriteSizes.small);
sprite_add_to_grid(allSprites.demolitops,	"DEMOLITOPS",	180,	110,	160,	75,		60,		110,	90,		100,	spriteSizes.xLarge);
sprite_add_to_grid(allSprites.uprooter,		"UPROOTER",		155,	170,	50,		90,		60,		165,	75,		75,		spriteSizes.small);
sprite_add_to_grid(allSprites.nintox,		"NINTOX",		160,	85,		120,	90,		100,	120,	170,	100,	spriteSizes.medium);
sprite_add_to_grid(allSprites.shpupo,		"SHPUPO",		120,	80,		80,		125,	100,	100,	175,	60,		spriteSizes.medium);
sprite_add_to_grid(allSprites.gembo,		"GEMBO",		130,	130,	90,		90,		90,		90,		90,		90,		spriteSizes.medium);
sprite_add_to_grid(allSprites.pondile,		"PONDILE",		110,	75,		70,		140,	90,		90,		115,	80,		spriteSizes.medium);
sprite_add_to_grid(allSprites.hachaChacha,	"HACHA-CHACHA",	80,		50,		170,	75,		75,		110,	90,		150,	spriteSizes.small);
sprite_add_to_grid(allSprites.podric,		"PODRIC",		175,	70,		50,		105,	50,		165,	160,	100,	spriteSizes.small);
sprite_add_to_grid(allSprites.needlepaw,	"NEEDLEPAW",	155,	55,		110,	50,		90,		110,	180,	50,		spriteSizes.small);
sprite_add_to_grid(allSprites.mrSudsy,		"MR SUDSY",		60,		60,		50,		160,	60,		60,		160,	150,	spriteSizes.xSmall);
sprite_add_to_grid(allSprites.bookish,		"BOOKISH",		50,		45,		120,	120,	135,	120,	95,		90,		spriteSizes.xSmall);
sprite_add_to_grid(allSprites.pleep,		"PLEEP",		130,	65,		115,	70,		155,	50,		115,	100,	spriteSizes.small);
sprite_add_to_grid(allSprites.glidrake,		"GLIDRAKE",		115,	60,		130,	65,		165,	50,		150,	90,		spriteSizes.medium);
sprite_add_to_grid(allSprites.furvor,		"FURVOR",		160,	110,	110,	55,		85,		125,	140,	80,		spriteSizes.small);
sprite_add_to_grid(allSprites.zephira,		"ZEPHIRA",		120,	60,		70,		90,		160,	130,	165,	100,	spriteSizes.xSmall);
sprite_add_to_grid(allSprites.fishmonger,	"FISHMONGER",	165,	130,	60,		165,	90,		80,		95,		80,		spriteSizes.medium);
sprite_add_to_grid(allSprites.songbird,		"SONGBIRD",		70,		90,		65,		85,		105,	85,		120,	185,	spriteSizes.medium);
sprite_add_to_grid(allSprites.exonolith,	"EXONOLITH",	70,		210,	90,		60,		90,		140,	50,		100,	spriteSizes.large);
sprite_add_to_grid(allSprites.drumline,		"DRUMLINE",		100,	160,	85,		65,		90,		90,		120,	150,	spriteSizes.small);
sprite_add_to_grid(allSprites.mirrefract,	"MIRREFRACT",	150,	85,		80,		50,		120,	90,		110,	85,		spriteSizes.medium);
sprite_add_to_grid(allSprites.fortuga,		"FORTUGA",		90,		190,	65,		155,	75,		135,	45,		100,	spriteSizes.xLarge);
sprite_add_to_grid(allSprites.tickdoff,		"TICKDOFF",		130,	75,		190,	50,		110,	60,		120,	85,		spriteSizes.large);
sprite_add_to_grid(allSprites.arraynge,		"ARRAYNGE",		45,		65,		120,	70,		150,	70,		145,	100,	spriteSizes.small);
sprite_add_to_grid(allSprites.scrootineyes,	"SCROOTINEYES",	140,	120,	70,		55,		125,	70,		105,	120,	spriteSizes.large);
sprite_add_to_grid(allSprites.joe,			"JOE",			170,	100,	110,	110,	70,		85,		100,	85,		spriteSizes.large);
sprite_add_to_grid(allSprites.canuki,		"CANUKI",		145,	165,	70,		70,		70,		120,	80,		85,		spriteSizes.large);
sprite_add_to_grid(allSprites.gastronimo,	"GASTRONIMO",	140,	140,	100,	100,	70,		100,	60,		100,	spriteSizes.large);
sprite_add_to_grid(allSprites.flotsu,		"FLOTSU",		90,		135,	50,		180,	100,	85,		60,		100,	spriteSizes.large);
sprite_add_to_grid(allSprites.blitzkrane,	"BLITZKRANE",	150,	105,	85,		90,		165,	70,		145,	75,		spriteSizes.xLarge);
sprite_add_to_grid(allSprites.heatsune,		"HEATSUNE",		120,	70,		185,	50,		125,	100,	175,	85,		spriteSizes.medium);
sprite_add_to_grid(allSprites.floopwalker,	"FLOOPWALKER",	65,		120,	90,		90,		100,	130,	120,	125,	spriteSizes.small);
sprite_add_to_grid(allSprites.stewardrake,	"STEWARDRAKE",	80,		155,	120,	90,		135,	90,		115,	100,	spriteSizes.medium);
sprite_add_to_grid(allSprites.doormaus,		"DOORMAUS",		50,		65,		95,		95,		110,	95,		185,	100,	spriteSizes.small);
sprite_add_to_grid(allSprites.plasmass,		"PLASMASS",		130,	75,		120,	45,		195,	45,		170,	50,		spriteSizes.large);
sprite_add_to_grid(allSprites.shredator,	"SHREDATOR",	175,	110,	50,		165,	95,		75,		150,	75,		spriteSizes.large);
sprite_add_to_grid(allSprites.jackhammer,	"JACKHAMMER",	175,	135,	50,		60,		60,		70,		160,	150,	spriteSizes.small);
sprite_add_to_grid(allSprites.capnClops,	"CAP'N CLOPS",	150,	150,	95,		70,		70,		125,	90,		35,		spriteSizes.large);
sprite_add_to_grid(allSprites.durendoux,	"DURENDOUX",	150,	200,	90,		90,		40,		140,	45,		150,	spriteSizes.medium);
sprite_add_to_grid(allSprites.cenotomb,		"CENOTOMB",		160,	95,		135,	55,		105,	100,	75,		100,	spriteSizes.large);
sprite_add_to_grid(allSprites.cleansage,	"CLEANSAGE",	70,		125,	135,	60,		105,	140,	55,		80,		spriteSizes.large);
sprite_add_to_grid(allSprites.wyrmpool,		"WYRMPOOL",		140,	130,	60,		160,	135,	45,		80,		125,	spriteSizes.xLarge);
sprite_add_to_grid(allSprites.cragma,		"CRAGMA",		145,	150,	170,	65,		65,		135,	35,		100,	spriteSizes.large);
sprite_add_to_grid(allSprites.corvolt,		"CORVOLT",		100,	145,	60,		135,	150,	70,		110,	100,	spriteSizes.large);
sprite_add_to_grid(allSprites.chromosilos,	"CHROMOSILOS",	185,	125,	120,	70,		55,		160,	70,		75,		spriteSizes.xLarge);
sprite_add_to_grid(allSprites.domino,		"DOMINO",		135,	50,		65,		65,		65,		65,		140,	150,	spriteSizes.small);
sprite_add_to_grid(allSprites.anachronaut,	"ANACHRONAUT",	50,		55,		120,	120,	120,	120,	170,	100,	spriteSizes.small);
sprite_add_to_grid(allSprites.omnost,		"OMNOST",		50,		80,		110,	110,	150,	110,	70,		150,	spriteSizes.xLarge);
sprite_add_to_grid(allSprites.prismatter,	"PRISMATTER",	180,	145,	40,		135,	40,		135,	75,		35,		spriteSizes.xLarge);
sprite_add_to_grid(allSprites.kronarc,		"KRONARC",		80,		120,	120,	120,	120,	120,	95,		150,	spriteSizes.xLarge);
sprite_add_to_grid(allSprites.cosmalcos,	"COSMALCOS",	120,	195,	50,		50,		50,		50,		30,		150,	spriteSizes.xLarge);

#endregion

function sprite_get_stat(_stat, _sprite) {
	var sp	= _sprite;
	var st	= _stat;
	var g	= global.spriteGrid;
	
	var val	= g[# st,	sp];
	return val;
}
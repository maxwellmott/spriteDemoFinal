enum alignments {
	natural,
	mechanical,
	astral,
	height
}

enum allSprites {
	gembo,
	pondle,
	hachaChacha,
	podric,
	needlepaw,
	sudsy,
	bookish,
	pleep,
	tyfoo,
	furvor,
	zephira,
	fishmonger,
	songbird,
	exonolith,
	drumline,
	mirrefract,
	fortuga,
	tikdof,
	arraynge,
	scrootineyes,
	joe,
	canuki,
	gastronimo,
	flotsu,
	blitzkrane,
	heatsune,
	floopwalker,
	stewardrake,
	doormaus,
	plasmass,
	shredator,
	jackhammer,
	stinklops,
	durendoux,
	cenotomb,
	cleansage,
	wyrmpool,
	cragma,
	corvolt,
	chromosilos,
	domino,
	anachronaut,
	omnost,
	prismatter,
	kronarc,
	cosmalcos,
	height
}

enum spriteParams {
	ID,
	name,
	alignment,
	spells,
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

#region	CREATE ALL SPELL LISTS

	#region		GEMBO
		var gemboSpells = ds_list_create();
		
		ds_list_add(gemboSpells,
			spells.fireball,
			spells.shock,
			spells.expelForce,
			spells.grapple,
			spells.empathize,
			spells.arcBlast,
			spells.amandsEnergyBlast,
			spells.shiftPerspective,
			spells.psychicImpact,
			spells.destructiveBlow,
			spells.psychicFissure,
			spells.deflectiveShield,
			spells.dionsGamblingBlast,
			spells.magneticPulse,
			spells.fullThrust
		);
	#endregion
	
	#region		PONDLE
		var pondleSpells = ds_list_create();
		
		ds_list_add(pondleSpells,
			spells.decay,
			spells.typhoon,
			spells.rubursWaterCannon,
			spells.waterlog,
			spells.rapidStrike,
			spells.quicksand,
			spells.downpour,
			spells.landslide,
			spells.sneakAttack,
			spells.endlessRiver,
			spells.fullThrust
		);
	#endregion

	#region		HACHA-CHACHA
		var hachaSpells = ds_list_create();
		
		ds_list_add(hachaSpells,
			spells.fireball,
			spells.empathize,
			spells.pyrokinesis,
			spells.purifyingFlame,
			spells.noxiousFumes,
			spells.burnOut,
			spells.lavaSpire
		);
	#endregion

	#region		PODRIC
		var podricSpells = ds_list_create();
		
		ds_list_add(podricSpells,
			spells.decay,
			spells.lusiasHarvestSpell,
			spells.rapidStrike,
			spells.destructiveBlow,
			spells.sneakAttack,
			spells.dionsParry,
			spells.windSlice,
			spells.spherasCurse,
			spells.destabilizingBlow,
			spells.fullThrust
		);
	#endregion
	
	#region		NEEDLEPAW
		var needlepawSpells = ds_list_create();
		
		ds_list_add(needlepawSpells,
			spells.shock,
			spells.rapidStrike,
			spells.loomingDanger,
			spells.intercept,
			spells.lordMogradthsRage,
			spells.drainLifeforce,
			spells.amandsEnergyBlast,
			spells.psychicImpact,
			spells.psychicFissure,
			spells.sneakAttack,
			spells.dionsBarterTrick,
			spells.channelEssence,
			spells.telekineticBlast
		);
	#endregion
#endregion

#region CREATE SPRITE GRID

global.spriteGrid = ds_grid_create(spriteParams.height, allSprites.height);

function sprite_add_to_grid(_ID, _name, _power, _resistance, _fire, _water, _storm, _earth, _agility, _luck, _size) {
	var i = 0; repeat (spriteParams.height) {
		ds_grid_add(global.spriteGrid, i, _ID, argument[i]);
		
		i++;
	}
}
	
#region ALL SPRITE DATA
//					ID							NAME				ALIGNMENT				POWER	RES		FIRE	WATER	STORM	EARTH	AGL		LUCK	SIZE
sprite_add_to_grid(allSprites.gembo,			"GEMBO",			alignments.astral,		120,	120,	115,	100,	115,	100,	70,		90,		spriteSizes.medium);
sprite_add_to_grid(allSprites.pondle,			"PONDLE",			alignments.natural,		110,	75,		70,		140,	90,		90,		130,	80,		spriteSizes.medium);
sprite_add_to_grid(allSprites.hachaChacha,		"HACHA-CHACHA",		alignments.natural,		80,		50,		190,	35,		70,		110,	90,		150,	spriteSizes.small);
sprite_add_to_grid(allSprites.podric,			"PODRIC",			alignments.natural,		165,	70,		30,		90,		40,		180,	160,	100,	spriteSizes.small);
sprite_add_to_grid(allSprites.needlepaw,		"NEEDLEPAW",		alignments.astral,		130,	70,		110,	55,		130,	110,	180,	50,		spriteSizes.small);
sprite_add_to_grid(allSprites.sudsy,			"SUDSY",			alignments.mechanical,	60,		70,		60,		150,	60,		60,		170,	150,	spriteSizes.xSmall);
sprite_add_to_grid(allSprites.bookish,			"BOOKISH",			alignments.mechanical,	50,		50,		120,	120,	120,	120,	80,		90,		spriteSizes.xSmall);
sprite_add_to_grid(allSprites.pleep,			"PLEEP",			alignments.astral,		110,	80,		100,	70,		150,	50,		100,	100,	spriteSizes.small);
sprite_add_to_grid(allSprites.tyfoo,			"TYFOO",			alignments.natural,		100,	60,		110,	80,		160,	50,		150,	90,		spriteSizes.medium);
sprite_add_to_grid(allSprites.furvor,			"FURVOR",			alignments.natural,		140,	90,		110,	55,		85,		110,	130,	80,		spriteSizes.small);
sprite_add_to_grid(allSprites.zephira,			"ZEPHIRA",			alignments.astral,		100,	60,		70,		90,		160,	110,	140,	100,	spriteSizes.xSmall);
sprite_add_to_grid(allSprites.fishmonger,		"FISHMONGER",		alignments.natural,		150,	130,	70,		150,	90,		80,		85,		80,		spriteSizes.medium);
sprite_add_to_grid(allSprites.songbird,			"SONGBIRD",			alignments.astral,		70,		90,		80,		90,		125,	100,	120,	150,	spriteSizes.medium);
sprite_add_to_grid(allSprites.exonolith,		"EXONOLITH",		alignments.astral,		100,	190,	90,		60,		90,		140,	50,		100,	spriteSizes.large);
sprite_add_to_grid(allSprites.drumline,			"DRUMLINE",			alignments.mechanical,	80,		145,	75,		75,		90,		100,	120,	150,	spriteSizes.small);
sprite_add_to_grid(allSprites.mirrefract,		"MIRREFRACT",		alignments.mechanical,	100,	130,	90,		60,		120,	130,	110,	85,		spriteSizes.medium);
sprite_add_to_grid(allSprites.fortuga,			"FORTUGA",			alignments.natural,		100,	180,	65,		130,	65,		130,	60,		100,	spriteSizes.xLarge);
sprite_add_to_grid(allSprites.tikdof,			"TIKDOF",			alignments.mechanical,	145,	95,		190,	40,		80,		70,		120,	85,		spriteSizes.large);
sprite_add_to_grid(allSprites.arraynge,			"ARRAYNGE",			alignments.mechanical,	65,		85,		100,	90,		150,	90,		115,	100,	spriteSizes.small);
sprite_add_to_grid(allSprites.scrootineyes,		"SCROOTINEYES",		alignments.natural,		110,	100,	70,		70,		130,	70,		70,		120,	spriteSizes.large);
sprite_add_to_grid(allSprites.joe,				"JOE",				alignments.mechanical,	160,	115,	110,	110,	70,		85,		100,	85,		spriteSizes.large);
sprite_add_to_grid(allSprites.canuki,			"CANUKI",			alignments.natural,		145,	165,	70,		70,		70,		140,	80,		85,		spriteSizes.large);
sprite_add_to_grid(allSprites.gastronimo,		"GASTRONIMO",		alignments.mechanical,	140,	140,	100,	100,	70,		120,	60,		100,	spriteSizes.large);
sprite_add_to_grid(allSprites.flotsu,			"FLOTSU",			alignments.natural,		90,		135,	50,		180,	120,	100,	60,		100,	spriteSizes.large);
sprite_add_to_grid(allSprites.blitzkrane,		"BLITZKRANE",		alignments.astral,		140,	90,		60,		100,	165,	70,		135,	75,		spriteSizes.xLarge);
sprite_add_to_grid(allSprites.heatsune,			"HEATSUNE",			alignments.astral,		110,	70,		170,	50,		115,	100,	135,	85,		spriteSizes.medium);
sprite_add_to_grid(allSprites.floopwalker,		"FLOOPWALKER",		alignments.astral,		65,		100,	90,		90,		120,	120,	120,	125,	spriteSizes.small);
sprite_add_to_grid(allSprites.stewardrake,		"STEWARDRAKE",		alignments.astral,		65,		140,	120,	90,		120,	90,		100,	100,	spriteSizes.medium);
sprite_add_to_grid(allSprites.doormaus,			"DOORMAUS",			alignments.astral,		50,		85,		110,	110,	110,	110,	160,	100,	spriteSizes.small);
sprite_add_to_grid(allSprites.plasmass,			"PLASMASS",			alignments.mechanical,	130,	100,	120,	45,		180,	45,		165,	50,		spriteSizes.large);
sprite_add_to_grid(allSprites.shredator,		"SHREDATOR",		alignments.natural,		170,	110,	45,		165,	80,		60,		130,	75,		spriteSizes.large);
sprite_add_to_grid(allSprites.jackhammer,		"JACKHAMMER",		alignments.astral,		160,	120,	35,		60,		70,		80,		160,	150,	spriteSizes.small);
sprite_add_to_grid(allSprites.stinklops,		"STINKLOPS",		alignments.natural,		190,	135,	110,	70,		80,		125,	90,		35,		spriteSizes.large);
sprite_add_to_grid(allSprites.durendoux,		"DURENDOUX",		alignments.astral,		135,	185,	80,		40,		40,		160,	45,		150,	spriteSizes.medium);
sprite_add_to_grid(allSprites.cenotomb,			"CENOTOMB",			alignments.astral,		150,	120,	120,	60,		90,		90,		90,		100,	spriteSizes.large);
sprite_add_to_grid(allSprites.cleansage,		"CLEANSAGE",		alignments.astral,		90,		140,	120,	70,		90,		140,	35,		80,		spriteSizes.large);
sprite_add_to_grid(allSprites.wyrmpool,			"WYRMPOOL",			alignments.astral,		130,	120,	35,		170,	140,	35,		80,		125,	spriteSizes.xLarge);
sprite_add_to_grid(allSprites.cragma,			"CRAGMA",			alignments.natural,		170,	150,	170,	30,		30,		150,	35,		100,	spriteSizes.large);
sprite_add_to_grid(allSprites.corvolt,			"CORVOLT",			alignments.natural,		120,	130,	60,		120,	140,	60,		110,	100,	spriteSizes.large);
sprite_add_to_grid(allSprites.chromosilos,		"CHROMOSILOS",		alignments.mechanical,	190,	140,	120,	40,		40,		160,	70,		75,		spriteSizes.xLarge);
sprite_add_to_grid(allSprites.domino,			"DOMINO",			alignments.mechanical,	135,	70,		85,		85,		85,		85,		140,	150,	spriteSizes.small);
sprite_add_to_grid(allSprites.anachronaut,		"ANACHRONAUT",		alignments.mechanical,	35,		60,		120,	120,	120,	120,	160,	100,	spriteSizes.small);
sprite_add_to_grid(allSprites.omnost,			"OMNOST",			undefined,				50,		100,	110,	110,	150,	110,	70,		150,	spriteSizes.xLarge);
sprite_add_to_grid(allSprites.prismatter,		"PRISMATTER",		undefined,				175,	175,	80,		80,		80,		150,	75,		35,		spriteSizes.xLarge);
sprite_add_to_grid(allSprites.kronarc,			"KRONARC",			undefined,				100,	100,	100,	100,	100,	100,	100,	150,	spriteSizes.xLarge);
sprite_add_to_grid(allSprites.cosmalcos,		"COSMALCOS",		undefined,				120,	180,	30,		30,		30,		30,		30,		150,	spriteSizes.xLarge);

#endregion

// encode grid
global.allSprites = encode_grid(global.spriteGrid);

// delete grid

#endregion

function sprite_get_stat(_stat, _sprite) {
	var sp	= _sprite;
	var st	= _stat;
	var g	= global.spriteGrid;
	
	var val	= g[# st,	sp];
	return val;
}

function sprite_load_parameters() {
	
}
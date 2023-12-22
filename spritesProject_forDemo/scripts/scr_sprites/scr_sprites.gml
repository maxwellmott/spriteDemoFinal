enum ALIGNMENTS {
	natural,
	mechanical,
	astral,
	height
}

enum SPRITES {
	gembo,
	pondile,
	hachaChacha,
	podric,
	needlepaw,
	sudsy,
	bookish,
	pleep,
	glidrake,
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

enum SPRITE_PARAMS {
	ID,
	name,
	sprite,
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
			SPELLS.fireball,
			SPELLS.shock,
			SPELLS.expelForce,
			SPELLS.ruburs_grapple,
			SPELLS.empathize,
			SPELLS.arcBlast,
			SPELLS.amandsEnergyBlast,
			SPELLS.shiftPerspective,
			SPELLS.psychicImpact,
			SPELLS.destructiveBlow,
			SPELLS.psychicFissure,
			SPELLS.deflectiveShield,
			SPELLS.dionsGamblingBlast,
			SPELLS.magneticPulse,
			SPELLS.fullThrust
		);
	#endregion
	
	#region		pondile
		var pondileSpells = ds_list_create();
		
		ds_list_add(pondileSpells,
			SPELLS.decay,
			SPELLS.typhoon,
			SPELLS.rubursWaterCannon,
			SPELLS.waterlog,
			SPELLS.rapidStrike,
			SPELLS.quicksand,
			SPELLS.downpour,
			SPELLS.landslide,
			SPELLS.endlessRiver
		);
	#endregion

	#region		HACHA-CHACHA
		var hachaSpells = ds_list_create();
		
		ds_list_add(hachaSpells,
			SPELLS.fireball,
			SPELLS.empathize,
			SPELLS.pyrokinesis,
			SPELLS.purifyingFlame,
			SPELLS.noxiousFumes,
			SPELLS.burnOut,
			SPELLS.lavaSpire
		);
	#endregion

	#region		PODRIC
		var podricSpells = ds_list_create();
		
		ds_list_add(podricSpells,
			SPELLS.decay,
			SPELLS.lusiasHarvestSpell,
			SPELLS.rapidStrike,
			SPELLS.destructiveBlow,
			SPELLS.sneakAttack,
			SPELLS.dionsParry,
			SPELLS.windSlice,
			SPELLS.spherasCurse,
			SPELLS.destabilizingBlow,
			SPELLS.fullThrust
		);
	#endregion
	
	#region		NEEDLEPAW
		var needlepawSpells = ds_list_create();
		
		ds_list_add(needlepawSpells,
			SPELLS.shock,
			SPELLS.rapidStrike,
			SPELLS.loomingDanger,
			SPELLS.intercept,
			SPELLS.lordMogradthsRage,
			SPELLS.drainLifeforce,
			SPELLS.amandsEnergyBlast,
			SPELLS.psychicImpact,
			SPELLS.psychicFissure,
			SPELLS.sneakAttack,
			SPELLS.dionsBarterTrick,
			SPELLS.channelEssence,
			SPELLS.telekineticBlast
		);
	#endregion
	
	#region		SUDSY
		var sudsySpells = ds_list_create();
		
		ds_list_add(sudsySpells,
			SPELLS.holyWater,
			SPELLS.rubursWaterCannon,
			SPELLS.waterlog,
			SPELLS.steamBath,
			SPELLS.empathize,
			SPELLS.osmosis,
			SPELLS.jabulsFightSong
		);
	#endregion
	
	#region		BOOKISH
		var bookishSpells = ds_list_create();
		
		ds_list_add(bookishSpells,
			SPELLS.solarFlare,
			SPELLS.tidalForce,
			SPELLS.nebulaStorm,
			SPELLS.tectonicShift,
			SPELLS.fireball,
			SPELLS.shock,
			SPELLS.decay,
			SPELLS.expelForce,
			SPELLS.ladySolanusGrace,
			SPELLS.typhoon,
			SPELLS.healingLight,
			SPELLS.rubursWaterCannon,
			SPELLS.lusiasHarvestSpell,
			SPELLS.intercept,
			SPELLS.empathize,
			SPELLS.amandsEnergyBlast,
			SPELLS.psychicImpact,
			SPELLS.creciasCrystalSpikes,
			SPELLS.psychicFissure,
			SPELLS.rearrange
		);
	#endregion
	
	#region		PLEEP
		var pleepSpells = ds_list_create();
		
		ds_list_add(pleepSpells,
			SPELLS.fireball,
			SPELLS.expelForce,
			SPELLS.typhoon,
			SPELLS.airPressure,
			SPELLS.rapidStrike,
			SPELLS.intercept,
			SPELLS.empathize,
			SPELLS.hellfire,
			SPELLS.pyrokinesis,
			SPELLS.deflectiveShield,
			SPELLS.windSlice,
			SPELLS.creciasCrystalWind,
			SPELLS.cloudBreak
		);
	#endregion
		
	#region		GLIDRAKE
		var glidrakeSpells = ds_list_create();
		
		ds_list_add(glidrakeSpells,
			SPELLS.nebulaStorm,
			SPELLS.fireball,
			SPELLS.typhoon,
			SPELLS.airPressure,
			SPELLS.rapidStrike,
			SPELLS.intercept,
			SPELLS.ballLightning,
			SPELLS.pyrokinesis,
			SPELLS.arcBlast,
			SPELLS.dionsParry,
			SPELLS.windSlice,
			SPELLS.creciasCrystalWind,
			SPELLS.cloudBreak
		);
	#endregion
	
	#region		FURVOR
		var furvorSpells = ds_list_create();
		
		ds_list_add(furvorSpells,
			SPELLS.ruburs_grapple,
			SPELLS.lusiasHarvestSpell,
			SPELLS.superbloom,
			SPELLS.rapidStrike,
			SPELLS.loomingDanger,
			SPELLS.intercept,
			SPELLS.lordMogradthsRage,
			SPELLS.hikamsWinterSpell,
			SPELLS.landslide,
			SPELLS.tremor,
			SPELLS.destructiveBlow,
			SPELLS.jabulsFightSong,
			SPELLS.sneakAttack,
			SPELLS.channelEssence,
			SPELLS.spherasCurse,
			SPELLS.destabilizingBlow,
			SPELLS.fullThrust
		);
	#endregion	
	
	#region		ZEPHIRA
		var zephiraSpells = ds_list_create();

		ds_list_add(zephiraSpells,
			SPELLS.nebulaStorm,
			SPELLS.shock,
			SPELLS.decay,
			SPELLS.expelForce,
			SPELLS.ladySolanusGrace,
			SPELLS.typhoon,
			SPELLS.healingLight,
			SPELLS.lusiasHarvestSpell,
			SPELLS.airPressure,
			SPELLS.rapidStrike,
			SPELLS.loomingDanger,
			SPELLS.drainLifeforce,
			SPELLS.hikamsWinterSpell,
			SPELLS.psychicImpact,
			SPELLS.skydive,
			SPELLS.creciasCrystalSpikes,
			SPELLS.psychicFissure,
			SPELLS.rearrange,
			SPELLS.sneakAttack,
			SPELLS.deflectiveShield,
			SPELLS.dionsBarterTrick,
			SPELLS.windSlice,
			SPELLS.channelEssence,
			SPELLS.creciasCrystalWind,
			SPELLS.cloudBreak,
			SPELLS.telekineticBlast,
			SPELLS.spherasDemise
		);
	#endregion
	
	#region		FISHMONGER
		var fishmongerSpells = ds_list_create();
		
		ds_list_add(fishmongerSpells,
			SPELLS.tidalForce,
			SPELLS.expelForce,
			SPELLS.typhoon,
			SPELLS.rubursWaterCannon,
			SPELLS.ruburs_grapple,
			SPELLS.waterlog,
			SPELLS.loomingDanger,
			SPELLS.undertow,
			SPELLS.downpour,
			SPELLS.flashFreeze,
			SPELLS.destructiveBlow,
			SPELLS.deflectiveShield,
			SPELLS.dionsParry,
			SPELLS.dionsBarterTrick,
			SPELLS.windSlice,
			SPELLS.channelEssence,
			SPELLS.endlessRiver,
			SPELLS.cloudBreak,
			SPELLS.destabilizingBlow,
			SPELLS.fullThrust,
		);
	#endregion
	
	#region		SONGBIRD
		var songbirdSpells = ds_list_create();
		
		ds_list_add(songbirdSpells,
			SPELLS.expelForce,
			SPELLS.typhoon,
			SPELLS.healingLight,
			SPELLS.airPressure,
			SPELLS.superbloom,
			SPELLS.empathize,
			SPELLS.hikamsWinterSpell,
			SPELLS.amandsEnergyBlast,
			SPELLS.shiftPerspective,
			SPELLS.psychicImpact,
			SPELLS.skydive,
			SPELLS.purifyingFlame,
			SPELLS.jabulsFightSong,
			SPELLS.noxiousFumes,
			SPELLS.psychicFissure,
			SPELLS.rearrange,
			SPELLS.dionsGamblingBlast,
			SPELLS.dionsBarterTrick,
			SPELLS.windSlice,
			SPELLS.channelEssence,
			SPELLS.spherasCurse,
			SPELLS.creciasCrystalWind,
			SPELLS.cloudBreak,
			SPELLS.telekineticBlast,
			SPELLS.broadcastData
		);	
	#endregion
	
	#region		EXONOLITH
		var exonolithSpells = ds_list_create();
		
		ds_list_add(exonolithSpells,
			SPELLS.solarFlare,
			SPELLS.tectonicShift,
			SPELLS.shock,
			SPELLS.expelForce,
			SPELLS.ladySolanusGrace,
			SPELLS.healingLight,
			SPELLS.drainLifeforce,
			SPELLS.pyrokinesis,
			SPELLS.arcBlast,
			SPELLS.landslide,
			SPELLS.amandsEnergyBlast,
			SPELLS.psychicImpact,
			SPELLS.tremor,
			SPELLS.purifyingFlame,
			SPELLS.psychicFissure,
			SPELLS.deflectiveShield,
			SPELLS.magneticPulse,
			SPELLS.channelEssence,
			SPELLS.cloudBreak,
			SPELLS.telekineticBlast
		);
	#endregion
	
	#region		DRUMLINE
		var drumlineSpells = ds_list_create();
		
		ds_list_add(drumlineSpells,
			SPELLS.expelForce,
			SPELLS.ladySolanusGrace,
			SPELLS.empathize,
			SPELLS.destructiveBlow,
			SPELLS.jabulsFightSong,
			SPELLS.rearrange,
			SPELLS.deflectiveShield,
			SPELLS.dionsGamblingBlast,
		);
	#endregion
	
	#region		MIRREFRACT
		var mirrefractSpells = ds_list_create();
		
		ds_list_add(mirrefractSpells,
			SPELLS.fireball,
			SPELLS.shock,
			SPELLS.expelForce,
			SPELLS.ruburs_grapple,
			SPELLS.rapidStrike,
			SPELLS.intercept,
			SPELLS.ballLightning,
			SPELLS.amandsEnergyBlast,
			SPELLS.shiftPerspective,
			SPELLS.deflectiveShield,
			SPELLS.dionsParry,
			SPELLS.magneticPulse,
			SPELLS.channelEssence,
			SPELLS.destabilizingBlow,
			SPELLS.fullThrust
		);
	#endregion
	
	#region		FORTUGA
		var fortugaSpells = ds_list_create();
		
		ds_list_add(fortugaSpells,
			SPELLS.tidalForce,
			SPELLS.rubursWaterCannon,
			SPELLS.waterlog,
			SPELLS.intercept,
			SPELLS.undertow,
			SPELLS.empathize,
			SPELLS.downpour,
			SPELLS.landslide,
			SPELLS.tremor,
			SPELLS.jabulsFightSong,
			SPELLS.deflectiveShield,
			SPELLS.endlessRiver,
		);
	#endregion
	
	#region		TIKDOFF
		var tikdoffSpells = ds_list_create();
		
		ds_list_add(tikdoffSpells,
			SPELLS.solarFlare,
			SPELLS.fireball,
			SPELLS.expelForce,
			SPELLS.ruburs_grapple,
			SPELLS.hellfire,
			SPELLS.lordMogradthsRage,
			SPELLS.pyrokinesis,
			SPELLS.arcBlast,
			SPELLS.landslide,
			SPELLS.tremor,
			SPELLS.noxiousFumes,
			SPELLS.burnOut,
			SPELLS.magneticPulse,
			SPELLS.lavaSpire,
			SPELLS.destabilizingBlow,
			SPELLS.fullThrust
		);
	#endregion
	
	#region		ARRAYNGE
		var arrayngeSpells = ds_list_create();
		
		ds_list_add(arrayngeSpells,
			SPELLS.shock,
			SPELLS.expelForce,
			SPELLS.intercept,
			SPELLS.arcBlast,
			SPELLS.amandsEnergyBlast,
			SPELLS.noxiousFumes,
			SPELLS.rearrange,
			SPELLS.deflectiveShield,
			SPELLS.magneticPulse,
			SPELLS.broadcastData,
			SPELLS.collapseSpace
		);
	#endregion
	
	#region		SCROOTINEYES
		var scrootineyesSpells = ds_list_create();
		
		ds_list_add(scrootineyesSpells,
			SPELLS.decay,
			SPELLS.typhoon,
			SPELLS.airPressure,
			SPELLS.rapidStrike,
			SPELLS.loomingDanger,
			SPELLS.intercept,
			SPELLS.empathize,
			SPELLS.skydive,
			SPELLS.sneakAttack,
			SPELLS.deflectiveShield,
			SPELLS.windSlice,
			SPELLS.creciasCrystalWind,
			SPELLS.cloudBreak,
			SPELLS.broadcastData
		);
	#endregion
	
	#region		JOE
		var joeSpells = ds_list_create();
		
		ds_list_add(joeSpells,
			SPELLS.fireball,
			SPELLS.expelForce,
			SPELLS.ruburs_grapple,
			SPELLS.waterlog,
			SPELLS.intercept,
			SPELLS.steamBath,
			SPELLS.drainLifeforce,
			SPELLS.osmosis,
			SPELLS.landslide,
			SPELLS.tremor,
			SPELLS.destructiveBlow,
			SPELLS.burnOut,
			SPELLS.expandTime
		);
	#endregion
	
	#region		CANUKI
		var canukiSpells = ds_list_create();
		
		ds_list_add(canukiSpells,
			SPELLS.decay,
			SPELLS.lusiasHarvestSpell,
			SPELLS.landslide,
			SPELLS.tremor,
			SPELLS.skydive,
			SPELLS.jabulsFightSong,
			SPELLS.stinkbomb,
			SPELLS.spherasDemise
		);
	#endregion
	
	#region		GASTRONIMO
		var gastronimoSpells = ds_list_create();
		
		ds_list_add(gastronimoSpells,
			SPELLS.ladySolanusGrace,
			SPELLS.healingLight,
			SPELLS.rubursWaterCannon,
			SPELLS.ruburs_grapple,
			SPELLS.lusiasHarvestSpell,
			SPELLS.steamBath,
			SPELLS.landslide,
			SPELLS.shiftPerspective,
			SPELLS.tremor,
			SPELLS.purifyingFlame,
			SPELLS.jabulsFightSong,
			SPELLS.dionsBarterTrick,
			SPELLS.channelEssence,
			SPELLS.destabilizingBlow,
			SPELLS.fullThrust
		);
	#endregion
	
	#region		FLOTSU
		var flotsuSpells = ds_list_create();
		
		ds_list_add(flotsuSpells,
			SPELLS.tidalForce,
			SPELLS.holyWater,
			SPELLS.ladySolanusGrace,
			SPELLS.typhoon,
			SPELLS.healingLight,
			SPELLS.rubursWaterCannon,
			SPELLS.waterlog,
			SPELLS.airPressure,
			SPELLS.intercept,
			SPELLS.steamBath,
			SPELLS.undertow,
			SPELLS.empathize,
			SPELLS.downpour,
			SPELLS.hikamsWinterSpell,
			SPELLS.osmosis,
			SPELLS.flashFreeze,
			SPELLS.landslide,
			SPELLS.amandsEnergyBlast,
			SPELLS.shiftPerspective,
			SPELLS.psychicImpact,
			SPELLS.tremor,
			SPELLS.skydive,
			SPELLS.jabulsFightSong,
			SPELLS.windSlice,
			SPELLS.endlessRiver,
			SPELLS.telekineticBlast
		);
	#endregion
	
	#region		BLITZKRANE
		var blitzkraneSpells = ds_list_create();
		
		ds_list_add(blitzkraneSpells,
			SPELLS.tidalForce,
			SPELLS.nebulaStorm,
			SPELLS.holyWater,
			SPELLS.shock,
			SPELLS.typhoon,
			SPELLS.ruburs_grapple,
			SPELLS.waterlog,
			SPELLS.airPressure,
			SPELLS.rapidStrike,
			SPELLS.intercept,
			SPELLS.undertow,
			SPELLS.ballLightning,
			SPELLS.downpour,
			SPELLS.arcBlast,
			SPELLS.skydive,
			SPELLS.jabulsFightSong,
			SPELLS.windSlice,
			SPELLS.creciasCrystalWind,
			SPELLS.cloudBreak,
			SPELLS.fullThrust,
			SPELLS.expandTime,
			SPELLS.spherasDemise
		);
	#endregion
	
	#region		HEATSUNE
		var heatsuneSpells = ds_list_create();
		
		ds_list_add(heatsuneSpells,
			SPELLS.solarFlare,
			SPELLS.nebulaStorm,
			SPELLS.fireball,
			SPELLS.shock,
			SPELLS.decay,
			SPELLS.expelForce,
			SPELLS.ladySolanusGrace,
			SPELLS.healingLight,
			SPELLS.rapidStrike,
			SPELLS.hellfire,
			SPELLS.ballLightning,
			SPELLS.lordMogradthsRage,
			SPELLS.drainLifeforce,
			SPELLS.pyrokinesis,
			SPELLS.arcBlast,
			SPELLS.amandsEnergyBlast,
			SPELLS.psychicImpact,
			SPELLS.purifyingFlame,
			SPELLS.noxiousFumes,
			SPELLS.psychicFissure,
			SPELLS.sneakAttack,
			SPELLS.burnOut,
			SPELLS.windSlice,
			SPELLS.channelEssence,
			SPELLS.lavaSpire,
			SPELLS.telekineticBlast,
			SPELLS.collapseSpace,
			SPELLS.spherasDemise
		);
			
	#endregion
	
	#region		FLOOPWALKER
		var floopwalkerSpells = ds_list_create();
		
		ds_list_add(floopwalkerSpells,
			SPELLS.solarFlare,
			SPELLS.nebulaStorm,
			SPELLS.decay,
			SPELLS.ladySolanusGrace,
			SPELLS.healingLight,
			SPELLS.typhoon,
			SPELLS.airPressure,
			SPELLS.superbloom,
			SPELLS.rapidStrike,
			SPELLS.steamBath,
			SPELLS.ballLightning,
			SPELLS.arcBlast,
			SPELLS.landslide,
			SPELLS.destructiveBlow,
			SPELLS.creciasCrystalSpikes,
			SPELLS.deflectiveShield,
			SPELLS.creciasCrystalWind,
			SPELLS.cloudBreak,
			SPELLS.broadcastData,
			SPELLS.expandTime
		);
	#endregion
	
	#region		STEWARDRAKE
		var stewardrakeSpells = ds_list_create();
		
		ds_list_add(stewardrakeSpells,
			SPELLS.solarFlare,
			SPELLS.nebulaStorm,
			SPELLS.holyWater,
			SPELLS.shock,
			SPELLS.expelForce,
			SPELLS.ladySolanusGrace,
			SPELLS.typhoon,
			SPELLS.healingLight,
			SPELLS.empathize,
			SPELLS.pyrokinesis,
			SPELLS.amandsEnergyBlast,
			SPELLS.skydive,
			SPELLS.purifyingFlame,
			SPELLS.jabulsFightSong,
			SPELLS.deflectiveShield,
			SPELLS.windSlice,
			SPELLS.channelEssence,
			SPELLS.creciasCrystalWind,
			SPELLS.cloudBreak
		);
	#endregion
	
	#region		DOORMAUS
		var doormausSpells = ds_list_create();
		
		ds_list_add(doormausSpells,
			SPELLS.expelForce,
			SPELLS.ladySolanusGrace,
			SPELLS.healingLight,
			SPELLS.lusiasHarvestSpell,
			SPELLS.rapidStrike,
			SPELLS.intercept,
			SPELLS.amandsEnergyBlast,
			SPELLS.psychicImpact,
			SPELLS.psychicFissure,
			SPELLS.rearrange,
			SPELLS.sneakAttack,
			SPELLS.channelEssence,
			SPELLS.telekineticBlast,
			SPELLS.broadcastData,
			SPELLS.collapseSpace,
		);
	#endregion
	
	#region		PLASMASS
		var plasmassSpells = ds_list_create();
		
		ds_list_add(plasmassSpells,
			SPELLS.fireball,
			SPELLS.shock,
			SPELLS.expelForce,
			SPELLS.ruburs_grapple,
			SPELLS.airPressure,
			SPELLS.rapidStrike,
			SPELLS.intercept,
			SPELLS.ballLightning,
			SPELLS.arcBlast,
			SPELLS.amandsEnergyBlast,
			SPELLS.noxiousFumes,
			SPELLS.deflectiveShield,
			SPELLS.magneticPulse,
			SPELLS.burnOut,
			SPELLS.destabilizingBlow,
			SPELLS.fullThrust,
		);
	#endregion
	
	#region		SHREDATOR
		var shredatorSpells = ds_list_create();
		
		ds_list_add(shredatorSpells,
			SPELLS.tidalForce,
			SPELLS.typhoon,
			SPELLS.rubursWaterCannon,
			SPELLS.ruburs_grapple,
			SPELLS.rapidStrike,
			SPELLS.intercept,
			SPELLS.undertow,
			SPELLS.downpour,
			SPELLS.sneakAttack,
			SPELLS.endlessRiver,
			SPELLS.fullThrust
		);
	#endregion
	
	#region		JACKHAMMER
		var jackhammerSpells = ds_list_create();
		
		ds_list_add(jackhammerSpells,
			SPELLS.shock,
			SPELLS.expelForce,
			SPELLS.rapidStrike,
			SPELLS.loomingDanger,
			SPELLS.hellfire,
			SPELLS.lordMogradthsRage,
			SPELLS.pyrokinesis,
			SPELLS.arcBlast,
			SPELLS.amandsEnergyBlast,
			SPELLS.psychicImpact,
			SPELLS.destructiveBlow,
			SPELLS.jabulsFightSong,
			SPELLS.noxiousFumes,
			SPELLS.psychicFissure,
			SPELLS.sneakAttack,
			SPELLS.deflectiveShield,
			SPELLS.dionsGamblingBlast,
			SPELLS.magneticPulse,
			SPELLS.fullThrust,
			SPELLS.spherasDemise
		);
	#endregion
	
	#region		STINKLOPS
		var stinklopsSpells = ds_list_create();
		
		ds_list_add(stinklopsSpells,
			SPELLS.fireball,
			SPELLS.decay,
			SPELLS.rubursGrapple,
			SPELLS.loomingDanger,
			SPELLS.intercept,
			SPELLS.hellfire,
			SPELLS.quicksand,
			SPELLS.pyrokinesis,
			SPELLS.landslide,
			SPELLS.tremor,
			SPELLS.destructiveBlow,
			SPELLS.jabulsFightSong,
			SPELLS.noxiousFumes,
			SPELLS.stinkbomb,
			SPELLS.spherasCurse,
			SPELLS.cloudBreak,
			SPELLS.fullThrust,
			SPELLS.destabilizingBlow,
		);
	#endregion
	
	#region		DURENDOUX
		var durendouxSpells = ds_list_create();
		
		ds_list_add(durendouxSpells,
			SPELLS.tectonicShift,
			SPELLS.holyWater,
			SPELLS.decay,
			SPELLS.expelForce,
			SPELLS.ladySolanusGrace,
			SPELLS.healingLight,
			SPELLS.quicksand,
			SPELLS.landslide,
			SPELLS.tremor,
			SPELLS.creciasCrystalSpikes,
			SPELLS.deflectiveShield,
			SPELLS.channelEssence,
			SPELLS.spherasCurse
		);
	#endregion
	
	#region		CENOTOMB
		var cenotombSpells = ds_list_create();
		
		ds_list_add(cenotombSpells,
			SPELLS.fireball,
			SPELLS.decay,
			SPELLS.expelForce,
			SPELLS.loomingDanger,
			SPELLS.hellfire,
			SPELLS.lordMogradthsRage,
			SPELLS.drainLifeforce,
			SPELLS.pyrokinesis,
			SPELLS.arcBlast,
			SPELLS.hikamsWinterSpell,
			SPELLS.flashFreeze,
			SPELLS.amandsEnergyBlast,
			SPELLS.shiftPerspective,
			SPELLS.psychicImpact,
			SPELLS.noxiousFumes,
			SPELLS.creciasCrystalSpikes,
			SPELLS.psychicFissure,
			SPELLS.sneakAttack,
			SPELLS.deflectiveShield,
			SPELLS.creciasCrystalWind,
			SPELLS.telekineticBlast,
			SPELLS.collapseSpace,
			SPELLS.expandTime,
			SPELLS.spherasDemise
		);
	#endregion
	
	#region		CLEANSAGE
		var cleansageSpells = ds_list_create();
		
		ds_list_add(cleansageSpells,
			SPELLS.fireball,
			SPELLS.decay,
			SPELLS.expelForce,
			SPELLS.ladySolanusGrace,
			SPELLS.typhoon,
			SPELLS.healingLight,
			SPELLS.lusiasHarvestSpell,
			SPELLS.airPressure,
			SPELLS.superbloom,
			SPELLS.intercept,
			SPELLS.steamBath,
			SPELLS.empathize,
			SPELLS.drainLifeforce,
			SPELLS.shiftPerspective,
			SPELLS.purifyingFlame,
			SPELLS.noxiousFumes,
			SPELLS.burnOut,
			SPELLS.stinkbomb,
			SPELLS.windSlice,
			SPELLS.channelEssence,
			SPELLS.spherasCurse,
			SPELLS.creciasCrystalWind,
			SPELLS.expandTime
		);
	#endregion
	
	#region		WYRMPOOL
		var wyrmpoolSpells = ds_list_create();
		
		ds_list_add(wyrmpoolSpells,
			SPELLS.tidalForce,
			SPELLS.typhoon,
			SPELLS.rubursWaterCannon,
			SPELLS.waterlog,
			SPELLS.airPressure,
			SPELLS.undertow,
			SPELLS.downpour,
			SPELLS.flashFreeze,
			SPELLS.landslide,
			SPELLS.tremor,
			SPELLS.endlessRiver,
			SPELLS.cloudBreak
		);
	#endregion
	
	#region		CRAGMA
		var cragmaSpells = ds_list_create();
		
		ds_list_add(cragmaSpells,
			SPELLS.tectonicShift,
			SPELLS.fireball,
			SPELLS.hellfire,
			SPELLS.landslide,
			SPELLS.tremor,
			SPELLS.noxiousFumes,
			SPELLS.creciasCrystalSpikes,
			SPELLS.burnOut,
			SPELLS.stinkbomb,
			SPELLS.lavaSpire
		);
	#endregion
	
	#region		CORVOLT
		var corvoltSpells = ds_list_create();
		
		ds_list_add(corvoltSpells,
			SPELLS.nebulaStorm,
			SPELLS.shock,
			SPELLS.typhoon,
			SPELLS.rubursWaterCannon,
			SPELLS.airPressure,
			SPELLS.ballLightning,
			SPELLS.downpour,
			SPELLS.arcBlast,
			SPELLS.skydive,
			SPELLS.windSlice,
			SPELLS.cloudBreak
		);
	#endregion
	
	#region		CHROMOSILOS
		var chromosilosSpells = ds_list_create();
		
		ds_list_add(chromosilosSpells,
			SPELLS.tectonicShift,
			SPELLS.fireball,
			SPELLS.shock,
			SPELLS.loomingDanger,
			SPELLS.hellfire,
			SPELLS.arcBlast,
			SPELLS.landslide,
			SPELLS.tremor,
			SPELLS.destructiveBlow,
			SPELLS.deflectiveShield,
			SPELLS.burnOut,
			SPELLS.lavaSpire,
			SPELLS.fullThrust
		);
	#endregion
	
	#region		DOMINO
		var dominoSpells = ds_list_create();
		
		ds_list_add(dominoSpells,
			SPELLS.fireball,
			SPELLS.shock,
			SPELLS.decay,
			SPELLS.expelForce,
			SPELLS.rapidStrike,
			SPELLS.loomingDanger,
			SPELLS.intercept,
			SPELLS.hellfire,
			SPELLS.lordMogradthsRage,
			SPELLS.drainLifeforce,
			SPELLS.pyrokinesis,
			SPELLS.arcBlast,
			SPELLS.amandsEnergyBlast,
			SPELLS.shiftPerspective,
			SPELLS.psychicImpact,
			SPELLS.destructiveBlow,
			SPELLS.jabulsFightSong,
			SPELLS.noxiousFumes,
			SPELLS.psychicFissure,
			SPELLS.rearrange,
			SPELLS.sneakAttack,
			SPELLS.deflectiveShield,
			SPELLS.dionsParry,
			SPELLS.dionsGamblingBlast,
			SPELLS.dionsBarterTrick,
			SPELLS.fullThrust,
			SPELLS.broadcastData,
			SPELLS.spherasDemise
		);
	#endregion
	
	#region		ANACHRONAUT
		var anachronautSpells = ds_list_create();
		
		ds_list_add(anachronautSpells,
			SPELLS.solarFlare,
			SPELLS.tidalForce,
			SPELLS.nebulaStorm,
			SPELLS.tectonicShift,
			SPELLS.shock,
			SPELLS.decay,
			SPELLS.expelForce,
			SPELLS.ladySolanusGrace,
			SPELLS.healingLight,
			SPELLS.amandsEnergyBlast,
			SPELLS.psychicImpact,
			SPELLS.psychicFissure,
			SPELLS.deflectiveShield,
			SPELLS.magneticPulse,
			SPELLS.endlessRiver,
			SPELLS.telekineticBlast,
			SPELLS.broadcastData,
			SPELLS.expandTime,
			SPELLS.spherasDemise
		);
	#endregion
	
	#region		OMNOST
		var omnostSpells = ds_list_create();
		
		ds_list_add(omnostSpells,
			SPELLS.solarFlare,
			SPELLS.tidalForce,
			SPELLS.nebulaStorm,
			SPELLS.tectonicShift,
			SPELLS.fireball,
			SPELLS.holyWater,
			SPELLS.shock,
			SPELLS.decay,
			SPELLS.expelForce,
			SPELLS.ladySolanusGrace,
			SPELLS.typhoon,
			SPELLS.healingLight,
			SPELLS.rubursWaterCannon,
			SPELLS.lusiasHarvestSpell,
			SPELLS.waterlog,
			SPELLS.airPressure,
			SPELLS.superbloom,
			SPELLS.loomingDanger,
			SPELLS.steamBath,
			SPELLS.undertow,
			SPELLS.hellfire,
			SPELLS.ballLightning,
			SPELLS.quicksand,
			SPELLS.lordMogradthsRage,
			SPELLS.pyrokinesis,
			SPELLS.downpour,
			SPELLS.arcBlast,
			SPELLS.hikamsWinterSpell,
			SPELLS.osmosis,
			SPELLS.flashFreeze,
			SPELLS.landslide,
			SPELLS.amandsEnergyBlast,
			SPELLS.shiftPerspective,
			SPELLS.psychicImpact,
			SPELLS.tremor,
			SPELLS.purifyingFlame,
			SPELLS.noxiousFumes,
			SPELLS.creciasCrystalSpikes,
			SPELLS.psychicFissure,
			SPELLS.rearrange,
			SPELLS.deflectiveShield,
			SPELLS.dionsGamblingBlast,
			SPELLS.dionsBarterTrick,
			SPELLS.magneticPulse,
			SPELLS.burnOut,
			SPELLS.stinkbomb,
			SPELLS.windSlice,
			SPELLS.channelEssence,
			SPELLS.spherasCurse,
			SPELLS.creciasCrystalWind,
			SPELLS.lavaSpire,
			SPELLS.endlessRiver,
			SPELLS.cloudBreak,
			SPELLS.broadcastData
		);
	#endregion
	
	#region		PRISMATTER
		var prismatterSpells = ds_list_create();
		
		ds_list_add(prismatterSpells,
			SPELLS.solarFlare,
			SPELLS.tidalForce,
			SPELLS.nebulaStorm,
			SPELLS.tectonicShift,
			SPELLS.rubursGrapple,
			SPELLS.lusiasHarvestSpell,
			SPELLS.airPressure,
			SPELLS.superbloom,
			SPELLS.rapidStrike,
			SPELLS.intercept,
			SPELLS.undertow,
			SPELLS.quicksand,
			SPELLS.hikamsWinterSpell,
			SPELLS.landslide,
			SPELLS.tremor,
			SPELLS.destructiveBlow,
			SPELLS.creciasCrystalSpikes,
			SPELLS.rearrange,
			SPELLS.deflectiveShield,
			SPELLS.dionsParry,
			SPELLS.magneticPulse,
			SPELLS.burnOut,
			SPELLS.windSlice,
			SPELLS.creciasCrystalWind,
			SPELLS.lavaSpire,
			SPELLS.endlessRiver,
			SPELLS.cloudBreak,
			SPELLS.telekineticBlast,
			SPELLS.destabilizingBlow,
			SPELLS.fullThrust,
			SPELLS.collapseSpace
		);
	#endregion
	
	#region		KRONARC
		var kronarcSpells = ds_list_create();
		
		ds_list_add(kronarcSpells,
			SPELLS.solarFlare,
			SPELLS.tidalForce,
			SPELLS.nebulaStorm,
			SPELLS.tectonicShift,
			SPELLS.holyWater,
			SPELLS.shock,
			SPELLS.decay,
			SPELLS.expelForce,
			SPELLS.lusiasHarvestSpell,
			SPELLS.superbloom,
			SPELLS.loomingDanger,
			SPELLS.intercept,
			SPELLS.hikamsWinterSpell,
			SPELLS.amandsEnergyBlast,
			SPELLS.psychicImpact,
			SPELLS.tremor,
			SPELLS.psychicFissure,
			SPELLS.deflectiveShield,
			SPELLS.magneticPulse,
			SPELLS.windSlice,
			SPELLS.channelEssence,
			SPELLS.spherasCurse,
			SPELLS.lavaSpire,
			SPELLS.endlessRiver,
			SPELLS.telekineticBlast,
			SPELLS.expandTime,
			SPELLS.spherasDemise
		);
			
	#endregion
	
	#region		COSMALCOS
		var cosmalcosSpells = ds_list_create();
		
		ds_list_add(cosmalcosSpells,
			SPELLS.holyWater,
			SPELLS.decay,
			SPELLS.expelForce,
			SPELLS.superbloom,
			SPELLS.loomingDanger,
			SPELLS.hellfire,
			SPELLS.lordMogradthsRage,
			SPELLS.drainLifeforce,
			SPELLS.drainLifeforce,
			SPELLS.hikamsWinterSpell,
			SPELLS.amandsEnergyBlast,
			SPELLS.psychicImpact,
			SPELLS.destructiveBlow,
			SPELLS.noxiousFumes,
			SPELLS.psychicFissure,
			SPELLS.deflectiveShield,
			SPELLS.dionsParry,
			SPELLS.dionsBarterTrick,
			SPELLS.stinkbomb,
			SPELLS.channelEssence,
			SPELLS.spherasCurse,
			SPELLS.telekineticBlast,
			SPELLS.spherasDemise
		);
	#endregion

#endregion

#region CREATE SPRITE GRID

global.spriteGrid = ds_grid_create(SPRITE_PARAMS.height, SPRITES.height);

function sprite_add_to_grid(_ID) {
	var i = 0; repeat (SPRITE_PARAMS.height) {
		ds_grid_add(global.spriteGrid, i, _ID, argument[i]);
		
		i++;
	}
}
	
#region ALL SPRITE DATA
//					ID						NAME										ALIGNMENT				USABLE SPELLS						POWER	RES		FIRE	WATER	STORM	EARTH	AGL		LUCK	SIZE
sprite_add_to_grid(SPRITES.gembo,			"GEMBO",			spr_gemboBattle,		ALIGNMENTS.astral,		encode_list(gemboSpells),			120,	120,	115,	100,	115,	100,	70,		90,		spriteSizes.medium);
sprite_add_to_grid(SPRITES.pondile,			"PONDILE",			spr_pondileBattle,		ALIGNMENTS.natural,		encode_list(pondileSpells),			110,	75,		70,		140,	90,		90,		130,	80,		spriteSizes.medium);
sprite_add_to_grid(SPRITES.hachaChacha,		"HACHA-CHACHA",		spr_hachaChachaBattle,	ALIGNMENTS.natural,		encode_list(hachaSpells),			80,		50,		190,	35,		70,		110,	90,		150,	spriteSizes.small);
sprite_add_to_grid(SPRITES.podric,			"PODRIC",			spr_podricBattle,		ALIGNMENTS.natural,		encode_list(podricSpells),			165,	70,		30,		90,		40,		180,	160,	100,	spriteSizes.small);
sprite_add_to_grid(SPRITES.needlepaw,		"NEEDLEPAW",		spr_needlepawBattle,	ALIGNMENTS.astral,		encode_list(needlepawSpells),		130,	70,		110,	55,		130,	110,	180,	50,		spriteSizes.small);
sprite_add_to_grid(SPRITES.sudsy,			"SUDSY",			spr_sudsyBattle,		ALIGNMENTS.mechanical,	encode_list(sudsySpells),			60,		70,		60,		150,	60,		60,		170,	150,	spriteSizes.xSmall);
sprite_add_to_grid(SPRITES.bookish,			"BOOKISH",			spr_bookishBattle,		ALIGNMENTS.mechanical,	encode_list(bookishSpells),			50,		50,		120,	120,	120,	120,	80,		90,		spriteSizes.xSmall);
sprite_add_to_grid(SPRITES.pleep,			"PLEEP",			spr_pleepBattle,		ALIGNMENTS.astral,		encode_list(pleepSpells),			110,	80,		100,	70,		150,	50,		100,	100,	spriteSizes.small);
sprite_add_to_grid(SPRITES.glidrake,		"GLIDRAKE",			spr_glidrakeBattle,		ALIGNMENTS.natural,		encode_list(glidrakeSpells),		100,	60,		110,	80,		160,	50,		150,	90,		spriteSizes.medium);
sprite_add_to_grid(SPRITES.furvor,			"FURVOR",			spr_furvorBattle,		ALIGNMENTS.natural,		encode_list(furvorSpells),			140,	90,		110,	55,		85,		110,	130,	80,		spriteSizes.small);
sprite_add_to_grid(SPRITES.zephira,			"ZEPHIRA",			spr_zephiraBattle,		ALIGNMENTS.astral,		encode_list(zephiraSpells),			100,	60,		70,		90,		160,	110,	140,	100,	spriteSizes.xSmall);
sprite_add_to_grid(SPRITES.fishmonger,		"FISHMONGER",		spr_fishmongerBattle,	ALIGNMENTS.natural,		encode_list(fishmongerSpells),		150,	130,	70,		150,	90,		80,		85,		80,		spriteSizes.medium);
sprite_add_to_grid(SPRITES.songbird,		"SONGBIRD",			spr_songbirdBattle,		ALIGNMENTS.astral,		encode_list(songbirdSpells),		70,		90,		80,		90,		125,	100,	120,	150,	spriteSizes.medium);
sprite_add_to_grid(SPRITES.exonolith,		"EXONOLITH",		spr_exonolithBattle,	ALIGNMENTS.astral,		encode_list(exonolithSpells),		100,	190,	90,		60,		90,		140,	50,		100,	spriteSizes.large);
sprite_add_to_grid(SPRITES.drumline,		"DRUMLINE",			spr_drumlineBattle,		ALIGNMENTS.mechanical,	encode_list(drumlineSpells),		80,		145,	75,		75,		90,		100,	120,	150,	spriteSizes.small);
sprite_add_to_grid(SPRITES.mirrefract,		"MIRREFRACT",		spr_mirrefractBattle,	ALIGNMENTS.mechanical,	encode_list(mirrefractSpells),		100,	130,	90,		60,		120,	130,	110,	85,		spriteSizes.medium);
sprite_add_to_grid(SPRITES.fortuga,			"FORTUGA",			spr_fortugaBattle,		ALIGNMENTS.natural,		encode_list(fortugaSpells),			100,	180,	65,		130,	65,		130,	60,		100,	spriteSizes.xLarge);
sprite_add_to_grid(SPRITES.tikdof,			"TIKDOF",			spr_tikdoffBattle,		ALIGNMENTS.mechanical,	encode_list(tikdoffSpells),			145,	95,		190,	40,		80,		70,		120,	85,		spriteSizes.large);
sprite_add_to_grid(SPRITES.arraynge,		"ARRAYNGE",			spr_arrayngeBattle,		ALIGNMENTS.mechanical,	encode_list(arrayngeSpells),		65,		85,		100,	90,		150,	90,		115,	100,	spriteSizes.small);
sprite_add_to_grid(SPRITES.scrootineyes,	"SCROOTINEYES",		spr_scrootineyesBattle,	ALIGNMENTS.natural,		encode_list(scrootineyesSpells),	110,	100,	70,		70,		130,	70,		70,		120,	spriteSizes.large);
sprite_add_to_grid(SPRITES.joe,				"JOE",				spr_joeBattle,			ALIGNMENTS.mechanical,	encode_list(joeSpells),				160,	115,	110,	110,	70,		85,		100,	85,		spriteSizes.large);
sprite_add_to_grid(SPRITES.canuki,			"CANUKI",			spr_canukiBattle,		ALIGNMENTS.natural,		encode_list(canukiSpells),			145,	165,	70,		70,		70,		140,	80,		85,		spriteSizes.large);
sprite_add_to_grid(SPRITES.gastronimo,		"GASTRONIMO",		spr_gastronimoBattle,	ALIGNMENTS.mechanical,	encode_list(gastronimoSpells),		140,	140,	100,	100,	70,		120,	60,		100,	spriteSizes.large);
sprite_add_to_grid(SPRITES.flotsu,			"FLOTSU",			spr_flotsuBattle,		ALIGNMENTS.natural,		encode_list(flotsuSpells),			90,		135,	50,		180,	120,	100,	60,		100,	spriteSizes.large);
sprite_add_to_grid(SPRITES.blitzkrane,		"BLITZKRANE",		spr_blitzkraneBattle,	ALIGNMENTS.astral,		encode_list(blitzkraneSpells),		140,	90,		60,		100,	165,	70,		135,	75,		spriteSizes.xLarge);
sprite_add_to_grid(SPRITES.heatsune,		"HEATSUNE",			spr_heatsuneBattle,		ALIGNMENTS.astral,		encode_list(heatsuneSpells),		110,	70,		170,	50,		115,	100,	135,	85,		spriteSizes.medium);
sprite_add_to_grid(SPRITES.floopwalker,		"FLOOPWALKER",		spr_floopwalkerBattle,	ALIGNMENTS.astral,		encode_list(floopwalkerSpells),		65,		100,	90,		90,		120,	120,	120,	125,	spriteSizes.small);
sprite_add_to_grid(SPRITES.stewardrake,		"STEWARDRAKE",		spr_stewardrakeBattle,	ALIGNMENTS.astral,		encode_list(stewardrakeSpells),		65,		140,	120,	90,		120,	90,		100,	100,	spriteSizes.medium);
sprite_add_to_grid(SPRITES.doormaus,		"DOORMAUS",			spr_doormausBattle,		ALIGNMENTS.astral,		encode_list(doormausSpells),		50,		85,		110,	110,	110,	110,	160,	100,	spriteSizes.small);
sprite_add_to_grid(SPRITES.plasmass,		"PLASMASS",			spr_plasmassBattle,		ALIGNMENTS.mechanical,	encode_list(plasmassSpells),		130,	100,	120,	45,		180,	45,		165,	50,		spriteSizes.large);
sprite_add_to_grid(SPRITES.shredator,		"SHREDATOR",		spr_shredatorBattle,	ALIGNMENTS.natural,		encode_list(shredatorSpells),		170,	110,	45,		165,	80,		60,		130,	75,		spriteSizes.large);
sprite_add_to_grid(SPRITES.jackhammer,		"JACKHAMMER",		spr_jackhammerBattle,	ALIGNMENTS.astral,		encode_list(jackhammerSpells),		160,	120,	35,		60,		70,		80,		160,	150,	spriteSizes.small);
sprite_add_to_grid(SPRITES.stinklops,		"STINKLOPS",		spr_stinklopsBattle,	ALIGNMENTS.natural,		encode_list(stinklopsSpells),		190,	135,	110,	70,		80,		125,	90,		35,		spriteSizes.large);
sprite_add_to_grid(SPRITES.durendoux,		"DURENDOUX",		spr_durendouxBattle,	ALIGNMENTS.astral,		encode_list(durendouxSpells),		135,	185,	80,		40,		40,		160,	45,		150,	spriteSizes.medium);
sprite_add_to_grid(SPRITES.cenotomb,		"CENOTOMB",			spr_cenotombBattle,		ALIGNMENTS.astral,		encode_list(cenotombSpells),		150,	120,	120,	60,		90,		90,		90,		100,	spriteSizes.large);
sprite_add_to_grid(SPRITES.cleansage,		"CLEANSAGE",		spr_cleansageBattle,	ALIGNMENTS.astral,		encode_list(cleansageSpells),		90,		140,	120,	70,		90,		140,	35,		80,		spriteSizes.large);
sprite_add_to_grid(SPRITES.wyrmpool,		"WYRMPOOL",			spr_wyrmpoolBattle,		ALIGNMENTS.astral,		encode_list(wyrmpoolSpells),		130,	120,	35,		170,	140,	35,		80,		125,	spriteSizes.xLarge);
sprite_add_to_grid(SPRITES.cragma,			"CRAGMA",			spr_cragmaBattle,		ALIGNMENTS.natural,		encode_list(cragmaSpells),			170,	150,	170,	30,		30,		150,	35,		100,	spriteSizes.large);
sprite_add_to_grid(SPRITES.corvolt,			"CORVOLT",			spr_corvoltBattle,		ALIGNMENTS.natural,		encode_list(corvoltSpells),			120,	130,	60,		120,	140,	60,		110,	100,	spriteSizes.large);
sprite_add_to_grid(SPRITES.chromosilos,		"CHROMOSILOS",		spr_chromosilosBattle,	ALIGNMENTS.mechanical,	encode_list(chromosilosSpells),		190,	140,	120,	40,		40,		160,	70,		75,		spriteSizes.xLarge);
sprite_add_to_grid(SPRITES.domino,			"DOMINO",			spr_dominoBattle,		ALIGNMENTS.mechanical,	encode_list(dominoSpells),			135,	70,		85,		85,		85,		85,		140,	150,	spriteSizes.small);
sprite_add_to_grid(SPRITES.anachronaut,		"ANACHRONAUT",		spr_anachronautBattle,	ALIGNMENTS.mechanical,	encode_list(anachronautSpells),		35,		60,		120,	120,	120,	120,	160,	100,	spriteSizes.small);
sprite_add_to_grid(SPRITES.omnost,			"OMNOST",			spr_omnostBattle,		-1,						encode_list(omnostSpells),			50,		100,	110,	110,	150,	110,	70,		150,	spriteSizes.xLarge);
sprite_add_to_grid(SPRITES.prismatter,		"PRISMATTER",		spr_prismatterBattle,	-1,						encode_list(prismatterSpells),		175,	175,	80,		80,		80,		150,	75,		35,		spriteSizes.xLarge);
sprite_add_to_grid(SPRITES.kronarc,			"KRONARC",			spr_kronarcBattle,		-1,						encode_list(kronarcSpells),			100,	100,	100,	100,	100,	100,	100,	150,	spriteSizes.xLarge);
sprite_add_to_grid(SPRITES.cosmalcos,		"COSMALCOS",		spr_cosmalcosBattle,	-1,						encode_list(cosmalcosSpells),		120,	180,	30,		30,		30,		30,		30,		150,	spriteSizes.xLarge);

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
	// decode sprite grid
	var grid = ds_grid_create(SPRITE_PARAMS.height, SPRITES.height);
	decode_grid(global.allSprites, grid);
	
	// use sprite grid to get parameters
	name				= grid[# SPRITE_PARAMS.name,			spriteID];
	sprite				= real(grid[# SPRITE_PARAMS.sprite,		spriteID]);
	baseAlign			= real(grid[# SPRITE_PARAMS.alignment,	spriteID]);
	var spellString		= grid[# SPRITE_PARAMS.spells,			spriteID];
	basePower			= real(grid[# SPRITE_PARAMS.power,		spriteID]);
	baseResistance		= real(grid[# SPRITE_PARAMS.resistance,	spriteID]);
	baseFire			= real(grid[# SPRITE_PARAMS.fire,		spriteID]);
	baseWater			= real(grid[# SPRITE_PARAMS.water,		spriteID]);
	baseStorm			= real(grid[# SPRITE_PARAMS.storm,		spriteID]);
	baseEarth			= real(grid[# SPRITE_PARAMS.earth,		spriteID]);
	baseAgility			= real(grid[# SPRITE_PARAMS.agility,	spriteID]);
	baseLuck			= real(grid[# SPRITE_PARAMS.luck,		spriteID]);
	baseSize			= real(grid[# SPRITE_PARAMS.size,		spriteID]);
	
	// decode spell list
	decode_list(spellString, usable_spells);
	
	// delete sprite grid
	ds_grid_destroy(grid);
}

function sprite_get_alignment_string(_alignment) {
	var a = _alignment;
	
	switch (a) {
		case ALIGNMENTS.astral:		return "ASTRAL";
		case ALIGNMENTS.mechanical:	return "MECHANICAL";
		case ALIGNMENTS.natural:	return "NATURAL";
	}
}

function sprite_get_size_string(_size) {
	var s = _size;
	
	switch (s) {
		case spriteSizes.xSmall:	return "X-SMALL";
		case spriteSizes.small:		return "SMALL";
		case spriteSizes.medium:	return "MEDIUM";
		case spriteSizes.large:		return "LARGE";
		case spriteSizes.xLarge:	return "X-LARGE";
	}
}
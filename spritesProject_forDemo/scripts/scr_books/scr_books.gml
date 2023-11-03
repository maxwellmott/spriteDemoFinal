enum books {
	inhumanEntities,
	twmFirstEdition,
	twmSecondEdition,
	twmThirdEdition,
	sparmastersHandbook,
	illuminiad,							//high level magic book
	sacriLibriI,						//the standard book for learning magic
	sacriLibriII,
	sacriLibriIII,
	sacriLibriIV,
	sacriLibriV,
	epicOfTheAeons,						//genesis
	phremnsBirth,
	astralDoctrine,						//bible
	threeWitchesGrimoireVol1,
	threeWitchesGrimoireVol2,
	threeWitchesGrimoireVol3,
	cosmicTreatise,
	knightsOfAlcompasVol1,
	knightsOfAlcompasVol2,
	knightsOfAlcompasVol3,
	aBookOnSprites1,
	aBookOnSprites2,
	aBookOnSprites3,
	height
}

enum bookParams {
	ID,
	title,
	author,
	text,
	font,
	background,
	trigger,
	height
}

enum bookcaseTypes {
	standardWood1,
	height
}

enum bookcaseParams {
	ID,
	type,
	facing,
	_x,
	_y,
	bookList,
	height
}
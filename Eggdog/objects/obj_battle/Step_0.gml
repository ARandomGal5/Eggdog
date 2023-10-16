//Yes I made an accurate deltarune battle system for a single level why do you ask?
//Checks if you're selecting moves.
if turn < 2 {
//If a soul object exists destroy it.
if instance_exists(obj_soul) instance_destroy(obj_soul);
//Checks that you are not selecting a button.
if select == 0 {
//Checks for left input and if you are not selecting the very left button, move the selection left and play the selction move sound.
	if input_pressed(global.left) == -1 && button[turn] > 0 {
		button[turn] -= 1;
		audio_play_sound(snd_encounterMove, 1, false);
	}
	////Checks for right input and if you are not selecting the very right button, move the selection right and play the selction move sound.
	if input_pressed(global.right) == 1 && button[turn] < 4 {
		button[turn] += 1;
		audio_play_sound(snd_encounterMove, 1, false);
	}
}

//Checks if you press select.
if input_pressed(global.jump) {
	//Sets what button you selected (0 is none so it adds one to the button.)
	select = button[turn] + 1;
	//Play the selection button.
	audio_play_sound(snd_encounterSelect, 1, false);
}

//Checks if you press back after selecting a button.
if input_pressed(global.back) && select != 0 {
	//Resets your selection to 0 (not selecting anything).
	select = 0
	//Makes it so that you are no longer selecting specific acts.
	actselect = false;
	//Makes it so that you are no longer selecting which party member to use an item on.
	itemselect = false;
	//Resets what act you were hovering over.
	actx = 0;
	acty = 0;
	//Plays the selection move sound effect.
	audio_play_sound(snd_encounterMove, 1, false);
}

//Checks if you selected the attack button.
if select == 1 {
	//If you press jump and at least one frame has passed since you pressed the attack button (so this doesn't happen on the same frame/input) select the enemy.
	if input_pressed(global.jump) && selecttime[0] >= 1 {
		//Set the action for this turn to 1 (attacking).
		action[turn] = 1;
		//Causes the box to smoothly go down instead of snapping.
		yoffset[turn] = 64;
		yoffset[turn + 1] = -64;
		partyoffset[1] = 64;
		partyoffset[0] = -64;
		//Resets what button you are selecting to none.
		select = 0;
		//Goes to the next turn.
		turn += 1;
	}
	selecttime[0] += 1;
} else selecttime[0] = 0;

if select == 2 {
	if input_pressed(global.jump) && selecttime[1] >= 1 && actselect == false {
		actselect = true
		selecttime[1] = 0;
	}
	if actselect = true {
		if input_pressed(global.left) == 1 && actx < 1 && acty == 0 actx += 1;
		if input_pressed(global.left) == -1 && actx > 0 && acty == 0 actx -= 1;
		if input_pressed(global.down) == 1 && acty < 1 && actx == 0 acty += 1;
		if input_pressed(global.down) == -1 && acty > 0 acty -= 1;
		if input_pressed(global.jump) && selecttime[1] >= 1 {
			//Saves what action you selected.
			action[turn] = 2;
			//Saves what act you used.
			if actx == 0 && acty == 0 act[turn] = 0;
			if actx == 1 && acty == 0 act[turn] = 1;
			if actx == 0 && acty == 1 act[turn] = 2;
			//Causes the box to smoothly go down instead of snapping.
			yoffset[turn] = 64;
			yoffset[turn + 1] = -64;
			select = 0;
			turn += 1;
		}
	}
	selecttime[1] += 1;
} else selecttime[1] = 0;

//Checks if you selected the item button.
if select == 3 {
	if itemselect = false {
		if input_pressed(global.left) == 1 && itemx < 1 itemx += 1;
		if input_pressed(global.left) == -1 && itemx > 0 itemx -= 1;
		if input_pressed(global.down) == 1 && itemy < 2 itemy += 1;
		if input_pressed(global.down) == -1 && itemy > 0 itemy -= 1;
		if input_pressed(global.jump) && selecttime[2] >= 1 {
			//Saves what item you use.
			if actx == 0 && acty == 0 itemuse[turn] = 0;
			if actx == 1 && acty == 0 itemuse[turn] = 1;
			if actx == 0 && acty == 1 itemuse[turn] = 2;
			if actx == 1 && acty == 1 itemuse[turn] = 3;
			if actx == 0 && acty == 2 itemuse[turn] = 4;
			if actx == 1 && acty == 2 itemuse[turn] = 5;
			//Resets what row you are selecting.
			itemy = 0;
			//Sets it so that you are selecting which party member to use the item on.
			itemselect = true;
		}
	} else {
		if input_pressed(global.down) == 1 && itemy < 1 itemy += 1;
		if input_pressed(global.down) == -1 && itemy > 0 itemy -= 1;
		if input_pressed(global.jump) && selecttime[2] >= 1 {
			//Saves what action you selected.
			action[turn] = 3;
			//Saves what party member you used the item on.
			if itemy = 0 itemmember[turn] = 0 else itemmember[turn] = 1;
			//Causes the box to smoothly go down instead of snapping.
			yoffset[turn] = 64;
			yoffset[turn + 1] = -64;
			//Makes it so you are no longer selecting a party member to use an item on.
			itemselect = false;
			select = 0;
			turn += 1;
		}
	}
	selecttime[2] += 1;
} else selecttime[2] = 0;
//Checks if you spare.
if select == 4 {
	if input_pressed(global.jump) && selecttime[3] >= 1 {
		//Saves what action you selected.
		action[turn] = 4;
		//Causes the box to smoothly go down instead of snapping.
		yoffset[turn] = 64;
		yoffset[turn + 1] = -64;
		select = 0;
		turn += 1;
	}
	selecttime[3] += 1;	
} else selecttime[3] = 0;
//Checks if you defend.
if select == 5 {
	//Increases your TP by 20.
	tp += 16;
	//Creates the 'tallying' effect for the TP.
	tpup = 16;
	//Remembers what you selected
	action[turn] = 5;
	//Resets what button you selected.
	select = 0;
	//Causes the box to smoothly go down instead of snapping.
	yoffset[turn] = 64;
	yoffset[turn + 1] = -64;
	partyoffset[turn] = 64;
	partyoffset[turn + 1] = -64;
	//Increaes your turn by 1.
	turn += 1;
}

if sign(tpup) = 1 {
	if tpup >= 8 tpup -= 8 else tpup = 0;
} else {
	if tpup <= -8 tpup += 8 else tpup = 0;
}

if turn == 2 {
	if stateset == true {
		if action[0] != 1 && action[0] != 5 && action[1] != 1 && action[1] != 5 {
			state = 4;
		} else if (action[0] != 1 && action[0] != 5 && (action[1] == 1 || action[1] == 5) || action[1] != 1 && action[1] != 5 && (action[0] == 1 || action[0] == 5)) {
			state = 3;
		} else if action[0] == 1 || action[1] == 1 {
			state = 2;	
		} else state = 1;
		firststate = state;
		stateset = false;
	}
} else stateset = true;

//Checks if you go back a turn
if input_pressed(global.back) && turn == 1 && select == 0 {
	//If you defended last turn remove the TP.
	if action[turn - 1] == 5 tp -= 16;
	//Creates the 'tallying' effect for the TP.
	tpup = -16;
	//Makes it so the party boxes smoothly go up and down instead of snapping.
	yoffset[1] = 64;
	yoffset[0] = -64;
	partyoffset[1] = 64;
	partyoffset[0] = -64;
	//Decrease your turn by 1.
	turn -= 1;
}
} else {
//If a soul object doesn't exist create one.
if !instance_exists(obj_soul) instance_create_layer(215, 236, "objects", obj_soul);
	layer_sprite_index(_party0, 1);
	layer_sprite_index(_party1, 1);
	layer_sprite_y(_party0, 650 - yoffset[0])
	layer_sprite_y(_party1, 650 - yoffset[1])
}

//When a party box needs to go down, decrease the offset it is pushed up to make it smoothly go down until the offset is 0.
if yoffset[0] > 12 yoffset[0] -= 12 else if yoffset[0] > 0 yoffset[0] = 0;
if yoffset[1] > 12 yoffset[1] -= 12 else if yoffset[1] > 0 yoffset[1] = 0;

if yoffset[0] < -12 yoffset[0] += 12 else if yoffset[0] < 0 yoffset[0] = 0;
if yoffset[1] < -12 yoffset[1] += 12 else if yoffset[1] < 0 yoffset[1] = 0;

var _whatthefuck = 24;
if partyoffset[0] > _whatthefuck partyoffset[0] -= _whatthefuck else if partyoffset[0] > 0 partyoffset[0] = 0;
if partyoffset[1] > _whatthefuck partyoffset[1] -= _whatthefuck else if partyoffset[1] > 0 partyoffset[1] = 0;

if partyoffset[0] < -_whatthefuck partyoffset[0] += _whatthefuck else if partyoffset[0] < 0 partyoffset[0] = 0;
if partyoffset[1] < -_whatthefuck partyoffset[1] += _whatthefuck else if partyoffset[1] < 0 partyoffset[1] = 0;
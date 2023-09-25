//Yes I made an accurate deltarune battle system for a single level why do you ask?
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
	actselect = false;
	//Plays the selection move sound effect.
	audio_play_sound(snd_encounterMove, 1, false);
}

if select == 1 {
	if input_pressed(global.jump) && selecttime[0] >= 1 {
		action[turn] = 1;
		//Causes the box to smoothly go down instead of snapping.
		yoffset[turn] = 64;
		yoffset[turn + 1] = -64;
		select = 0;
		turn += 1;
	}
	selecttime[0] += 1;
} else selecttime[0] = 0;

if select == 2 {
	if input_pressed(global.jump) && selecttime[1] >= 1 {
		actselect = true
		selecttime[1] = 0;
	}
	if actselect = true {
		if input_pressed(global.left) == 1 && actx < 1 && acty == 0 actx += 1;
		if input_pressed(global.left) == -1 && actx > 0 && acty == 0 actx -= 1;
		if input_pressed(global.down) == 1 && acty < 1 && actx == 0 acty += 1;
		if input_pressed(global.down) == -1 && acty > 0 acty -= 1;
		if input_pressed(global.jump) && selecttime[1] >= 1 {
			action[turn] = 2;
			//Causes the box to smoothly go down instead of snapping.
			yoffset[turn] = 64;
			yoffset[turn + 1] = -64;
			select = 0;
			turn += 1;
		}
	}
	selecttime[1] += 1;
} else selecttime[1] = 0;
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
	//Increaes your turn by 1.
	turn += 1;
}

if sign(tpup) = 1 {
	if tpup >= 8 tpup -= 8 else tpup = 0;
} else {
	if tpup <= -8 tpup += 8 else tpup = 0;
}

if turn == 2 {
	
}

//Checks if you go back a turn
if input_pressed(global.back) && turn == 1 && select == 0 {
	//If you defended last turn remove the TP.
	if action[turn - 1] == 5 tp -= 16;
	//Creates the 'tallying' effect for the TP.
	tpup = -16;
	//Makes it so the party boxes smoothly go up and down instead of snapping.
	yoffset[1] = 64;
	yoffset[0] = -64;
	//Decrease your turn by 1.
	turn -= 1;
}

//When a party box needs to go down, decrease the offset it is pushed up to make it smoothly go down until the offset is 0.
if yoffset[0] > 24 yoffset[0] -= 24 else if yoffset[0] > 0 yoffset[0] = 0;
if yoffset[1] > 24 yoffset[1] -= 24 else if yoffset[1] > 0 yoffset[1] = 0;

if yoffset[0] < -24 yoffset[0] += 24 else if yoffset[0] < 0 yoffset[0] = 0;
if yoffset[1] < -24 yoffset[1] += 24 else if yoffset[1] < 0 yoffset[1] = 0;

//I did all of this instead of drawing the sprite directly so that it would be layered correctly (above the top row but below the flavor text box.)
var _layer = layer_get_id("GUI");
var _party0 = layer_sprite_get_id(_layer, "party0");
var _party1 = layer_sprite_get_id(_layer, "party1");

if turn == 0 {
	layer_sprite_index(_party0, 0)
	layer_sprite_index(_party1, 1);
	layer_sprite_y(_party0, 586 - yoffset[0])
	layer_sprite_y(_party1, 650 - yoffset[1])
} else {
	layer_sprite_index(_party0, 1);
	layer_sprite_index(_party1, 0)
	layer_sprite_y(_party0, 650 - yoffset[0])
	layer_sprite_y(_party1, 586 - yoffset[1])
}
//Checks for collision with the player object.
if place_meeting(x, y, obj_player) {
	//Checks for the ID value of the object, which should be set in instance create.
	if obj_player.onfloor == true && _id == 0 {
		//Sets the player's state to idle.
		obj_player.state = obj_player.idle;
		//Resets the player's stretch
		obj_player._stretch = 0;
		//Pauses all of the player logic.
		obj_player.pause = true;
		//Fades out the music.
		audio_sound_gain(global.song, 0, 200);
		//Uses instance names to affect specific actor objects, you can give them actual names if you like but keep in mind that only one instance can have a specific name throughout the ENTIRE game.
		if ctime == 60 {
			inst_65FD7787.sprite_index = spr_egg;
			inst_65FD7787.image_xscale = 4;
			inst_65FD7787.image_yscale = 4;
		} else if ctime > 60 && ctime < 112 {
			//Moves the enemy down until they reach the floor.
			inst_65FD7787.y += 20;
		} else if ctime == 112 {
			//Make sure they're evenly against the floor and make the player turn around.
			inst_65FD7787.y += 4;
			obj_player.xdir = -1;
		} else if ctime == 130 {
			//Play the exlcamation sound.
			audio_play_sound(snd_encounter, 1, false);
		} else if ctime = 180 {
			//If the text isn't done pause the timer and show the text boxes.
			if textprogress != string_length(_string) textshow = true;
			//If the text is done scrolling and you press jump resume the timer.
			if textprogress == string_length(_string) && input_pressed(global.jump) {
				textshow = false;
			}
		} else if ctime > 180 {
			//Move the enemy right until they are within 10 pixels of you.
			if inst_65FD7787.x < obj_player.x - 100 inst_65FD7787.x += 100 else inst_65FD7787.x = obj_player.x - 10;
		} if ctime = 195 {
			//Makes two different pitched versions of the horn sound.
			sound[0] = {
				sound: snd_battleStart,
				priority: 1,
				pitch: 1,
			}
			sound[1] = {
				sound: snd_battleStart,
				priority: 1,
				pitch: 1.1,
			}
			//Plays the first horn sound.
			if !audio_is_playing(snd_battleStart) audio_play_sound_ext(sound[0])
		} else if ctime = 209 {
			//Plays the second horn sound after 14 frames.
			audio_play_sound_ext(sound[1])
		} else if ctime == 215 {
			global.px = obj_player.x;
			global.py = obj_player.y;
			//Finally change the room to the battle room.
			room = rm_encounter;
		}
		//Counts how many frames the cutscene has been running for while not in dialog.
		if textshow == false ctime += 1;
	}
}
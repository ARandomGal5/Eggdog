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
		}
		if ctime > 60 && ctime < 112 {
			inst_65FD7787.y += 20;
		}
		if ctime == 112 {
			inst_65FD7787.y += 4;
			obj_player.xdir = -1;
		}
		if ctime == 130 {
			audio_play_sound(snd_encounter, 1, false);
		}
		if ctime = 180 {
			if textprogress != string_length(_string) textshow = true;
			if textprogress == string_length(_string) && input_pressed(global.jump) {
				textshow = false;
			}
		}
		//Counts how many frames the cutscene has been running for.
		if textshow == false ctime += 1;
	}
}
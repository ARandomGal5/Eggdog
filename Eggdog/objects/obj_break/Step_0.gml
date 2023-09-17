if starthealth == 0 {
	starthealth = _health;	
}
if collision_line(obj_player.bbox_left, obj_player.bbox_top - 5, obj_player.bbox_right, obj_player.bbox_top - 5, self, false, false) {
	//If the top of the player is colliding with this object and they are holding up, decrease durability by 1 every frame.
	if input(global.up) = -1 {
		_health -= 1;
		//Replay the break sound effect if it stops playing to make it loop.
		if !audio_is_playing(snd_break) audio_play_sound(snd_break, 1, false);
	}
}
//Checks if it's broken.
if _health == 0 {
	//Deactivates it's self.
	instance_deactivate_object(self);
	//Resets health so that if it is reactivated upon player respawn it doesn't instantly deactivate again.
	_health = starthealth;
}

//Changes the sprite based on the 'sprite' variable which should be defined in the instance create code.
sprite_index = sprite;
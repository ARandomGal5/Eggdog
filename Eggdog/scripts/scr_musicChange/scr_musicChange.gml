function music_change(song){
	//Checks if the set song isn't already playing.
	if global.song != song {
		//Stop the current song.
		audio_stop_sound(global.song);
		//Play the new song set in the function.
		global.song = song;
	}
}
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function music_change(song){
	if global.song != song {
		audio_stop_sound(global.song);
		global.song = song;
	}
}
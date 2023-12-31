if keyboard_check_pressed(vk_f4) fullscreen = !fullscreen;
window_set_fullscreen(fullscreen);
if keyboard_check_pressed(vk_f5) game_restart();

if keyboard_check_pressed(vk_f7) && room > room_first room_goto_previous();
if keyboard_check_pressed(vk_f8) && room < room_last room_goto_next();

//Changes the music based off of what room you are in.
if room == rm_tutorial music_change(mus_tutorial);
if room == rm_apartment music_change(mus_apartment);
if room == rm_ruins || room == rm_ruinsHouse music_change(mus_ruins);
if room == rm_encounter music_change(mus_encounter);

if !audio_is_playing(global.song) && global.song != -1 audio_play_sound(global.song, 2, true);
//Defines default key bindings.
global.left = vk_left;
global.right = vk_right;

global.up = vk_up;
global.down = vk_down;

global.jump = ord("Z");

global.back = ord("X");

fullscreen = false;

global.song = -1;

//Loads in all of the audio groups.
audio_group_load(Music);
audio_group_load(Sounds);
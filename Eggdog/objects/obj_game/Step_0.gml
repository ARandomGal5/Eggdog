if keyboard_check_pressed(vk_f4) fullscreen = !fullscreen;
window_set_fullscreen(fullscreen);
if keyboard_check_pressed(vk_f5) game_restart();
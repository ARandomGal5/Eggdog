camera_set_view_size(view_camera[0], view_width, view_height);

if instance_exists(obj_player)
{
	var _x = clamp(obj_player.x - view_width/2, 0, room_width - view_width);
	var _y = clamp(obj_player.y - view_height/2 - obj_player._stretch, 0, room_height - view_height)
	camera_set_view_pos(view_camera[0], _x, _y);
	
	var _cur_x = camera_get_view_x(view_camera[0]);
	var _cur_y = camera_get_view_y(view_camera[0]);
	
	var _spd = 0.1;
	camera_set_view_pos(view_camera[0],
	lerp(_cur_x, _x, _spd),
	lerp(_cur_y, _y, _spd)
	)
}


//Changes the resolution in the encounter room to stop pixel art mixel tomfuckery.
if room == rm_encounter && lastroom != rm_encounter {
	//Change the resolution to what I *believe* to be deltarune's resolution.
	view_width = 1280;
	view_height = 960;
	//Double the window size so it's the same size as deltarune.
	window_scale = 0.5;
	//Set the gamespeed to 30.
	game_set_speed(30, gamespeed_fps);
	//Set the window size to the resolution/0.5 (doubled)
	window_set_size(view_width/window_scale, view_height/window_scale);
	//Resize the screen size to the resolution.
	surface_resize(application_surface, view_width, view_height);
	//Center the window.
	window_center();
} 
//Checks if you leave the encounter room (if your room isn't the encounter room and your last room was).
if room != rm_encounter && lastroom == rm_encounter {
	//Reset all that stuffs back to the game's default.
	view_width = 1920
	view_height = 1080	
	window_scale = 1;
	game_set_speed(60, gamespeed_fps);
	window_set_size(view_width/window_scale, view_height/window_scale);
	surface_resize(application_surface, view_width, view_height);
	window_center();
}

lastroom = room;
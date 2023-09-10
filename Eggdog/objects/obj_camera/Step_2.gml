camera_set_view_size(view_camera[0], view_width, view_height);

if instance_exists(obj_player)
{
	var _x = clamp(obj_player.x - view_width/2, 0, room_width - view_width);
	var _y = clamp(obj_player.y - view_height/2 - obj_player.stretch, 0, room_height - view_height);
	camera_set_view_pos(view_camera[0], _x, _y);
	
	var _cur_x = camera_get_view_x(view_camera[0]);
	var _cur_y = camera_get_view_y(view_camera[0]);
	
	var _spd = 0.1;
	camera_set_view_pos(view_camera[0],
	lerp(_cur_x, _x, _spd),
	lerp(_cur_y, _y, _spd)
	)
}
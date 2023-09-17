image_index = state;

if place_meeting(x, y, obj_player) && state == 0 {
	obj_player.chx = x;
	obj_player.chy = y;
	state = 1;
}
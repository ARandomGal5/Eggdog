if collision_line(obj_player.bbox_left, obj_player.bbox_top - 5, obj_player.bbox_right, obj_player.bbox_top - 5, self, false, false) {
	if input(global.up) = -1 _health -= 1;
}
if _health = 0 instance_destroy(self);
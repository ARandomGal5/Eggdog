if iframes > 0 {
	if iframes % 4 == 1 image_blend = c_black else image_blend = c_white;
} else image_blend = c_white;
if graze == true {
	if grazetime > 5 && grazeframe < 3 grazeframe += 1;
	draw_sprite_ext(spr_graze, grazeframe, x, y, 2, 2, 0, c_white, 1);
} else grazeframe = 0;
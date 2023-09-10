if stretch = 0 {
	draw_self();	
} else {
	draw_sprite_ext(spr_eggBottom, -1, x, y, 4, 4, image_angle, image_blend, image_alpha);	
	draw_sprite_ext(spr_eggMiddle, -1, x, y - 32, 4, 4+stretch, image_angle, image_blend, image_alpha);
	draw_sprite_ext(spr_eggTop, -1, x, y - 64 - (stretch*2), 4, 4, image_angle, image_blend, image_alpha);
}

draw_set_color(c_red);
draw_rectangle(x - 5, y - 5, x + 5, y + 5, true);
draw_set_color(c_lime)
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
if _id == 0 {
	if ctime > 130 {
		draw_sprite_ext(spr_deltaExclamation, -1, 352, 864, 4, 4, 0, c_white, 1);
	}
	if ctime > 180 {
		draw_sprite_ext(spr_deltaText, -1, 960, 1080, 4, 4, 0, c_white, 1);
		font = font_add_sprite(spr_deltaFont, ord("!"), true, 3);
		draw_set_font(font);
	}
}
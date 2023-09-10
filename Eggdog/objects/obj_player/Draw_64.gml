draw_sprite_ext(spr_health, 3 - _health, 50, 50, 4, 4, 0, c_white, 1);
draw_set_font(fnt_comicSans);
draw_set_color(c_red)
draw_text(200, 64, string(berry));
draw_set_font(fnt_debug);
draw_set_color(c_white);
draw_text(0, 0, string(state));
draw_text(0, 32, string(xspeed));
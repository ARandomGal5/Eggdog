draw_sprite_ext(spr_health, 3 - _health, 50, 50, 4, 4, 0, c_white, 1);
draw_set_font(fnt_comicSans);
if berry >= 0 draw_set_color(c_white) else draw_set_color(c_red);
draw_text(200, 64, string(berry));

//If you have died and 50 frames have passed, draw a rectangle that stretches out left to right, increasing by 50 pixels each frame.
if deathtime <= 125 && deathtime >= 0 {
	dlength += 50;
	draw_set_color(c_black);
	draw_rectangle(0, 0, dlength, 1080, false);
	if deathtime = 1 dlength = 0;
} 

//Once you have respawned do the same effect but in reverse.
if undie = true {
	if dlength > 0 dlength += 50;
	draw_set_color(c_black);
	draw_rectangle(dlength, 0, 1920, 1080, false);
	if dlength >= 1920 {
		dlength = 0;
		undie = false;
	}
}

if dlength >= 1920 {
	draw_sprite_ext(spr_strawberry, -1, 860, 540, 4, 4, 0, c_white, 1)
	if boffset < 10 boffset += 0.5;
	if boffset >= 0 var _string = round(berry - boffset)
	if boffset < 0 _string = berry;
	if _string > 0 draw_set_color(c_white) else draw_set_color(c_red);
	draw_text(960, 540, string(_string));
} else boffset = -10;
	

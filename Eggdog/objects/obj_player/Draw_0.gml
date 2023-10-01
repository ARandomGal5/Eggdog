//Sets the sprite
if state != hurt {
	sprtop = spr_eggTop;
	sprmid = spr_eggMiddle;
	sprbot = spr_eggBottom;	
} else {
	sprtop = spr_eggHurtTop;
}

if iframe <= 0 || frac(iframe/4) == 0 
{
	if state != spin && _health > 0 {
		//Drawn from bottom to top so the top overlaps the middle segment.
		draw_sprite_ext(sprbot, -1, x, y, 4*xdir, 4, image_angle, image_blend, image_alpha);	
		draw_sprite_ext(sprmid, -1, x, y - 32, 4*xdir, 4+_stretch, image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprtop, -1, x, y - 64 - (_stretch*2), 4*xdir, 4, image_angle, image_blend, image_alpha);
	} else draw_self();
}



draw_set_color(c_red);
draw_text(numx, numy, string(slice));

draw_set_color(c_lime);

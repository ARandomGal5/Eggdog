//Sets itself to only draw itself if it isn't colliding with a breakable tile, so that it can be prooperly hidden by them 100% of the time.
if !place_meeting(x, y, obj_break) draw_self();
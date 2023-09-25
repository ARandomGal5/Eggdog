//Daddy gms2 why isn't this a built in function if it's in a tutorial.
function tile_meeting(){
var _layer = argument2,
    _tm = layer_tilemap_get_id(_layer);

var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (argument0 - x) + 1, y),
    _y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (argument1 - y) + 1),
    _x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (argument0 - x) - 1, y),
    _y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (argument1 - y) - 1);

for(var _x = _x1; _x <= _x2; _x++){
 for(var _y = _y1; _y <= _y2; _y++){
    if(tile_get_index(tilemap_get(_tm, _x, _y))){
    return true;
    }
 }
}

return false;
}
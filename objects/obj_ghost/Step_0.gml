#region TIME STOP

if (!global.ts) {
    exit; // para completamente o inimigo
}

#endregion

#region MOVIMENTO

if (! place_meeting(x,y,obj_block)){
	move_towards_point(obj_player.x, obj_player.y, spd);
}

#endregion

#region MORTE

if (vida <= 0) {
    instance_destroy();
}

#endregion
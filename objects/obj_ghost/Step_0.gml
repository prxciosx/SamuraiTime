#region TIME STOP

if (!global.ts) {
	move_towards_point(x, y, 0);
	hspd = 0;
	image_speed = 0;
    exit; // para completamente o inimigo
} else{
	image_speed = 1;
	hspd = 3;
}

#endregion

#region MOVIMENTO

move_towards_point(obj_player.x, obj_player.y, hspd);

if (obj_player.x > x){
	dir = 1;
}else{
	dir = -1;
}

image_xscale = dir ;
#endregion

#region MORTE

if (vida <= 0) {
	global.inm += 1;
    instance_destroy();
}

#endregion
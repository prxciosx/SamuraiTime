#region TIME STOP

if (!global.ts) {
    exit; // para completamente o inimigo
}

#endregion

#region MOVIMENTO

move_towards_point(obj_player.x, obj_player.y, spd);


#endregion

#region MORTE

if (vida <= 0) {
    instance_destroy();
}

#endregion
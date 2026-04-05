#region TIME STOP

if (global.ts) {
    exit; // para completamente o inimigo
}

#endregion

#region MOVIMENTO

var hspd = spd * dir;

// colisão com parede
if (place_meeting(x + hspd, y, obj_block)) {
    dir *= -1;
}

x += hspd;

#endregion

#region MORTE

if (vida <= 0) {
	global.inm += 1;
    instance_destroy();
}

#endregion

#region DANO (ataque do player)

// verifica se colidiu com ataque
var atk = instance_place(x, y, obj_atk);

if (atk != noone) {
    vida -= global.dano;
}

#endregion
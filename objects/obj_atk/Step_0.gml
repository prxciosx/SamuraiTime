#region SEGUIR PLAYER (posição do ataque)

x = obj_player.x + (obj_player.image_xscale * 16);
y = obj_player.y - 50;

image_xscale = obj_player.image_xscale;

#endregion

#region DANO

if (!hit) {
    var inimigo = instance_place(x, y, obj_inm);
    
    if (inimigo != noone) {
        inimigo.vida -= damage;
        hit = true;
		audio_play_sound(sou_atackVFX, 2, false);
    }
}

#endregion

#region TEMPO DE VIDA

life--;

if (life <= 0) {
	if (instance_exists(owner)) {
        owner.ataque = false;
    }
    obj_player.ataque = false; // RESET GARANTIDO
    instance_destroy();
} 
#endregion
#region SEGUIR PLAYER (posição do ataque)

x = obj_player.x + (obj_player.image_xscale * 10);
y = obj_player.y - 64;

image_xscale = obj_player.image_xscale;

#endregion

#region DANO

if (!hit) {
    var inimigo = instance_place(x, y, obj_inm);
    
    if (inimigo != noone) {
        inimigo.vida -= damage;
        hit = true;
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
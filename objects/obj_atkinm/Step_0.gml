if (instance_exists(obj_inm)){
#region SEGUIR INIMIGO (posição do ataque)

x = obj_inm.x + 50 * obj_inm.image_xscale;
y = obj_inm.y - 50;

image_xscale = obj_inm.image_xscale;

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
} else {
	instance_destroy();
}
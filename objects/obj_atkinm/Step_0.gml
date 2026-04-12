#region SEGUE O DONO

if (instance_exists(owner)) {

    x = owner.x + 50 * owner.image_xscale;
    y = owner.y - 50;

    image_xscale = owner.image_xscale;

} else {
    instance_destroy();
}

#endregion
#region TEMPO DE VIDA

life--;

if (life <= 0) {

    if (instance_exists(owner)) {
        owner.ataque = false;
    }

    instance_destroy();
}

#endregion

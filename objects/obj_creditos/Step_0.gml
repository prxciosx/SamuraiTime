y_texto -= vel;

// quando sair da tela, pode resetar ou mudar de room
if (y_texto < -string_height(texto)) {
    room_goto(MenuI); // ou restart
}
if (keyboard_check(ord("X"))) {
    y_texto -= vel * 3;
}
inputs_scr();

if charge_press and hsp = 0 {
    hsp = 0;
    charging = 1;
}
else {
charging = 0;
}


if charge_press and super = 0 {
    hsp = 0;
    sprite_index = SPR_Goku_C1;
    image_speed = animspd;
}

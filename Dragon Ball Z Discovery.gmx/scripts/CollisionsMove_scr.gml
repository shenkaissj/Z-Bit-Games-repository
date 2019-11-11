// Calculating movements
var move = right_walk - left_walk;
hsp = move * walkspd;
vsp = vsp + grv;

//Checks if you are on the ground
if (place_meeting(x, y + 1, barrier_obj)) {
    grounded = true;
    airpunch = 0;
    vanim = true;
} else {grounded = false;}

// Horizontal collision and movement
if (place_meeting(x + hsp, y, barrier_obj)) or (place_meeting(x + hsp, y, slope_obj)) {

    //Check if empty space 1-5 pixels above
    yplus = 0;
    while ((place_meeting(x + hsp, y - yplus, barrier_obj) and yplus <= abs(5))) {
        yplus += 1;
    } 
    
    if (place_meeting(x + hsp, y - yplus, barrier_obj)) {
        while (!place_meeting(x + sign(hsp), y, barrier_obj)) {
            x = x + sign(hsp);
        }
        hsp = 0
    }
    else {
        y -= yplus;
    }
    
}

x = x + hsp;

// Vertical collision and movement
if (place_meeting(x, y + vsp, barrier_obj)){
    while (!place_meeting(x, y + sign(vsp), barrier_obj)) {
        y = y + sign(vsp);
    }
        vsp = 0
}
if (jump_press) and (grounded = true) {
    vsp = jumpheight;
}
y = y + vsp;

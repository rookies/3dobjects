include <human.scad>;

/* cm */
L = 320; /* overall length */
MW = 140; /* mattress width */
ML = 200; /* mattress length */
MH = 20; /* mattress height */
LX = 10; /* TODO: leg X size */
LY = 10; /* TODO: leg Y size */
LH = 70; /* leg height */
RT = 25; /* radiator thickness */
PW = MW + LX - RT; /* platform width */
echo(platform_width=PW);
PL = L - ML - 2*LY; /* platform length */
echo(platform_length=PL);
PT = 1.9; /* TODO: platform thickness */
SBD1 = 2.5; /* TODO: smaller side board dimension */
SBD2 = 20; /* TODO: larger side board dimension */

/* TODO: Schlafplatz auf der Plattform (ausklappbar?) */
/* TODO: Matratze höher setzen, Plattform niedriger, ...? */
/* TODO: wände, kallax, fenster */
/* TODO: oberkante matratze mit fensterbrett abschließen lassen? */

/* mattress */
color("gray") translate([0,0,MH/2]) cube([MW,ML,MH], center=true);

/* platform */
color("red") translate([(PW-MW-LX)/2,(ML+LY+PL)/2,MH+PT/2]) cube([PW,PL,PT], center=true);

/* legs (mattress) */
color("red") translate([0,0,-LH/2+MH]) for (i=[-1,1]) {
    translate([i*(MW+LX)/2,0,0]) {
        for (j=[-1,1]) {
            translate([0,j*(ML+LY)/2,0]) cube([LX,LY,LH], center=true);
        }
    }
}
/* legs (platform) */
color("red") translate([0,0,-LH/2+MH]) for (i=[-1,1]) {
    translate([(PW-MW-LX)/2 + i*PW/2,0,0]) {
        for (j=[-1,1]) {
            translate([0,(ML+PL+LY)/2 + j*PL/2,0]) cube([LX,LY,LH], center=true);
        }
    }
}

color("red") translate([0,0,MH-SBD2/2]) {
    /* longer side boards (mattress) */
    for (i=[-1,1]) {
        translate([i*(MW+LX)/2,0,0]) cube([SBD1,ML,SBD2], center=true);
    }
    /* longer side boards (platform) */
    translate([0,(ML+PL+LY)/2,0]) for (x=[0,PW]) {
        translate([-(MW+LX)/2+x,0,0]) cube([SBD1,PL,SBD2], center=true);
    }

    /* shorter side boards (mattress) */
    for (i=[-(ML+LX)/2,(ML+LX)/2]) {
        translate([0,i,0]) cube([MW,SBD1,SBD2], center=true);
    }
    /* shorter side board (platform) */
    translate([-LX,(ML+LX)/2+PL,0]) cube([PW,SBD1,SBD2], center=true);
}

/* humans */
module centeredHuman() {
    translate([-40,95,10]) rotate([90,0,0]) human();
}
//centeredHuman();
//translate([0,(ML+PL)/2,0]) rotate([0,0,90]) centeredHuman();
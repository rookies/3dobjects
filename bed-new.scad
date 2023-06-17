include <human.scad>;

/*
 * Stollenbauweise
 * Quermutterbolzen + Holzdübel
 * Rollbretter unter dem Bett
 * https://www.johannes-strommer.com/rechner/balkenberechnung/
 * https://www.otto.de/p/faizee-moebel-hochbett-stauraum-hochbett-travel-artisan-eiche-parisot-S041Z02O/#variationId=S041Z02OIZ3G
 * TODO: Brett am Kopfende?
 * TODO: Beine nach oben erweitern?
 * TODO: Dach?
 */

/* cm */
L = 320; /* overall length */
MW = 140; /* mattress width */
ML = 200; /* mattress length */
MH = 20; /* mattress height */
LX = 10; /* TODO: leg X size */
LY = 10; /* TODO: leg Y size */
LH = 70; /* leg height */
SBD1 = 2.5; /* TODO: smaller side board dimension */
SBD2 = 20; /* TODO: larger side board dimension */

/* mattress */
color("gray") translate([0,0,MH/2]) cube([MW,ML,MH], center=true);

/* legs */
color("red") translate([0,0,-LH/2+MH]) for (i=[-1,1]) {
    translate([i*(MW+LX)/2,0,0]) {
        for (j=[-1,1]) {
            translate([0,j*(ML+LY)/2,0]) cube([LX,LY,LH], center=true);
        }
    }
}

color("red") translate([0,0,MH-SBD2/2]) {
    /* longer side boards */
    for (i=[-1,1]) {
        translate([i*(MW+LX)/2,0,0]) cube([SBD1,ML,SBD2], center=true);
    }

    /* shorter side boards */
    for (i=[-(ML+LX)/2,(ML+LX)/2]) {
        translate([0,i,0]) cube([MW,SBD1,SBD2], center=true);
    }
}

/* humans */
module centeredHuman() {
    translate([-40,95,10]) rotate([90,0,0]) human();
}
//centeredHuman();
//translate([0,(ML+PL)/2,0]) rotate([0,0,90]) centeredHuman();

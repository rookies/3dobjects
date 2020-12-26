CR = 25; /* corner radius */
WT = 2; /* wall thickness */
SX = 89+2*WT; /* size X (width) */
SY = 89+2*WT; /* size Y (depth) */
H = 30; /* height */
MAW = 10; /* mounting arm width */
MAT = 2; /* mounting arm thickness */
SHDIS = 71.5; /* screw hole distance */
SHDIA = 4.4; /* screw hole diameter */

/* straight mounting arm length: */
SMAL = (SX - SHDIS) / 2;
/* diagonal mounting arm length: */
DMAL = (SHDIS * sqrt(2) - SX) / 2 + WT;

module baseShape(x, y, z) {
    difference() {
        minkowski() {
            linear_extrude(z-CR) {
                circle(d=x-2*CR);
                translate([0,y/2-x/4]) square([x-2*CR,y-x/2], center=true);
            }
            /* round off corners: */
            sphere(r=CR);
        }
        /* cut bottom flat: */
        translate([0,y-x,-CR/2]) cube([x+2*CR,y+2*CR,CR], center=true);
        /* cut front flat: */
        translate([0,y-x/2+CR/2,H/2]) cube([x+2*CR,CR,H], center=true);
    }
}

/* main body: */
difference() {
    baseShape(SX, SY, H);
    baseShape(SX-2*WT, SY, H-WT);
}
/* mounting arms: */
linear_extrude(MAT) for (i = [-1,1], j = [-1,1]) {
    translate([i*SHDIS/2,j*SHDIS/2]) {
        difference() {
            union() {
                circle(d=MAW, $fn=20);
                if (j == 1) {
                    /* straight connection */
                    translate([i*SMAL/2,0]) square([SMAL,MAW], center=true);
                } else {
                    /* diagonal connection */
                    translate([-i*DMAL/2/sqrt(2),DMAL/2/sqrt(2)]) rotate(i*135) square([DMAL,MAW], center=true);
                }
            }
            /* screw hole: */
            circle(d=SHDIA, $fn=20);
        }
    }
}
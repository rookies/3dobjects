CR = 25; /* corner radius */
SX = 80; /* size X (width) */
SY = 80; /* size Y (depth) */
H = 30; /* height */
WT = 2; /* wall thickness */

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

difference() {
    baseShape(SX, SY, H);
    baseShape(SX-2*WT, SY, H-WT);
}
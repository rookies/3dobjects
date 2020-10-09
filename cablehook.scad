H = 50;
D = 30;
W = 20;
CD = 5; /* corner diameter */
WT = 4; /* wall thickness */
CW = 10; /* cutout width */
CH = 15; /* cutout height */
SHD = 5; /* screw hole diameter */
SDHD = 10; /* screwdriver hole diameter */

$fn = 100;

module roundedRectangle(x,y,d) {
    translate([d/2,d/2]) minkowski() {
        square([x-d,y-d]);
        circle(d=d);
    }
}

difference() {
    linear_extrude(W) difference() {
        roundedRectangle(D,H,CD);
        translate([WT,WT]) roundedRectangle(D-2*WT,H-2*WT,CD);
        translate([0,WT]) square([CW,CH]);
    }
    /* screw hole: */
    translate([D/2,0,W/2]) rotate([-90,0,0]) cylinder(d=SHD, h=WT);
    /* screwdriver hole: */
    translate([D/2,H,W/2]) rotate([90,0,0]) cylinder(d=SDHD, h=WT);
}
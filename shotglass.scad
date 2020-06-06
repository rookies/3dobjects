/* d=3.6cm & h=4cm -> V=40ml */

$fn=50;


difference() {
    intersection() {
        cube([40,40,45], center=true);
        rotate([0,0,45]) cube([40,40,45], center=true);
    }
    translate([0,0,10]) cylinder(d=36, h=55, center=true);
    for (i = [0:7]) {
        rotate([0,0,i*45]) translate([-19,-4,-20]) rotate([0,-90,0]) linear_extrude(5) text("ShotBot", size=8);
    }
}
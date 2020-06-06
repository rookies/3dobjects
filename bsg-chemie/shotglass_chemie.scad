intersection() {
    difference() {
        cube([42,42,40], center=true);
        translate([0,0,5]) cube([36,36,40], center=true);
        for (i = [0:3]) {
            rotate([0,0,i*90]) scale([.22,1,.22]) translate([-50,-20,-65]) rotate([90,0,0]) linear_extrude(1.1) import("chemie_bw.svg");
        }
    }
    rotate([0,0,45]) cube(55, center=true);
}

include <hose_connector.scad>;

$fn=100;

R0 = 1.75;
R1 = 2.50;
R2 = 3.00;
L = 2.00;
N = 4;

module hc() {
    hose_connector(R0, R1, R2, L, N);
}

translate([0,-R2,0]) rotate([90,0,0]) hc();
translate([0,+R2,0]) rotate([-90,0,0]) hc();
translate([+R2,0,0]) rotate([0,90,0]) hc();
difference() {
    cube(2*R2, center=true);
    rotate([90,0,0]) cylinder(r=R0, h=L*N*3, center=true);
    rotate([0,90,0]) cylinder(r=R0, h=L*N*2);
}
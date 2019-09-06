module glass() {
    cylinder(
        h=70,
        d1=35,
        d2=45
    );
}
module notch_half() {
    polygon([
        [-30,20],[-30,-35],[0,-35],
        [0,-25],[-15,-25],[-25,20]
    ]);
}
module notch() {
    linear_extrude(5) union() {
        notch_half();
        mirror([180,0,0]) notch_half();
    }
}
module notch_group() {
    for (i = [-2:3]) {
        translate([i*60,0,0]) notch();
    }
}
module leadscrew() {
    rotate([0,90,0]) cylinder(h=400, d=8, center=true);
}
module leadscrew_connector() {
    rotate([0,90,0]) cylinder(h=25, d=19, center=true);
}
module stepper_motor() {
    cube([34,42.3,42.3], center=true);
    translate([29,0,0]) rotate([0,90,0]) cylinder(h=24, d=5, center=true);
}
module leadscrew_setup() {
    leadscrew();
    translate([-200,0,0]) leadscrew_connector();
    translate([-241,0,0]) stepper_motor();
}

glass();
translate([0,0,35]) notch_group();
translate([0,0,100]) leadscrew_setup();
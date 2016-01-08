$fn=400;
difference() {
    union() {
        // Socket:
        translate([0,0,2.5]) cylinder(d=50,h=5,center=true);
        // Main part:
        translate([0,0,19]) cylinder(d=35.5,h=28,center=true);
    }
    // Screw hole:
    translate([0,12.75,13.5]) rotate([90,0,0]) cylinder(d=6,h=10,center=true);
    // Socket hole:
    translate([0,0,29]) cylinder(d=20,h=10,center=true);
    // Cable hole:
    cylinder(d=8,h=100,center=true);
}
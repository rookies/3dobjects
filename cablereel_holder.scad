$fn = 50;

REEL_INNER_RADIUS = 15;
REEL_OUTER_RADIUS = 45;
REEL_THICKNESS = 1;
REEL_CLEARANCE = 2;
SPINDLE_RADIUS = 10;
SPINDLE_LENGTH = 100;
GUIDE_HEIGHT = 10;
GUIDE_WIDTH = 10;
GUIDE_CLEARANCE = 10;
BASE_CLEARANCE_X = 10;
BASE_CLEARANCE_Z = 10;
BASE_DEPTH = 100;
BASE_HEIGHT = 5;

module reel(
    width,
    rInner = REEL_INNER_RADIUS,
    rOuter = REEL_OUTER_RADIUS,
    thickness = REEL_THICKNESS
) {
    rInnerOuter = rInner + thickness;
    rotate([90, 0, 90]) difference() {
        union() {
            cylinder(thickness, rOuter, rOuter);
            translate([0, 0, width-thickness])
                cylinder(thickness, rOuter, rOuter);
            cylinder(width, rInnerOuter, rInnerOuter);
        }
        cylinder(width, rInner, rInner);
    }
}

/* spindle: */
rotate([90, 0, 90])
    cylinder(
        SPINDLE_LENGTH,
        SPINDLE_RADIUS,
        SPINDLE_RADIUS
    );
/* guide: */
translate([0, -(REEL_OUTER_RADIUS+GUIDE_CLEARANCE+GUIDE_WIDTH), 0])
    cube(
        [SPINDLE_LENGTH, GUIDE_WIDTH, GUIDE_HEIGHT]
    );
/* base plate: */
baseWidth = SPINDLE_LENGTH + 2*BASE_CLEARANCE_X;
baseZ = -(REEL_OUTER_RADIUS+BASE_CLEARANCE_Z+REEL_INNER_RADIUS-SPINDLE_RADIUS+BASE_HEIGHT);
translate([-BASE_CLEARANCE_X, -BASE_DEPTH/2, baseZ])
    cube([baseWidth, BASE_DEPTH, BASE_HEIGHT]);
/* pillars: */

/* reels: */
color("grey") {
    reelZ = SPINDLE_RADIUS-REEL_INNER_RADIUS;
    reelOff = (SPINDLE_LENGTH - 84) / 2;
    translate([reelOff+0, 0, reelZ]) reel(16);
    translate([reelOff+18, 0, reelZ]) reel(16);
    translate([reelOff+36, 0, reelZ]) reel(30);
    translate([reelOff+68, 0, reelZ]) reel(16);
}
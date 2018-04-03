$fn = 50;

NOMINAL_THICKNESS = 3/4*25.4;

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
BASE_HEIGHT = NOMINAL_THICKNESS;
HOLES_RADIUS = 1.5;
HOLES_NUM = 8;
HOLES_CLEARANCE_X = 10;
PILLAR_WIDTH = NOMINAL_THICKNESS;
PILLAR_DEPTH = 30;

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
difference() {
    guideY = -(REEL_OUTER_RADIUS+GUIDE_CLEARANCE);
    translate([0, guideY-GUIDE_WIDTH, 0])
        cube(
            [SPINDLE_LENGTH, GUIDE_WIDTH, GUIDE_HEIGHT]
        );
    step = (SPINDLE_LENGTH - 2*HOLES_CLEARANCE_X)/(HOLES_NUM - 1);
    for (i = [0:(HOLES_NUM -1)]) {
        translate([HOLES_CLEARANCE_X + i*step, guideY, GUIDE_HEIGHT/2]) rotate([90,0,0])
            cylinder(GUIDE_WIDTH, HOLES_RADIUS, HOLES_RADIUS);
    }
}
/* base plate: */
baseWidth = SPINDLE_LENGTH + 2*BASE_CLEARANCE_X;
baseZ = -(REEL_OUTER_RADIUS+BASE_CLEARANCE_Z+REEL_INNER_RADIUS-SPINDLE_RADIUS+BASE_HEIGHT);
translate([-BASE_CLEARANCE_X, -BASE_DEPTH/2, baseZ])
    cube([baseWidth, BASE_DEPTH, BASE_HEIGHT]);
/* pillars: */
translate([0, -PILLAR_DEPTH/2, baseZ+BASE_HEIGHT]) rotate([90,0,90])
    linear_extrude(PILLAR_WIDTH)
        polygon([[0,0], [PILLAR_DEPTH,0], [PILLAR_DEPTH,50], [PILLAR_DEPTH/2,40], [0,50]]);
/* reels: */
color("grey") {
    reelZ = SPINDLE_RADIUS-REEL_INNER_RADIUS;
    reelOff = (SPINDLE_LENGTH - 84) / 2;
    translate([reelOff+0, 0, reelZ]) reel(16);
    translate([reelOff+18, 0, reelZ]) reel(16);
    translate([reelOff+36, 0, reelZ]) reel(30);
    translate([reelOff+68, 0, reelZ]) reel(16);
}
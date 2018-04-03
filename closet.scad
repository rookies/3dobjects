/* measurements (in cm): */
MODULE_OUTERWIDTH = 80;
MODULE_DEPTH = 50;
WALL_THICKNESS = 1.8;
CORNER_SIZE = 4.4;
CLOTHESRAIL_RADIUS = 1;
CLOTHESRAIL_SPACE = 20;
/* other settings: */
WALLS = true;
REFERENCE_OBJECTS = true;
ROOM_HEIGHT = 290;

module closetModuleCorner(depth) {
    cube([CORNER_SIZE, depth, CORNER_SIZE]);
}

module closetModule(
    outerHeight,
    outerWidth=MODULE_OUTERWIDTH,
    depth=MODULE_DEPTH
) {
    color("brown") {
    /* bottom wall */
    cube([outerWidth, depth, WALL_THICKNESS]);
    /* top wall */
    translate([0, 0, outerHeight-WALL_THICKNESS])
        cube([outerWidth, depth, WALL_THICKNESS]);
    /* left wall */
    cube([WALL_THICKNESS, depth, outerHeight]);
    /* right wall */
    translate([outerWidth-WALL_THICKNESS, 0, 0])
        cube([WALL_THICKNESS, depth, outerHeight]);
    /* bottom left corner */
    translate([WALL_THICKNESS, 0, WALL_THICKNESS])
        closetModuleCorner(depth);
    /* bottom right corner */
    translate([outerWidth-WALL_THICKNESS-CORNER_SIZE, 0, WALL_THICKNESS])
        closetModuleCorner(depth);
    /* top left corner */
    translate([WALL_THICKNESS, 0, outerHeight-WALL_THICKNESS-CORNER_SIZE])
        closetModuleCorner(depth);
    /* top right corner */
    translate([outerWidth-WALL_THICKNESS-CORNER_SIZE, 0, outerHeight-WALL_THICKNESS-CORNER_SIZE])
        closetModuleCorner(depth);
    }
}

module closetModuleWithClothesRail(
    outerHeight,
    outerWidth=MODULE_OUTERWIDTH,
    depth=MODULE_DEPTH
) {
    closetModule(outerHeight, outerWidth, depth);
    color("gray")
    translate([0, depth/2, outerHeight-CLOTHESRAIL_SPACE])
    rotate([0,90,0])
        cylinder(outerWidth, CLOTHESRAIL_RADIUS, CLOTHESRAIL_RADIUS, $fn=20);
}

module plasticBox() {
    color("gray")
    translate([0, 47, WALL_THICKNESS])
    rotate([90, 0, 0])
    linear_extrude(44)
        polygon([[3,0], [29,0], [32, 23], [0,23]]);
}

module plasticBoxStack() {
    plasticBox();
    translate([0, 0, 23]) plasticBox();
}

module halfHumanShape() {
    polygon([
        /* leg */
        [-20,0], [-10,0], [0,90], /*[-15,90],*/
        /* up to the neck */
        [0,165], [-5,165], [-5,155], [-25,155],
        /* arm */
        [-40,75], [-30,75], [-18,140]
    ]);
}

module human() {
    color("pink")
    translate([40,10,0])
    rotate([90,0,0])
    linear_extrude(10) {
        halfHumanShape();
        mirror([1,0]) halfHumanShape();
        /* head */
        translate([0,175]) circle(d=30);
    }
}

width = MODULE_OUTERWIDTH;
/* first row: boxes */
closetModule(50);
translate([width, 0, 0]) closetModule(50);
if (REFERENCE_OBJECTS) {
    translate([7,0,0]) plasticBoxStack();
    translate([40,0,0]) plasticBoxStack();
    translate([88,0,0]) plasticBoxStack();
    translate([121,0,0]) plasticBoxStack();
};
/* second row: miscellaneous stuff */
translate([0, 0, 50]) union() {
    closetModule(40, width/2);
    translate([width/2, 0, 0]) closetModule(40);
    translate([width*1.5, 0, 0]) closetModule(40, width/2);
}
/* third row: clothes rails */
translate([0,0, 90]) union() {
    closetModuleWithClothesRail(125);
    translate([width, 0, 0])
        closetModuleWithClothesRail(125);
}
/* fourth row: more misc. stuff */
translate([0, 0, 215]) union() {
    closetModule(40, width/2);
    translate([width/2, 0, 0]) closetModule(40);
    translate([width*1.5, 0, 0]) closetModule(40, width/2);
}
/* human for reference (190cm) */
if (REFERENCE_OBJECTS) {
    translate([170,0,0]) human();
};
/* walls */
if (WALLS) {
    color("white") {
    translate([0,50,0])
        cube([400,10,ROOM_HEIGHT]);
    translate([-10,-340,0])
        cube([10,400,ROOM_HEIGHT]);
    translate([-10,-340,-10])
        cube([410,400,10]);
    }
};
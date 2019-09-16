/* all measurements in millimeters */
BT = 18; /* board thickness */
CD = 44; /* cleat dimension */
W = 1400; /* overall width */
BO = 50; /* bottom offset */
D = 800; /* overall depth */
FH = 400; /* front height */
BH = 900; /* back height */

module board(width, depth) {
    color("red")
    cube([width,BT,depth]);
}

module cleat(length) {
    color("blue")
    cube([CD,CD,length]);
}

/* boards (front, back, left, right): */
translate([0,0,BO]) board(W,FH);
translate([0,D-BT,BO]) board(W,BH);
translate([BT,0,BO]) rotate([0,0,90]) board(D,FH);
translate([W,0,BO]) rotate([0,0,90]) board(D,FH);
/* cleats (front left, right, back left, right) */
translate([BT,BT,0]) cleat(FH+BO);
translate([W-CD-BT,BT,0]) cleat(FH+BO);
translate([BT,D-CD-BT,0]) cleat(BH+BO);
translate([W-CD-BT,D-CD-BT,0]) cleat(BH+BO);
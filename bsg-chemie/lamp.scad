/*
battery:
52 wide
27 high (without cables)
17 thick

LED strip:
8x25
*/
/* inner width: */
IW = 52;
/* inner height: */
IH = 65;
/* wall thickness: */
WT = 1;
/* depth: */
D = 32;
/* battery box inner depth: */
BBID = 20;
/* battery box inner height: */
BBIH = 30;
/* logo thickness: */
LT = .6;
/* logo scale: */
LS = .4;
/* cable hole diameter: */
CHD = 3;
/* cable hole offset X: */
CHOX = 5;
/* switch hole diameter: */
SHD = 6;
/* switch hole offset Z: */
SHOZ = 15;
/* front plate oversize: */
FPO = .5;
/* switch support thickness: */
SST = 1.5;
/* switch support width: */
SSW = 10;
/* ledge width: */
LW = 1.5;

/* outer width: */
OW = IW + 2*WT;
/* outer height: */
OH = IH + 2*WT;

module prism(l, w, h) {
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}

color("green") {
/* left wall: */
difference() {
    union() {
        translate([-WT,0,0]) cube([WT,D,IH]);
        /* switch support: */
        translate([0,0,IH/2+SHOZ-SSW/2]) cube([SST,D,SSW]);
    }
    /* switch hole: */
    translate([-WT,D/2,IH/2+SHOZ]) rotate([0,90,0]) cylinder(h=(WT+SST), d=SHD, $fn=20);
}
/* right wall: */
translate([IW,0,0]) cube([WT,D,IH]);
/* floor: */
translate([-WT,0,-WT]) cube([OW,D,WT]);
/* ceiling: */
translate([-WT,0,IH]) cube([OW,D,WT]);
/* battery box wall: */
translate([0,D-BBID-WT,0]) cube([IW,WT,BBIH]);
/* battery box ceiling: */
difference() {
    translate([0,D-BBID-WT,BBIH]) cube([IW,BBID+WT,WT]);
    /* cable hole: */
    translate([CHOX,D-WT-BBID/2,BBIH]) cylinder(h=WT, d=CHD, $fn=20);
}
/* back wall: */
translate([0,D-WT,BBIH+WT]) cube([IW,WT,IH-BBIH-WT]);
/* bottom legde: */
translate([IW,LW,0]) rotate([0,0,180]) prism(IW,LW,LW);
/* top ledge: */
translate([IW,0,IH-LW]) rotate([90,0,180]) prism(IW,LW,LW);
/* left ledge: */
translate([LW,0,IH]) rotate([0,90,90]) prism(IH,LW,LW);
/* right legde: */
translate([IW,LW,IH]) rotate([0,90,180]) prism(IH,LW,LW);
}

color("lightgray", .7) {
/* front wall: */
translate([-WT-FPO,-WT,-WT-FPO]) cube([OW+2*FPO,WT,OH+2*FPO]);
}

color("green") {
/* logo */
translate([IW/2,-WT,IH/2]) rotate([90,0,0]) linear_extrude(LT) scale(LS) import("chemie_bw.svg", center=true);
}
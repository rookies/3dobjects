/* simple view: */
SIMPLE = false;

/* overall dimensions: */
H = 2000;
W = 490;
D = 630; /* TODO */

/* extrusion base dimensions: */
EX = 30;
EY = 30;

/* euro container dimensions: */
ECW = 400;
ECD = 600;
ECH = 120;
ECFH = 9; /* foot height */
ECFSD = 19; /* foot size difference at each side */

/* euro container stack properties: */
ECZ0 = 500; /* Z coordinate of first container */
ECZS = ECH + 50; /* Z step for next containers */
ECN = 8; /* number of containers */

module aluminumExtrusion(l) {
    echo(str("BOM:extrusion,",l));
    if (SIMPLE) {
        color("gray") cube([EX,EY,l]);
    } else {
        /* Source: https://commons.wikimedia.org/wiki/File:8020-Fractional-Profiles-1.svg */
        color("gray") linear_extrude(l) resize([EX,EY]) import("8020-Fractional-Profiles-1.svg");
    }
}

module euroContainer() {
    echo("BOM:euroContainer");
    color("lightgray") {
        translate([ECFSD,ECFSD,0]) cube([ECW-2*ECFSD,ECD-2*ECFSD,ECFH]);
        translate([0,0,ECFH]) cube([ECW,ECD,ECH-ECFH]);
    }
}

/* vertical extrusions: */
for (x = [0,1], y = [0,1]) {
    translate([x*(W-EX),y*(D-EY),0]) aluminumExtrusion(H);
}

/* base and top bars: */
for (z = [0,1]) {
    for (y = [0,1]) {
        translate([EX,y*(D-EY),EX+z*(H-EX)]) rotate([0,90,0]) aluminumExtrusion(W-2*EX);
    }
    for (x = [0,1]) {
        translate([x*(W-EX),EY,EY+z*(H-EY)]) rotate([-90,0,0]) aluminumExtrusion(D-2*EY);
    }
}

/* euro containers with rails: */
for (i = [0:ECN-1]) {
    translate([
        (W - 2*EX - ECW)/2 + EX,
        (D - 2*EY - ECD)/2 + EY,
        ECZ0 + i*ECZS
    ]) euroContainer();
    for (j = [0,1]) translate([EX + j*(W-3*EX),0,ECZ0 + i*ECZS + ECFH]) rotate([-90,0,0]) aluminumExtrusion(D);
}
/* inner diameter: */
ID = 90;
/* rim thickness: */
RT = 2;
/* plate thickness: */
PT = 1;
/* rim height: */
RH = 5;
/* cone bigger inner diameter: */
CBID = 10;
/* cone smaller inner diameter: */
CSID = 2;
/* cone height: */
CH = 10;
/* cone wall thickness: */
CWT = 1;
/* cone number: */
CN = 6;
/* cone radial offset: */
CRO = 25;

$fn = 100;

module cone() {
    cylinder(h=CH, d1=CBID+2*CWT, d2=CSID+2*CWT);
}
module coneHole() {
    cylinder(h=CH, d1=CBID, d2=CSID);
}

difference() {
    union() {
        /* plate with rim: */
        difference() {
            cylinder(d=ID+2*RT, h=PT+RH);
            translate([0,0,PT]) cylinder(d=ID, h=RH);
        }
        /* cones: */
        cone();
        for (i = [0:CN]) {
            rotate([0,0,i*(360/CN)]) translate([CRO,0,0]) cone();
        }
    }
    /* cone holes: */
    coneHole();
    for (i = [0:CN]) {
        rotate([0,0,i*(360/CN)]) translate([CRO,0,0]) coneHole();
    }
}
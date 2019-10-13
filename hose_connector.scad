/*
 * A hose connector with multiple conical parts.
 *
 * r0 .. inner diameter
 * r1 .. smaller outer diameter
 * r2 .. larger outer diameter
 * l  .. length of each conical part
 * N  .. number of conical parts
 */
module hose_connector(r0, r1, r2, l, N) {
    rotate_extrude() {
        for (i = [0:N-1]) {
            translate([0,i*l]) polygon([
                [r0,0],[r0,l],[r1,l],[r2,0]
            ]);
        }
    }
}

$fn=100;

CPT = 1; /* connecting plate thickness */
CPD = 20; /* connecting plate diameter */
HCO = 4.0; /* hose connector offset */
HC1_R0 = 1.75; /* r0 for hose connector 1 */
HC1_R1 = 2.50; /* r1 for hose connector 1 */
HC1_R2 = 3.00; /* r2 for hose connector 1 */
HC1_L = 2.00; /* l for hose connector 1 */
HC1_N = 4; /* N for hose connector 1 */
HC1_BR = 4.00; /* base radius for hose connector 1 */
HC1_BH = 2.00; /* base height for hose connector 1 */
//HC2_R0 = 1.00; /* r0 for hose connector 2 */
//HC2_R1 = 1.75; /* r1 for hose connector 2 */
//HC2_R2 = 2.00; /* r2 for hose connector 2 */
HC2_R0 = 1.75; /* r0 for hose connector 1 */
HC2_R1 = 2.50; /* r1 for hose connector 1 */
HC2_R2 = 3.00; /* r2 for hose connector 1 */
HC2_L = 2.00; /* l for hose connector 2 */
HC2_N = 4; /* N for hose connector 2 */
HC2_BR = 4.00; /* base radius for hose connector 2 */
HC2_BH = 2.00; /* base height for hose connector 2 */

module connectors_with_plate(second) {
    /* Connecting plate: */
    difference() {
        union() {
            cylinder(h=CPT, d=CPD);
            translate([-HCO,0,CPT]) cylinder(r=HC1_BR, h=HC1_BH);
            translate([+HCO,0,CPT]) cylinder(r=HC2_BR, h=HC2_BH);
        }
        translate([-HCO,0,0])
            cylinder(h=3*(CPT+HC1_BH), r=HC1_R0, center=true);
        translate([HCO,0,0])
            cylinder(h=3*(CPT+HC2_BH), r=HC2_R0, center=true);
    }
    /* Actual hose connectors: */
    translate([-HCO,0,CPT]) {
        translate([0,0,HC1_BH])
        hose_connector(HC1_R0, HC1_R1, HC1_R2, HC1_L, HC1_N);
    }
    if (second) {
        translate([+HCO,0,CPT]) {
            translate([0,0,HC2_BH])
            hose_connector(HC2_R0, HC2_R1, HC2_R2, HC2_L, HC2_N);
        }
    }
}

rotate([180,0,0]) connectors_with_plate(true);
connectors_with_plate(false);
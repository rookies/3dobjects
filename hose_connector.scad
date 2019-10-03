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
HCO = 4.5; /* hose connector offset */
HC1_R0 = 2; /* r0 for hose connector 1 */
HC1_R1 = 3; /* r1 for hose connector 1 */
HC1_R2 = 3.5; /* r2 for hose connector 1 */
HC1_L = 2; /* l for hose connector 1 */
HC1_N = 5; /* N for hose connector 1 */
HC2_R0 = 2; /* r0 for hose connector 2 */
HC2_R1 = 3; /* r1 for hose connector 2 */
HC2_R2 = 3.5; /* r2 for hose connector 2 */
HC2_L = 2; /* l for hose connector 2 */
HC2_N = 5; /* N for hose connector 2 */

/* Connecting plate: */
difference() {
    cylinder(h=CPT, d=CPD);
    translate([-HCO,0,0])
        cylinder(h=3*CPT, r=HC1_R0, center=true);
    translate([HCO,0,0])
        cylinder(h=3*CPT, r=HC2_R0, center=true);
}
/* Actual hose connectors: */
translate([-HCO,0,CPT])
    hose_connector(HC1_R0, HC1_R1, HC1_R2, HC1_L, HC1_N);
translate([HCO,0,CPT])
    hose_connector(HC2_R0, HC2_R1, HC2_R2, HC2_L, HC2_N);
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
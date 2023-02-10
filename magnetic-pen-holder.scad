/* https://help.prusa3d.com/article/insert-pause-or-custom-g-code-at-layer_120490#insert-pause-at-layer */

/* all in mm */
H = 20; /* height */
PD = 9; /* pen diameter */
WT = 2; /* wall thickness */
BW = 18; /* base width */
BT = 1; /* base thickness */
MT = 5 + 1; /* magnet thickness */
MD = 10 + 1; /* magnet diameter */
WTUM = 1; /* wall thickness under magnet */
SW = 2; /* slit width */

CD = PD + 2*WT; /* cylinder diameter */
CT = MT + WTUM; /* cube thickness */

difference() {
    hull() {
        cylinder(d=CD, h=H);
        translate([CD/2+MT+WTUM-BT, -BW/2, 0]) cube([BT, BW, H]);
    }
    /* pen hole: */
    cylinder(d=PD, h=H);
    /* slit: */
    translate([-CD/2-WT/2, -SW/2, 0]) cube([2*WT, SW, H]);
    /* magnet cavity: */
    translate([CD/2, 0, H/2]) rotate([0, 90, 0]) cylinder(d=MD, h=MT);
}
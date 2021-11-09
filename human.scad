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

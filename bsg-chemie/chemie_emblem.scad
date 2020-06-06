W=100; /* width */
H=148.504; /* height */
P=5; /* padding */
O=20; /* tip offset */
HD=30; /* holder diameter */
HHD=15; /* holder hole diameter */

color("gray") linear_extrude(2) {
    polygon([[-P,-P+O], [W/2,-P], [W+P,-P+O], [W+P,H+P], [-P,H+P]]);
    translate([W/2,H+HD/2,0]) difference() {
        circle(d=HD);
        circle(d=HHD);
    }
}
color("green")
    translate([0,0,2])
    linear_extrude(2)
    import("chemie_bw.svg");
$fn=100;
linear_extrude(1) translate([100,100,0]) difference() {
        circle(100);
        circle(90);
    }
linear_extrude(2) import("chemie_bw_c2.svg");
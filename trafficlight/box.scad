module crossCircle(r) {
    crossWidth = .5;
    difference() {
        circle(r);
        translate([-crossWidth/2, -r, 0])
            square([crossWidth, 2*r]);
        translate([-r, -crossWidth/2, 0])
            square([2*r, crossWidth]);
    }
}

module doubleCircleWithText(rOuter, rInner, text) {
    translate([rOuter,rOuter,0]) difference() {
        circle(rOuter);
        crossCircle(rInner);
     }
     translate([rOuter,0,0])
        text(text, 3, "Arial", halign="center", valign="top");
     color("Black");
}

difference() {
    square([180,60]);
    // DMX connectors
    translate([120,3,0]) union() {
        // DMX in
        difference() {
            square([22,35]);
            translate([11,17.5,0])
                crossCircle(9.5);
            translate([11,3,0])
                text("DMX in 19", 3, "Arial", halign="center");
        }
        // DMX out
        translate([24,0,0]) difference() {
            square([26,35]);
            translate([13,17.5,0])
                crossCircle(10.5);
            translate([13,27.7,0])
                square([10,2], center=true);
            translate([13,3,0])
                text("DMX out 21", 3, "Arial", halign="center");
        }
    }
    // lights connector
    translate([101,5,0])
        doubleCircleWithText(8.5, 6, "lights 12");
    // power input unit
    translate([10,5,0]) union() {
         // fuseholder
        translate([0,16,0])
            doubleCircleWithText(8, 5.5, "fuse 11");
        // power connector
        translate([2,0,0])
            doubleCircleWithText(6, 4, "pwr 8");
    }
}

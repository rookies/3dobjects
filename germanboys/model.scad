linear_extrude(2) {
    difference() {
        scale(3) import("hand.svg");
        translate([57,7]) circle(d=4, $fn=20);
    }
}

!color("red") union() {
    translate([-4,-19.1,2]) linear_extrude(1) scale(.1429) import("hand_layer2.svg");
    translate([61,59,2]) linear_extrude(1) rotate([0,0,105]) text("German", size=8);
    translate([77,64,2]) linear_extrude(1) rotate([0,0,79]) text("Boys", size=8);
}
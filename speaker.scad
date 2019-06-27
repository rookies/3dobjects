N = 5;
D_SPEAKER = 80;

for (i = [0:N-1]) {
    rotate([0,0,i*360/N]) translate([0,100,0]) difference() {
        translate([0,0,-200]) cube([126,18,500], center=true);
        rotate([90,0,0]) {
            cylinder(20, d=D_SPEAKER, center=true);
        }
    }
}
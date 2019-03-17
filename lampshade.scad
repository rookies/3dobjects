PLATE_THICKNESS = 2;
CAPNUT_HEIGHT = 8;
CAPNUT_R1 = 3;
CAPNUT_R2 = 4;
CAPNUT_HEXHEIGHT = 3.5;
R1 = 150;
R2 = 50;
N = 30;
D = 12;
M = 5;
alpha = 5;
TUBE_DIAMETER = 6;

L = N*D;
a = 2*(R1-R2)/pow(L,3);
b = 3*(R2-R1)/pow(L,2);
c = 0;
d = R1;

outerRadii = [for (i = [0:N-1])
    a*pow(i*D,3)+b*pow(i*D,2)+c*i*D+d];
innerRadii = [for (r = outerRadii)
    r - 30];
middleRadii = [for (i = [0:N-1])
    (outerRadii[i] + innerRadii[i])/2];

module capNut() {
    cylinder(
        h=CAPNUT_HEXHEIGHT,
        r=CAPNUT_R2,
        center=false,
        $fn=6
    );
    translate([0,0,CAPNUT_HEIGHT-CAPNUT_R1])
        sphere(
            r=CAPNUT_R1,
            $fn=50
        );
    cylinder(
        h=CAPNUT_HEIGHT-CAPNUT_R1,
        r=CAPNUT_R1,
        center=false,
        $fn=50
    );
}

module plateRing(dInner, dOuter) {
    difference() {
        cylinder(
            h=PLATE_THICKNESS,
            d=dOuter,
            center=false
        );
        cylinder(
            h=PLATE_THICKNESS,
            d=dInner,
            center=false
        );
    }
}

for (i = [0:N-1]) {
    translate([0,0,i*D])
        plateRing(
            dInner=2*innerRadii[i],
            dOuter=2*outerRadii[i]
        );
    for (j = [0:M-1]) {
        if (i != 0) {
            rotate([0,0,i*alpha + j*(360/M)]) translate([middleRadii[i],0,i*D]) translate([0,0,PLATE_THICKNESS]) capNut();
        }
        if (i != N-1) {
            rotate([0,0,(i+1)*alpha + j*(360/M)]) translate([middleRadii[i],0,i*D]) {
                rotate([0,180,0]) capNut();
                cylinder(
                    h=D,
                    d=TUBE_DIAMETER,
                    center=false,
                $fn=50
                );
            }
        }
    }
}
PSW = 97; // power supply width
PSD = 30; // power supply depth
PSH = 129; // power supply height
WT = 2; // wall thickness
DWT = 2*WT; // double wall thickness
S = .5; // spacing between part & power supply
DS = 2*S; // double spacing
PHM = 40; // maximum protector height
//PH

// power supply:
//color("lightgray") cube([PSW,PSD,PSH]);

// actual part:
color("red") {
    translate([-(WT+S),-(WT+S),-(WT+S)]) difference() {
        // full cube:
        cube([PSW+DWT+DS,PSD+DWT+DS,PHM]);
        // remove everything but the walls:
        translate([WT,WT,WT]) cube([PSW+DS,PSD+DS,PHM]);
    }
}
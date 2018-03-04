/* pol2cart
 * convert polar coordinates to cartesian
*/
function pol2cart(r, phi) = [ r*cos(phi), r*sin(phi) ];
/* catAlternating
 * concatenate two lists alternating
 * Note: If the two lists have different lengths, the
 *   function stops at the end of the shorter list.
*/
function catAlternating(L1, L2) = [
    for (i = [0 : (2*min(len(L1), len(L2)) - 1)])
        (i % 2 == 0)?L1[floor(i / 2)]:L2[floor(i / 2)]
];

module triangleGear(radius, teeth, depth) {
    phiStep = 360/teeth;
    outerPoints = [ for (i = [0 : teeth-1])
        pol2cart(radius, i * phiStep) ];
    innerPoints = [ for (i = [0 : teeth-1])
        pol2cart(radius - depth, (i + 0.5) * phiStep) ];
    polygon(catAlternating(outerPoints,innerPoints));
}

linear_extrude(5) difference() {
    triangleGear(100, 50, 10);
    square([20,20], center=true);
}
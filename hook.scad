$fn = 20;

W = 30; /* width */
H = 60; /* height */
WT = 2; /* wall thickness */
D1 = 10; /* distance 1 */
D2 = 20; /* distance 2 */
H1 = 30; /* height 1 */
H2 = 30; /* height 2 */
CR = 1; /* corner radius */

linear_extrude(W) minkowski() {
    polygon([
        [0,0],
        [D1+2*WT+2*CR,0],
        [D1+2*WT+2*CR,-H+WT],
        [D1+2*WT+D2+4*CR,-H+WT],
        [D1+2*WT+D2+4*CR,-H+H2],
        [D1+3*WT+D2+4*CR,-H+H2],
        [D1+3*WT+D2+4*CR,-H],
        [D1+WT+2*CR,-H],
        [D1+WT+2*CR,-WT],
        [WT,-WT],
        [WT,-H1],
        [0,-H1],
    ]);
    circle(r=CR);
}
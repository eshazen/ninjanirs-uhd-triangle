//
// another try at hex lattice
//

a = 4*sqrt(3);
h = 6;

n = 5;

thk = 0.8;
wid = 1.2;

// draw a "star" from a virtex
module star() {
  for( th = [0:120:240])
    rotate( [0, 0, th])
      translate( [0, -wid/2, 0])
      cube( [a, wid, thk]);
}

star();
translate( [0, 2*h, 0]) star();
translate( [1.5*a, h, 0]) star();

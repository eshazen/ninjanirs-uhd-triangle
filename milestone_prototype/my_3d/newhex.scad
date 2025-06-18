//
// another try at hex lattice
//

hex_c2c = 12;			/* center-to-center distance */
hex_a = hex_c2c/3*sqrt(3);
hex_h = hex_c2c/2;

hex_thk = 0.8;
hex_wid = 1.2;

// draw an attachment donut
module donut() {
  color("violet") cylinder( h=hex_thk, d=3);
}

// draw a "star" from a virtex
module star() {
  for( th = [0:120:240])
    rotate( [0, 0, th])
      translate( [0, -hex_wid/2, 0])
      cube( [hex_a, hex_wid, hex_thk]);
}

module hexl( rows, cols) {
  hex_off_x = -3*hex_a*(cols/2);
  hex_off_y = -2*hex_h*(rows/2);
  translate( [hex_off_x, hex_off_y, 0])
  for( k = [0:cols]) {
    translate( [3*hex_a*k, 0, 0])
      for( i = [0:rows]) {
	translate( [0, 2*hex_h*i, 0]) {
	  star();
	  if( (i%2) == 0) {
	    if( (i%4) == 0) { 
	      translate( [hex_a, 0, 0])	donut();
	    } else {
	      translate( [hex_a, hex_h, 0]) donut();
	    }
	    translate( [1.5*hex_a, hex_h, 0]) star();
	  }
	}
      }
  }
}

//
// another try at hex lattice
//

hex_c2c = 12;			/* center-to-center distance */
hex_a = hex_c2c/3*sqrt(3);	/* edge length */
hex_h = hex_c2c/2;

hex_thk = 0.8;
hex_wid = 1.2;

// draw an attachment donut
module donut() {
  cylinder( h=hex_thk, d=5);
}

// draw a donut hole
module donut_hole() {
  translate( [0, 0, -e])
    cylinder( h=hex_thk+2*e, d=gpeg_dia);
}

// draw a "star" from a virtex
module star() {
  for( th = [0:120:240])
    rotate( [0, 0, th])
      translate( [0, -hex_wid/2, 0])
      cube( [hex_a, hex_wid, hex_thk]);
}

module hexl( rows, cols) {
  difference() {
    hexl_mesh( rows, cols);
    hexl_holes( rows, cols);
  }
}

module hexl_mesh( rows, cols) {
  // calculate approximate center and move there
  hex_off_x = -3*hex_a*(cols/2);
  hex_off_y = -2*hex_h*(rows/2);
  translate( [hex_off_x, hex_off_y, 0]) {
    // loop over columns
    for( k = [0:cols]) {
      translate( [3*hex_a*k, 0, 0]) {
	// loop over rows
	for( i = [0:rows]) {
	  translate( [0, 2*hex_h*i, 0]) {
	    star();
	    translate( [1.5*hex_a, hex_h, 0]) star();
	    translate( [hex_a, hex_c2c, 0]) {
		if( !(i%2) && !(k%2)) donut();
		if( i%2 && k%2) donut();
	    }
	  }
	}
      }
    }
  }
}

module hexl_holes( rows, cols) {
  // calculate approximate center and move there
  hex_off_x = -3*hex_a*(cols/2);
  hex_off_y = -2*hex_h*(rows/2);
  translate( [hex_off_x, hex_off_y, 0]) {
    // loop over columns
    for( k = [0:cols]) {
      translate( [3*hex_a*k, 0, 0]) {
	// loop over rows
	for( i = [0:rows]) {
	  translate( [0, 2*hex_h*i, 0]) {
	    translate( [hex_a, hex_c2c, 0]) {
		if( !(i%2) && !(k%2)) donut_hole();
		if( i%2 && k%2) donut_hole();
	    }
	  }
	}
      }
    }
  }
}


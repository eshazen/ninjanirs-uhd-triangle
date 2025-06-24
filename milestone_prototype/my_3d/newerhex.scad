//
// David's new lattice
//

// the order of these may be important
include <geom.scad>
include <spring.scad>
// include <optode.scad>
include <optode_hollow.scad>
include <springtop.scad>

include <grommet.scad>
include <cap.scad>

$fn = 8;

e = 0.1;
gpeg_dia = 3;

hex_c2c = 24;			/* center-to-center distance */
hex_a = hex_c2c/3*sqrt(3);	/* edge length */
hex_h = hex_c2c/2;

echo("a = ", hex_a);

hex_thk = 0.8;
hex_wid = 1.2;

module optode_model() {
  color("blue") cylinder( d=8.75, h=2);
}

// draw an attachment donut for detector triad
module detector() {
  //grommets();
  color("black") cylinder( h=hex_thk, d=5);
  // sketch the optodes
  translate( [hex_a/4, hex_h/2, 0]) optode_model();
  translate( [-hex_a/2, 0, 0]) optode_model();
  translate( [hex_a/4, -hex_h/2, 0]) optode_model();
}



// draw a donut hole
module detector_hole() {
  translate( [0, 0, -e])
    cylinder( h=hex_thk+2*e, d=gpeg_dia);
}

// draw an attachment donut for source optode
module source() {
  color("red") cylinder( h=hex_thk, d=8.75);
}

module source_hole() {
  translate( [0, 0, -e])
    cylinder( h=hex_thk+2*e, d=6.75);
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
	    source();
	    translate( [hex_a/2, hex_h, 0]) {
	      detector();
	      star();
	    }
	    translate( [1.5*hex_a, hex_h, 0]) {
	      star();
	      source();
	      translate( [hex_a/2, hex_h, 0]) {
		detector();
		star();
	      }
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
	    source_hole();
	    translate( [hex_a/2, hex_h, 0]) detector_hole();
	    translate( [1.5*hex_a, hex_h, 0]) {
	      source_hole();
	      translate( [hex_a/2, hex_h, 0]) detector_hole();

	    }
	  }
	}
      }
    }
  }
}


difference() {
  hexl_mesh( 5, 5);
  hexl_holes( 5, 5);
}


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

$fn = 64;

e = 0.1;
gpeg_dia = 3;

hex_c2c = 24;			/* center-to-center distance */
hex_a = hex_c2c/3*sqrt(3);	/* edge length */
hex_h = hex_c2c/2;

hex_thk = 0.8;
hex_wid = 1.2;

show_grommets = 1;
show_optodes = 0;

rows = 3;
cols = 1;

mesh_color = "#006000";

module optodes( spread, cap) {
  optode_down = -body_hgt-0.5;
  // 3-way symmetry
  color("gray")
  for( a=[0:120:240]) {
    rotate( [0, 0, a]) {
      translate( [spread*ring_offset, 0, optode_down]) {
	if( cap == 2 || cap == 3) {
	  if( a == 0) {
	    optode( 0, 4, 150, 2, 210, 2);
	  } else if( a == 120) {
	    optode( 210, 2, 0, 0, 0, 0);
	  } else {
	    optode( 150, 2, 0, 0, 0, 0);
	  }
	}
	if( cap == 1 || cap == 3)
	  cap();
      }
    }
  }
}

// draw an attachment donut for detector triad
module detector() {
     rotate( [0, 0, 60]) {
	  if( show_grommets)
	       color("#909050") translate( [0, 0, 4.5]) grommets();
	  if( show_optodes)
	  translate( [0, 0, 16]) {
	       color("#808080") optodes(1,3);
	       springtop();
	  }

     }
     color( mesh_color) cylinder( h=hex_thk, d=5);
}



// draw a donut hole
module detector_hole() {
  translate( [0, 0, -e])
    cylinder( h=hex_thk+2*e, d=gpeg_dia+0.2);
}

// draw an attachment donut for source optode
module source() {
  color("red") cylinder( h=hex_thk, d=ghole_dia+2);
}

module source_hole() {
  translate( [0, 0, -e])
    cylinder( h=hex_thk+2*e, d=ghole_dia);
}

// draw a "star" from a virtex
module star() {
     color(mesh_color)
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

echo("hex_a = ", hex_a);
echo("ghole_dia = ", ghole_dia);

// rotate([180, 0, 0])
difference() {
  hexl_mesh( rows, cols);
  hexl_holes( rows, cols);
}


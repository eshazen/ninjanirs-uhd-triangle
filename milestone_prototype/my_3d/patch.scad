$fn=32;

// the order of these may be important
include <spring.scad>
// include <optode.scad>
include <optode_hollow.scad>
include <springtop.scad>

// this is OK at 3X scale but not at 1X

ghole_dia = 7.25;
// ghole_dia = 7.5;   // pretty loose fit at 1x with 0.2mm nozzle high res

include <grommet.scad>

include <cap.scad>

module optodes( spread, cap) {
  // 3-way symmetry
  for( a=[0:120:240]) {
    rotate( [0, 0, a]) {
      translate( [spread*ring_offset, 0, -body_hgt-0.5]) {
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

// scale up for big print
big = 1;
plate = 0;
mesh = 1;
optode_assembly = 0;

module triplet() {
  if( optode_assembly) {
    color("#909050") translate( [0, 0, -11]) grommets();
    color("red") translate( [0, 0, groove_offset+groove_wid/2-gpeg_len-gtop_hgt+e-11]) clip();
    color("white") springtop();
    color("grey")optodes( 1, 3);
    color("blue") rotate([ 0, 0, 90]) translate([0, 0, arm_raise-spring_len-2.2]) spring();
    //   // flexi circuit
    //   rotate( [0, 0, 90]) translate( [-146.5, 73.8, -8])   color("green") import("hpk_5mm.stl",10);
  }
  //   // cap
  color("violet") cap_triad();
}


scale( [big, big, big]) {

  if( plate == 1) { // ---------- for printing individual parts ----------
    // optode( 0, 4, 150, 2, 210, 2);  // two-opening
    // optode( 210, 2, 0, 0, 0, 0);       // single opening
    // optodes( 2, 2);
    // springtop();
    // rotate( [0, 0, 90]) translate( [-146.5, 73.8, -8]) import("hpk_5mm.stl",10);
    grommets();

  } else {  // ---------- for viewing ----------

    triplet();
    if( mesh) {
      translate( [12*sqrt(3), 0, 0]) triplet();
      translate( [-12*sqrt(3), 0, 0]) triplet();
      translate( [-12*sqrt(3)/2, 12*1.5, 0]) triplet();
      translate( [12*sqrt(3)/2, 12*1.5, 0]) triplet();
    }
  }
}

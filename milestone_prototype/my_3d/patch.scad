$fn=128;

// the order of these may be important
include <spring.scad>
include <optode.scad>
// include <optode_hollow.scad>
include <springtop.scad>

// this is OK at 3X scale but not at 1X

ghole_dia = 7.25;
// ghole_dia = 7.5;   // pretty loose fit at 1x with 0.2mm nozzle high res

include <grommet.scad>

module optodes( spread) {
  // 3-way symmetry
  for( a=[0:120:240]) {
    rotate( [0, 0, a]) {
      translate( [spread*ring_offset, 0, -body_hgt-0.5]) 
	if( a == 0) {
	  optode( 0, 4, 150, 2, 210, 2);
	} else if( a == 120) {
	  optode( 210, 2, 0, 0, 0, 0);
	} else {
	  optode( 150, 2, 0, 0, 0, 0);
	}
    }
  }
}

// scale up for big print
big = 1;

scale( [big, big, big]) {

//   color("#909050") translate( [0, 0, -11]) grommets();
   color("white") springtop();
 //color("red")
   //     optode();
//     optodes( 2);
//	  optode( 0, 4, 150, 2, 210, 2);

// color("blue") rotate([ 0, 0, 90]) translate([0, 0, arm_raise-spring_len-2.2]) spring();

// rotate( [0, 0, 90]) translate( [-146.5, 73.8, -8])   color("green") import("hpk_5mm.stl",10);
}

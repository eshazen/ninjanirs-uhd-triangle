// basic geometry
include <geom.scad>

// ---------- Settings for rendering ----------
big = 1;			/* overall scale */
plate = 0;			/* flag: individual parts for 3D print plate */
mesh = 1;			/* generate a mesh */
optode_assembly = 1;		/* generate the optodes */
spo = 0;			/* spread for optodes from nominal positions */
sources = 0;			/* generate source optodes */

// the order of these may be important
include <spring.scad>
// include <optode.scad>
include <optode_hollow.scad>
include <springtop.scad>

include <grommet.scad>
include <cap.scad>
include <newhex.scad>

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
  if( sources) {
    translate( [-6*sqrt(3)-3, 0, optode_down]) {
      color("#c00000") {
	optode( 0, 0, 0, 0, 0, 0);
	cap();
      }
    }
  }
    
}

module triplet() {
  if( optode_assembly) {
    color("#909050") translate( [0, 0, -11]) grommets();
    color("red") translate( [0, 0, groove_offset+groove_wid/2-gpeg_len-gtop_hgt+e-11]) clip();
    color("white") springtop();
    optodes( 1, 3);
    color("blue") rotate([ 0, 0, 90]) translate([0, 0, arm_raise-spring_len-2.2]) spring();
    //   // flexi circuit
     //       rotate( [0, 0, 90]) translate( [-146.5, 73.8, -7])   color("green") import("hpk_5mm.stl",10);
  }
  //   // cap
  //  color("violet") cap_triad();
}

// coords for 7 patches
pat_coords = [ [center_dist*sqrt(3)+spo, center_dist+spo, 0],
	       [center_dist*sqrt(3)+spo, -center_dist-spo, 0],
	       [-center_dist*sqrt(3)-spo, center_dist+spo, 0],
	       [-center_dist*sqrt(3)-spo, -center_dist-spo, 0],
	       [0, -2*center_dist-2*spo, 0],
	       [0, 2*center_dist+2*spo, 0] ];

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
      for( c  = pat_coords)
	translate( [c[0], c[1], 0]) triplet();
    }
  }
}


//translate ([-hex_a, 0, -body_hgt-8.1])
translate ([-hex_a, 0, -body_hgt-10.1])
hexl( 6, 4);




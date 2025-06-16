//
// section of simulated ninjaCap material
//

cap_hole_dia = gbody_dia;
cap_ring_wid = 1.6;
cap_thick = 1.0;

cap_mesh_wid = 0.7;

module test_triangle() {
  color("red") linear_extrude( height=cap_thk)
    polygon( points = [[6*sqrt(3)-3, 0], [-3, -6], [-3, 6]]);
}

// one ring for either source or detector
module cap_ring() {
  // optode ring
  difference() {
    cylinder( d=cap_hole_dia+2*cap_ring_wid, h=cap_thick);
    translate( [0, 0, -e])
      cylinder( d=cap_hole_dia, h=cap_thick+2*e);
  }
  cap_mesh();
}

// generate attachment tabs to merge into continuous mesh
module cap_mesh() {
     for( a=[0:60:300]) {
	  rotate( [0, 0, a])
	  translate( [-cap_mesh_wid/2, cap_hole_dia/2+cap_ring_wid-e, 0])
	       cube( [cap_mesh_wid, 1, cap_thick]);
     }
}

module cap_triad_with_center() {
     for( a=[0:120:240]) {
	  rotate( [0, 0, a]) {
	       translate( [ring_offset, 0, 0]) {
		 cap_ring();
	       }
	  }
     }
     // center attach ring
     cylinder( d=gpeg_dia+2*cap_ring_wid, h=cap_thick);
}

module cap_triad_rings() {
     difference() {
	  cap_triad_with_center();
	  for( a=[0:120:240]) {
	       rotate( [0, 0, a]) {
		    translate( [ring_offset, 0, -e]) {
			 cylinder( d=cap_hole_dia, h=cap_thick+2*e);
		    }
	       }
	  }
	  translate( [0, 0, -e])
	       cylinder( d=gpeg_dia, h=cap_thick+2*e);
     }
}

module cap_triad() {
     translate( [0, 0, -body_hgt-8.1]) {
	  cap_triad_rings();
	  translate( [-6*sqrt(3)-3, 0, 0])
	    cap_ring();
     }
     //     color("red") test_triangle();
}


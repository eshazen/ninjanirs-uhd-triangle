//
// section of simulated ninjaCap material
//

cap_hole_dia = gbody_dia;
cap_ring_wid = 1.5;
cap_thick = 1.5;

cap_mesh_wid = 1.5;

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
		    // optode ring
		    cylinder( d=cap_hole_dia+2*cap_ring_wid, h=cap_thick);
		    cap_mesh();
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
     }
}


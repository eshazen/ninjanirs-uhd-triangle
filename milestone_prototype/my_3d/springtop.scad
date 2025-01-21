$fn=128;
e = 0.1;
  
ring_dia = 6.5;
ring_hole = 3.5;

ring_offset = 7.51;

hub_dia = 5;
hub_hole = 1.5;

thick = 1.5;

arm_wid = 5.0;

//for now, fudge these
arm_raise = 6;
arm_angle = 60;

module ring() {
  difference() {
    cylinder( d=ring_dia, h=thick);
    translate( [0, 0, -e])
      cylinder( d=ring_hole, h=thick+2*e);
  }
}

module rings() {
  // 3-way symmetry
  for( a=[0:120:240]) {
    rotate( [0, 0, a]) {
      // generate ring
      translate( [ring_offset, 0, 0]) ring();
      // generate arm, sloping upwards
      elen = sqrt(ring_offset*ring_offset+arm_raise*arm_raise);
      translate( [ring_hole/4, -arm_wid/2, arm_raise])
	rotate( [0, arm_angle, 0])
      	cube( [elen-ring_hole/4-ring_hole/2, arm_wid, thick]);
    }
  }
}

// hub with spring attach
module hub() {
  difference() {
    cylinder( d=hub_dia, h=thick);
  }
  translate( [0, 0, -attach_ring_dia/3])
       rotate( [0, 180, 0])
  spring_attach();
}

module springtop() {
  translate( [0, 0, arm_raise])  hub();
  rings();
}




$fn=128;

mm = 25.4;

spring_dia = 0.094*mm;
spring_len = 0.5*mm;
wire_dia = 0.012*mm;
attach_wire_dia = 0.75;
attach_ring_dia = 4;

coil_len = spring_len - 2*spring_dia;

module hook() {
  rotate( [90, 0, 0]) {
    translate( [0, 0, -wire_dia/2]) {
      difference() {
	cylinder( h=wire_dia, d=spring_dia);
	translate( [0, 0, -e])
	  cylinder( h=wire_dia+2*e, d=spring_dia-2*wire_dia);
	// make it a hook
	rotate( [0, 0, -90])
	translate( [0, 0, -wire_dia-e])
	  cube( [spring_dia+wire_dia+e, spring_dia+wire_dia+e, wire_dia*2+2*e]);
      }
    }
  }
}

// define a module to create a ring to hook the spring onto
module spring_attach() {
  rotate( [90, 0, 0]) {
    translate( [0, 0, -attach_wire_dia/2]) {
      difference() {
	cylinder( h=attach_wire_dia, d=attach_ring_dia);
	translate( [0, 0, -e])
	  cylinder( h=attach_wire_dia+2*e, d=attach_ring_dia-2*attach_wire_dia);
      }
    }
  }
}
  

// spring with hooks
module spring() {
  translate( [0, 0, spring_dia])
    cylinder( h=coil_len, d=spring_dia);
  // generate hooks
  translate( [0, 0, spring_dia/2])
        rotate( [0, -90, 180])
    hook();
  translate( [0, 0, spring_len-spring_dia/2])
    hook();
}

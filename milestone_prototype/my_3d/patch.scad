
include <optode.scad>
include <springtop.scad>
include <spring.scad>
include <grommet.scad>

module optodes() {
  // 3-way symmetry
  for( a=[0:120:240]) {
    rotate( [0, 0, a]) {
      translate( [ring_offset, 0, -body_hgt-0.5]) optode();
    }
  }
}

color("#404040") translate( [0, 0, -11]) grommets();
color("white") springtop();
color("red") optodes();
color("blue") translate([0, 0, 1.5*thick-spring_len]) spring();




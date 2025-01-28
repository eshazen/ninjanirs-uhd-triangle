
// the order of these may be important
include <spring.scad>
// include <optode.scad>
include <optode_hollow.scad>
include <springtop.scad>
include <grommet.scad>

module optodes() {
  // 3-way symmetry
  for( a=[0:120:240]) {
    rotate( [0, 0, a]) {
      translate( [ring_offset, 0, -body_hgt-0.5]) optode();
    }
  }
}

// scale up for big print
big = 1;

scale( [big, big, big]) {

color("#909050") translate( [0, 0, -11]) grommets();
color("white") springtop();
color("red") optodes();
// % optode();

//color("blue") rotate([ 0, 0, 90]) translate([0, 0, arm_raise-spring_len-2.2]) spring();


}

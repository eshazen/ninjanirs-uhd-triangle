//
// testing for mcmaster spring clips
//

$fn=128;

// the order of these may be important
include <spring.scad>
// include <optode.scad>
include <optode_hollow.scad>
include <springtop.scad>

// this is OK at 3X scale but not at 1X

ghole_dia = 7.25;
// ghole_dia = 7.5;   // pretty loose fit at 1x with 0.2mm nozzle high res

include <grommet.scad>

// center "rivet" peg
gpeg_len = 6;

// for McMaster clip 98410A110
gpeg_dia = 4.5;
groove_wid = 0.018*mm;
groove_dia = 0.168*mm;
groove_offset = 0.75;		/* offset from end of peg */

base_thk = 1;
base_dia = 15;

translate( [0, 0, -base_thk+e])
cylinder( d=base_dia, h=base_thk);
rotate( [180, 0, 0]) translate( [0, 0, -gpeg_len]) {
     peg(gpeg_dia, gpeg_len, groove_offset, groove_dia, groove_wid);
}

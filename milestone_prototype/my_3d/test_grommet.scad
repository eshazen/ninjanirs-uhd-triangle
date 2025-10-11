// basic geometry
include <geom.scad>

// ---------- Settings for rendering ----------
big = 1;			/* overall scale */
plate = 1;			/* flag: individual parts for 3D print plate */
mesh = 1;			/* generate a mesh */
optode_assembly = 1;		/* generate the optodes */
spo = 0;			/* spread for optodes from nominal positions */
sources = 0;			/* generate source optodes */
show_hex = 0;			/* show hex mesh */
body_solid = 1;			/* solid optode for easier printing */

// the order of these may be important
include <spring.scad>
// include <optode.scad>
include <optode_hollow.scad>
include <springtop.scad>

include <grommet.scad>
include <cap.scad>
include <newhex.scad>

// projection(cut=true) rotate( [90, 0, 0])
grommets();

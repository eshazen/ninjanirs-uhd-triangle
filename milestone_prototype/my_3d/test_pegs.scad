//
// test pegs for self-anchoring in TPU85 mesh
//
$fn = 64;
e = 0.1;

hex_thk = 1.0;			/* hex mesh printed thickness */
gpeg_dia = 3.8;			/* grommet peg diameter (currently 3.0) */
gdet_hole_dia = 3.2;		/* hole in mesh */
// center "rivet" peg
gpeg_len = 5;
groove_offset = 0.5;
groove_dia = gdet_hole_dia;
groove_wid = hex_thk;
g_shoulder = 3;		/* shoulder to support mesh */

// from grommet.scad
// generate a (positive) groove geometry for a McMaster clip
module clip_groove( dia, wid) {
  difference() {
    cylinder( h=wid, d=dia+3);
    translate( [0, 0, -e])
      cylinder( h=wid+2*e, d=dia);
  }
}

module apeg( p_dia, p_len, g_offset, g_dia, g_wid)
{
     difference() {
	  cylinder( d=p_dia, h=p_len);
	  translate( [0, 0, g_offset])
	       clip_groove( g_dia, g_wid);
     }
     translate( [0, 0, p_len-g_shoulder])
     cylinder( d=p_dia+2.5, h=g_shoulder);
}

apeg(gpeg_dia, gpeg_len, groove_offset, groove_dia, groove_wid);


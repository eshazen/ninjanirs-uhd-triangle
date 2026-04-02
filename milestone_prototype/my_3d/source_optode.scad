//
// draw a hollow source optode
//

e = 0.1;
$fn = 128;
mm = 25.4;

body_height = 0.4*mm;
peg_dia = 0.26*mm;
body_dia = 10;
body_opening = 8;

cable_slot_wid = 0.08*mm;

hollow_deep = 0.2*mm;

lg_hgt = 9.25;
lg_dia = 3.5;			/* light pipe tail diameter */

module lg() {
     cylinder( h=lg_hgt, d=lg_dia);
}

module body() {
     difference() {
	  cylinder( h=body_height, d=body_dia);
	  translate( [0, 0, body_height-hollow_deep+e])
	       cylinder( h=body_height, d=body_opening);
	  translate( [0, -cable_slot_wid/2, body_height-hollow_deep+e])
	       cube([10, cable_slot_wid, hollow_deep]);
     }
     // light guide
     translate( [0, 0, -lg_hgt])
	  lg();
}

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
//     translate( [0, 0, p_len-g_shoulder]) cylinder( d=p_dia+2.5, h=g_shoulder);
}




module source_optode() {

     body();
     // peg pointing down from origin
     translate( [0, 0, -5])
     // apeg( 7.2,    5,    0.5,    6.6,   1);
	  apeg( 7.4,    5,    0.5,    6.6,   1.2);
}


source_optode();

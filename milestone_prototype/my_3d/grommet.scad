// one "grommet"
//
// 2025-05-29- add retaining clip

e = 0.1;

// gtop_dia1 = 12.72;
// gtop_dia2 = 12.53;
// gtop_hgt = 1.5;

gtop_dia1 = 11.75;
gtop_dia2 = 11.5;
gtop_hgt = 1.5;


//gwall_thk = 0.5;
gwall_thk = 1.0;

// ghole_dia from patch.scad

gbody_dia = ghole_dia+2*gwall_thk;

gheight = 5.0;

garm_wid = 10;

// center "rivet" peg
gpeg_len = 5;

// for McMaster clip 98410A111 (1/8)
groove_wid = 0.012*mm;
groove_dia = 0.117*mm;
groove_offset = 0.75;		/* offset from end of peg */
gpeg_dia = groove_dia + 0.012*mm;

// // for McMaster clip 98410A110 (3/16)
// gpeg_dia = 4.5; // 0.177"
// groove_wid = 0.018*mm;
// groove_dia = 0.168*mm;
// groove_offset = 0.75;		/* offset from end of peg */


// hole for spring?
gcenter_hole = 1.67;

module gbody() {
  cylinder( d1=gtop_dia1, d2=gtop_dia2, h=gtop_hgt);
  translate( [0, 0, -gheight+gtop_hgt])
    cylinder( d=gbody_dia, h=gheight);
}

module grommet() {
  difference() {
    translate( [0, 0, -gtop_hgt])
      gbody();
    translate( [0, 0, -gheight-e])
      cylinder( d=ghole_dia, h=gheight+2*e);
  }
}

module grommet3() {
  for( a=[0:120:240]) {
    rotate( [0, 0, a]) {
      // generate one grommet
      translate( [ring_offset, 0, 0]) grommet();
      // generate body
      // first a cylinder around the spring attach
      translate( [0, 0, -gtop_hgt]) cylinder( h=thick, d=6);
      // then some arbitrary parts to extend support out between the rings
      translate( [1.5, 0, -gtop_hgt])
	   rotate( [0, 0, 60])
	   cube( [5, 3, thick]);
    }
  }
  // fill in the center with a small plug
  translate( [0, 0, -gtop_hgt])
    cylinder( d=2, h=thick);
}

// generate a (positive) groove geometry for a McMaster clip
module clip_groove( dia, wid) {
  difference() {
    cylinder( h=wid, d=dia+3);
    translate( [0, 0, -e])
      cylinder( h=wid+2*e, d=dia);
  }
}

module clip() {
  rotate( [0, 90, 90])
//    import("98410A110_Ring.stl");
       import("98410A111_Ring.stl");       
}

module apeg( p_dia, p_len, g_offset, g_dia, g_wid)
{
     echo("peg(", p_dia, p_len, g_offset, g_dia, g_wid);
     // option: center peg
     difference() {
	  cylinder( d=p_dia, h=p_len);
	  translate( [0, 0, g_offset])
	       clip_groove( g_dia, g_wid);
     }
}

module grommets() {
     grommet3();
     translate( [0, 0, -gpeg_len-gtop_hgt+e]) {
	  apeg(gpeg_dia, gpeg_len, groove_offset, groove_dia, groove_wid);
     }
     // option: loop to hook on spring
     translate( [-0.3, -wire_dia/2, attach_ring_dia/2-attach_wire_dia])
	  spring_attach();
}

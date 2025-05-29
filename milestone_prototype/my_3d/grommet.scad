// one "grommet"
//
// 2025-05-29- add retaining clip

e = 0.1;

gtop_dia1 = 12.72;
gtop_dia2 = 12.53;
gtop_hgt = 1.5;

//gwall_thk = 0.5;
gwall_thk = 1.0;

gheight = 5.0;

garm_wid = 10;

// center "rivet" peg
gpeg_len = 6;

// for McMaster clip 98410A110
gpeg_dia = 4.5;
groove_wid = 0.018*mm;
groove_dia = 0.168*mm;
groove_offset = 0.75;		/* offset from end of peg */

// hole for spring?
gcenter_hole = 1.67;

module gbody() {
  cylinder( d1=gtop_dia1, d2=gtop_dia2, h=gtop_hgt);
  translate( [0, 0, -gheight+gtop_hgt])
    cylinder( d=ghole_dia+2*gwall_thk, h=gheight);

  // ridges for clip
//  translate( [0, 0, -3.5])
//    cylinder( d=9, h=.5);
//  translate( [0, 0, -2])
//    cylinder( d=9, h=.5);

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
      translate( [gcenter_hole/4, -garm_wid/2, -gtop_hgt])
	cube( [ring_offset-gcenter_hole/4-ghole_dia/2, garm_wid, thick]);
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
    import("98410A110_Ring.stl");
}

module grommets() {
    difference() {
      grommet3();
      // option:  center hole
      //    translate( [0, 0, -gheight-e]) cylinder( h=gheight+2*e, d=gcenter_hole);
    }
    // option: center peg
    translate( [0, 0, -gpeg_len-gtop_hgt+e]) {
      difference() {
	cylinder( d=gpeg_dia, h=gpeg_len);
	translate( [0, 0, groove_offset])
	  clip_groove( groove_dia, groove_wid);
      }
    }
    // option: loop to hook on spring
    translate( [0, -wire_dia/2, attach_ring_dia/2-attach_wire_dia])
      spring_attach();
}

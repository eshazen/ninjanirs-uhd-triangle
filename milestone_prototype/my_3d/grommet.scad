// one "grommet"

$fn = 128;
e = 0.1;

gtop_dia1 = 12.72;
gtop_dia2 = 12.53;
gtop_hgt = 1.5;

ghole_dia = 7.2;
gwall_thk = 0.5;

gheight = 5.0;

garm_wid = 10;

gcenter_hole = 1.67;

module gbody() {
  cylinder( d1=gtop_dia1, d2=gtop_dia2, h=gtop_hgt);
  translate( [0, 0, -gheight+gtop_hgt])
    cylinder( d=ghole_dia+2*gwall_thk, h=gheight);
  translate( [0, 0, -3.5])
    cylinder( d=9, h=.5);
  translate( [0, 0, -2])
    cylinder( d=9, h=.5);
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
}

module grommets() {
    difference() {
    grommet3();
    translate( [0, 0, -gheight-e])
    cylinder( h=gheight+2*e, d=gcenter_hole);
    }
}

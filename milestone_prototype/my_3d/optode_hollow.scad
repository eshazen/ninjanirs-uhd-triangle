
$fn = 128;
e = 0.1;

body_dia = 10;
body_hgt = 10;

body_opening = 8;		/* cavity diameter for electronics */
body_floor = 1.5;		/* body floor thickness*/

tail_dia = 7;
tail_hgt = 6;

peg_dia = 3;
peg_hgt = 2.5;

lg_hgt = 8.25;
lg_dia = 5;			/* light pipe tail diameter */
lg_hol = 3;			/* light pipe hole */

lg_spc = 0;			/* zero for one light pipe */
// lg_spc = 3.2; // (for two light pipes)

module body() {
     difference() {
	  cylinder( h=body_hgt, d=body_dia);
	  translate( [0, 0, body_floor])
	       cylinder( d=body_opening, h=body_hgt);
     }
}

module tail() {
  cylinder( h=tail_hgt, d=tail_dia);
}

module peg() {
  cylinder( h=peg_hgt, d=peg_dia);
}

module lg() {
     cylinder( h=lg_hgt, d=lg_dia);
}

module optode() {
     difference() {
	  union() {
	       body();
//  translate( [0, 0, body_hgt])
//    peg();
	       translate( [0, 0, -tail_hgt])
		    tail();
	       if( lg_spc) {
		    translate( [-lg_spc/2, 0, -lg_hgt])
			 lg();
		    translate( [lg_spc/2, 0, -lg_hgt])
			 lg();
	       } else {
		    translate( [0, 0, -lg_hgt])
			 lg();
	       }
	  }
	  translate( [0, 0, -lg_hgt-e])
	       cylinder( d=lg_hol, h=30);
     }
}


//
// draw a hollow optode body with up to 3 slots for flexis
//

e = 0.1;

slot_hgt = 8;
slot_wid = 4;

cap_thk = 2;
cap_rim = 1;

body_dia = 10;
body_hgt = 10-cap_thk;

body_opening = 8;		/* cavity diameter for electronics */
body_floor = 1.5;		/* body floor thickness*/

tail_dia = 7;
tail_hgt = 6;

peg_dia = 3;
peg_hgt = 2.5;

lg_hgt = 8.25;
lg_dia = 3;			/* light pipe tail diameter */
lg_hol = 0;			/* light pipe hole (0 for none) */

lg_spc = 0;			/* zero for one light pipe */
// lg_spc = 3.2; // (for two light pipes)

module body( a1, w1, a2, w2, a3, w3) {
     difference() {
	  cylinder( h=body_hgt, d=body_dia);
	  translate( [0, 0, body_floor])
	       cylinder( d=body_opening, h=body_hgt);
	  if( w1 > 0)
	    rotate([ 0, 0, a1])
	    translate( [0, -w1/2, body_hgt-slot_hgt+e])
	      cube( [body_dia+2, w1, slot_hgt]);
	  if( w2 > 0)
	    rotate([ 0, 0, a2])
	    translate( [0, -w2/2, body_hgt-slot_hgt+e])
	      cube( [body_dia+2, w2, slot_hgt]);
	  if( w3 > 0)
	    rotate([ 0, 0, a3])
	    translate( [0, -w3/2, body_hgt-slot_hgt+e])
	      cube( [body_dia+2, w3, slot_hgt]);
	  
     }
}

module tail() {
  cylinder( h=tail_hgt, d=tail_dia);
}

module peg() {
  cylinder( h=peg_hgt, d=peg_dia);
}

module cap() {
     translate( [0, 0, body_hgt]) {
	  peg();
	  translate( [0, 0, -cap_thk+e])
	       cylinder( d=body_dia, h=cap_thk);
	  translate( [0, 0, -cap_thk-cap_rim+e])
	       cylinder( d=body_opening-0.1, h=cap_rim);
     }
}

module lg() {
     cylinder( h=lg_hgt, d=lg_dia);
}

module optode( a1, w1, a2, w2, a3, w3) {
     translate( [0, 0, -cap_thk])
     difference() {
	  union() {
	       body( a1, w1, a2, w2, a3, w3);
	       /// translate( [0, 0, body_hgt]) peg();
	       translate( [0, 0, -tail_hgt]) tail();
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
	  if( lg_hol) translate( [0, 0, -lg_hgt-e]) cylinder( d=lg_hol, h=30);
     }
}


//
// generate hexagonal lattice
//
hex_h = center_dist/2;			/* height of a triangle */
hex_d = hex_h*2;			/* center-to-center distance */
hex_a = hex_d / sqrt(3);		/* length of a side */

hex_wid = 0.5;				/* width of lattice lines */
hex_thk = 0.5;				/* thickness */

// offsets for center of adjacent hexagons
verts = [ [1.5*hex_a, hex_h], [0, 2*hex_h], [-1.5*hex_a, hex_h], 
	  [1.5*hex_a, -hex_h], [0, -2*hex_h], [-1.5*hex_a, -hex_h] ];

module regular_polygon(order = 4, r=1)
{ // default parameters give a unit square
  // first divide 360 to make a vector of angles between vertices
  angles=[ for (i = [0:order-1]) i*(360/order) ];
  // use trigonometry to calculate Cartesian coordinates
  coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
   
  polygon(coords); // generate the polygon
}

module hex() {
  difference() {
    linear_extrude( height=hex_thk)
      regular_polygon( 6, hex_a+hex_wid/2); // generate a default regular_polygon
    translate( [0, 0, -e])
      linear_extrude( height=hex_thk+2*e)
      regular_polygon( 6, hex_a-hex_wid/2);
  }
}

module hexr( order) {
  if( order == 0) {
    for( pt = verts) {
      translate( [ pt[0], pt[1], 0])
	hex();
    }
  } else {
    for( pt = verts) {
      translate( [ pt[0], pt[1], 0])
	hexr( order-1);
    }
  }
}

// hexr( 2);

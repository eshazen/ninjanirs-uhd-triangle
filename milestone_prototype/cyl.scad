$fn=64;
e = 0.1;

dia = 6;
wall = 0.5;
hgt = 10;

difference() {
  cylinder( h=hgt, d=dia);
  translate( [0, 0, -e])
    cylinder( h=hgt+2*e, d=dia-2*wall);
}

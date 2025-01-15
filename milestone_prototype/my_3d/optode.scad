
$fn = 128;
e = 0.1;

body_dia = 10;
body_hgt = 10;

tail_dia = 7;
tail_hgt = 6;

peg_dia = 3;
peg_hgt = 2.5;

lg_hgt = 8.25;
lg_dia = 2.8;
lg_spc = 3.2;

module body() {

  cylinder( h=body_hgt, d=body_dia);
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
  body();
  translate( [0, 0, body_hgt])
    peg();
  translate( [0, 0, -tail_hgt])
    tail();
  translate( [-lg_spc/2, 0, -lg_hgt])
    lg();
  translate( [lg_spc/2, 0, -lg_hgt])
    lg();
}



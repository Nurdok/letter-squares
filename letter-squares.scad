$fn = 100;

letters = [
  "א", "ב", "ג", "ד", "ה",
  "ו", "ז", "ח", "ט", "י",
  "כ", "ך", "ל", "מ", "ם",
  "נ", "ן", "ס", "ע", "פ",
  "ף", "צ", "ץ", "ק", "ר",
  "ש", "ת",
];

// Letter square constants
ls_side = 30;
ls_depth = 5;
ls_corner_radius = 5;
slider_width = 1;
slider_width_slack = 1;

// A rounded cube whose edges are culinders with rdim radius.
module roundedcube(xdim ,ydim ,zdim, rdim){
  hull(){
    translate([rdim,rdim,0]) cylinder(h=zdim,r=rdim);
    translate([xdim-rdim,rdim,0]) cylinder(h=zdim,r=rdim);
    translate([rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim);
    translate([xdim-rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim);
  }
}

// An equilateral triangle with edge length 'edge' whose center
// is in the current coordinate.
module equilateral_triangle(edge) {
    h = ls_depth / 4;
    module vertex() { cylinder(h=h, r=1); }
    perpendicular_len = edge * sqrt(3)/2;
    hull() {
        translate([-edge/2,-perpendicular_len/3,0]) {vertex();}
        translate([edge/2,-perpendicular_len/3,0]) {vertex();}
        translate([0,perpendicular_len*2/3,0]) {vertex();}
    } 
}

// A complete tile with an embossed letter.
// at the bottom.
module tile(letter) {
  difference() {
    roundedcube(ls_side, ls_side, ls_depth, ls_corner_radius);
    difference() {
    translate([ls_side/2, ls_side/2, 0]) {
        difference() {
        equilateral_triangle(edge=12); 
        equilateral_triangle(edge=8);
      }
    }
    
    }
  }
  translate([ls_side/2, ls_side/2, ls_depth]) {
      linear_extrude(height=2) {
    color([0,1,0]) text(letter, valign="center", halign="center", size=ls_side*3/4, language="he", font="Arial:normal"
         );
      }
  }
}

// A letter board with space for `size` letters.
module board(size) {
  side_margin = 2;
  side = ls_side + side_margin;
  bottom_depth = ls_depth / 2;
  module end() {
    roundedcube(side + side_margin, side + side_margin, ls_depth, ls_corner_radius);
  }
  module base() {
    hull() {
      end();
      translate([side * (size - 1), 0, 0]) { end(); }
    }
  }
  difference() {
    base();
    union() {
    for (i = [0:size-1]) {
      translate([side * i + side_margin, side_margin, bottom_depth]) {
          roundedcube(ls_side, ls_side, ls_depth, ls_corner_radius);
      }
    }
    }
  }
  for (i = [0:size-1]) {
    translate([side * i + side / 2, side / 2, bottom_depth]) {
        difference() {
          equilateral_triangle(edge=11);
          equilateral_triangle(edge=9);
        }
    }
  }
}

// A matrix of tiles for all letters.
module all_tiles(letters) {
  for (i = [0:len(letters) - 1]) {
      translate([i % 6 * (ls_side + 2), floor(i / 6) * (ls_side + 2), 0]) {
          tile(letters[i]);
      }
  }
}

all_tiles(letters);

board_sizes = [4, 5, 6];
for (i = [0:len(board_sizes)-1]) {
  translate ([0, -ls_side * 2 - (ls_side + 10) * i , 0]) { 
    board(board_sizes[i]); 
  }
}




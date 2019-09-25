$fn = 100;

// Letter square constants
ls_side = 30;
ls_depth = 5;
ls_corner_radius = 5;
slider_width = 1;
slider_width_slack = 1;

module roundedcube(xdim ,ydim ,zdim, rdim){
  hull(){
    translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
    translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);
    translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
    translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
  }
}

module slider_hole() {
  cube([slider_width, ls_side / 2, ls_depth / 2]);
}

module letter_square() {
  difference() {
    roundedcube(ls_side, ls_side, ls_depth, ls_corner_radius);
    translate([ls_side / 4 - slider_width / 2, 0, 0]) {
      //slider_hole();
    }
    translate([ls_side * 3 / 4 - slider_width / 2, 0, 0]) {
      //slider_hole();
    }
    hull(){
    translate([ls_side/2,ls_side/2 - 2,0]) {
      cylinder(h=ls_depth / 2, r1=4, r2=1, center=true);
    }
    translate([ls_side/2,ls_side/2 + 2,0]) {
      cylinder(h=ls_depth / 2, r1=4, r2=0, center=true);
    }}
  }
}

letter_square();





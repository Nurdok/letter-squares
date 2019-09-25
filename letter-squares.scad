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

module plug(r) {
  cylinder(h=ls_depth/2, r=r, center=true);
}

module triangle(edge) {
    h = ls_depth / 2;
    module vertex() { cylinder(h=h, r=1); }
    hull() {
        translate([-edge/2,-edge*sqrt(3)/4,0]) {vertex();}
        translate([edge/2,-edge*sqrt(3)/4,0]) {vertex();}
        translate([0,edge*sqrt(3)/4,0]) {vertex();}
    } 
}

module letter_square() {
  difference() {
    roundedcube(ls_side, ls_side, ls_depth, ls_corner_radius);
      /*
    translate([ls_side / 4 - slider_width / 2, 0, 0]) {
      slider_hole();
    }
    translate([ls_side * 3 / 4 - slider_width / 2, 0, 0]) {
      slider_hole();
    }*/
    difference(){
    translate([ls_side/2, ls_side/2, 0]) {
        difference(){
          
        triangle(edge=10); 
        triangle(edge=8);
      }
    }
    
    }
  }
  translate([ls_side/2, ls_side/2, ls_depth]) {
      linear_extrude(height=2) {
    text("A", valign="center", halign="center");
      }
  }
}

letter_square();
//text("א");




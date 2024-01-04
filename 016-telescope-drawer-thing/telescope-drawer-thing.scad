/* telescope-drawer-thing.scad
Author: andimoto@posteo.de
----------------------------
*/

$fn=80;
extra = 0.01;

drawerPlateThick = 20;
mountTopThickness = 10;

lowMount_x = 50;
topMount_x = 80;
mountThickness = 15;

innerDrawerHeight = 130;
mountHeight = innerDrawerHeight + drawerPlateThick - mountTopThickness;
topMountPlateThickness = 25;


module tele_holder_raw()
{
  union()
  {
    hull()
    {
      cube([lowMount_x,0.01,mountThickness]);

      translate([0,mountHeight,0])
        cube([topMount_x,0.01,mountThickness]);
    }
    translate([0,mountHeight,0])
    cube([topMount_x,mountTopThickness,mountThickness+topMountPlateThickness]);

    translate([0,125,8])
    rotate([40,0,0])
    cube([10,30,8]);

  }
}


/* tele_holder_raw(); */
module tele_holder2_raw()
{
  cube([lowMount_x,mountHeight,mountThickness]);
}

screw1dia=4;
lowScrewMoveY = 22;

module tele_holder2()
{
  difference()
  {
    tele_holder_raw();


    translate([20,lowScrewMoveY,-extra])
    union()
    {
      cylinder(r=screw1dia/2,h=mountThickness+extra*2);
      rotate([0,0,30])
      cylinder(r=8/2,h=5,$fn=6);
    }

    translate([20+14,lowScrewMoveY,-extra])
    {
      cylinder(r=screw1dia/2,h=mountThickness+extra*2);
      rotate([0,0,30])
      cylinder(r=8/2,h=5,$fn=6);
    }

    translate([20,mountHeight+mountTopThickness+extra,mountThickness + topMountPlateThickness/2])
    rotate([90,0,0])
    cylinder(r=screw1dia/2,h=mountThickness+extra*2);

    translate([topMount_x-20,mountHeight+mountTopThickness+extra,mountThickness + topMountPlateThickness/2])
    rotate([90,0,0])
    cylinder(r=screw1dia/2,h=mountThickness+extra*2);

    translate([15,40,-extra])
    cube([25,10,mountThickness+extra*2]);

    translate([15,60,-extra])
    cube([32,10,mountThickness+extra*2]);

    translate([15,80,-extra])
    cube([40,10,mountThickness+extra*2]);

    translate([15,100,-extra])
    cube([45,10,mountThickness+extra*2]);
  }
}



tele_holder2();

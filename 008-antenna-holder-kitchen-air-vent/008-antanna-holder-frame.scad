/* 008-antenna-holder-frame.scad
Author: andimoto@posteo.de
----------------------------
*/

$fn=80;
extra = 0.1;

champferDist=1;

clearance = 1; //mm
innerH = 154; //mm - add 1mm extra clearance
innerW = 154; //mm - add 1mm extra clearance
frameWallThickness = 10; //mm frame thickness

frameD = 18; //mm

screwDia = 3.2; //mm

module frame(holderScrew = true)
{
  difference()
  {
    /* ----- frame ----- */
    hull()
    {
      cube([innerW+clearance+2*frameWallThickness,
            innerH+clearance+2*frameWallThickness,
            frameD-champferDist]);
      translate([champferDist,champferDist,frameD-champferDist])
      cube([innerW+clearance+2*frameWallThickness-champferDist*2,
            innerH+clearance+2*frameWallThickness-champferDist*2,
            champferDist]);
    }
    translate([frameWallThickness,frameWallThickness,-extra/2])
    cube([innerW+clearance,
          innerH+clearance,
          frameD+extra]);
    /* ----- frame end ----- */

    if(holderScrew == true)
    {
      /* screw holes */
      translate([0,frameWallThickness+innerH/4,frameD/2])
      rotate([0,90,0])
      cylinder(r=screwDia/2, h=frameWallThickness+clearance/2+extra);

      translate([0,frameWallThickness+innerH-innerH/4,frameD/2])
      rotate([0,90,0])
      cylinder(r=screwDia/2, h=frameWallThickness+clearance/2+extra);

      translate([frameWallThickness+clearance+innerW,frameWallThickness+innerH/4,frameD/2])
      rotate([0,90,0])
      cylinder(r=screwDia/2, h=frameWallThickness+extra);

      translate([frameWallThickness+clearance+innerW,frameWallThickness+innerH-innerH/4,frameD/2])
      rotate([0,90,0])
      cylinder(r=screwDia/2, h=frameWallThickness+extra);
      /* screw holes */
    }


    extraMountingScrew();
  }
}

module extraMountingScrew()
{
  #translate([frameWallThickness+clearance+innerW-10,frameWallThickness+innerH+clearance,frameD/2])
  rotate([-90,0,0])
  cylinder(r=screwDia/2, h=frameWallThickness+extra);
  #translate([frameWallThickness+clearance+innerW-40,frameWallThickness+innerH+clearance,frameD/2])
  rotate([-90,0,0])
  cylinder(r=screwDia/2, h=frameWallThickness+extra);
}


frame();

/* 008-antenna-holder-frame.scad
Author: andimoto@posteo.de
----------------------------
*/

$fn=80;
extra = 0.1;

champferDist=1; //mm

clearance = 1; //mm
innerH = 154; //mm - add 1mm extra clearance
innerW = 154; //mm - add 1mm extra clearance
frameWallThickness = 10; //mm frame thickness

frameD = 18; //mm

screwDia = 3.2; //mm
insertDia = 4.1; //mm

grubScrewDia = 3.2; //mm

extensionLen = 250; //mm
railLen = extensionLen - 40; //mm
railDia = screwDia + 1; //mm

antennaExtensionMountW = 30; //mm
antennaExtensionLen = 120; //mm
antennaExtensionDia = 20; //mm

antennaSocketDia = 11+0.4; //mm

function getScrewDia(useInserts) = (useInserts==true) ? insertDia : screwDia ;

module frame(holderScrew = true, useInserts = true)
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

    translate([frameWallThickness,0,8])
      cube([innerW+clearance,frameWallThickness,frameD]);
    /* ----- frame end ----- */

    if(holderScrew == true)
    {
      /* screw holes */
      translate([0,frameWallThickness+innerH/4,frameD/2])
      rotate([0,90,0])
        cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+clearance/2+extra);

      translate([0,frameWallThickness+innerH-innerH/4,frameD/2])
      rotate([0,90,0])
        cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+clearance/2+extra);

      translate([frameWallThickness+clearance+innerW,frameWallThickness+innerH/4,frameD/2])
      rotate([0,90,0])
        cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+extra);

      translate([frameWallThickness+clearance+innerW,frameWallThickness+innerH-innerH/4,frameD/2])
      rotate([0,90,0])
        cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+extra);
      /* screw holes */
    }


    extraMountingScrew();
  }
}

module extraMountingScrew(useInserts = true)
{
  translate([frameWallThickness+clearance+innerW-10,frameWallThickness+innerH+clearance-extra/2,frameD/2])
  rotate([-90,0,0])
    cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+extra);
  translate([frameWallThickness+clearance+innerW-30,frameWallThickness+innerH+clearance-extra/2,frameD/2])
  rotate([-90,0,0])
    cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+extra);
}




module extensionMount(useInserts = true, mountingHoles = true)
{
  difference() {
    /* extension with champfer */
    hull()
    {
      cube([extensionLen,frameWallThickness-champferDist,frameD-champferDist*2]);
      translate([champferDist,frameWallThickness-champferDist,0])
        cube([extensionLen-champferDist,champferDist,frameD-champferDist*2]);
    }

    /* rail hole cutout */
    hull()
    {
      translate([5,-extra/2,(frameD-champferDist*2)/2])
      rotate([-90,0,0])
        cylinder(r=railDia/2, h=frameWallThickness+champferDist+extra );

      translate([railLen-railDia,-extra/2,(frameD-champferDist*2)/2])
      rotate([-90,0,0])
        cylinder(r=railDia/2, h=frameWallThickness+champferDist+extra );
    }

    if(mountingHoles == true)
    {
      /* mounting holes */
      translate([extensionLen-antennaExtensionMountW/4,-extra/2,(frameD-champferDist*2)/2])
      rotate([-90,0,0])
        cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+champferDist+extra );

      translate([extensionLen-3*antennaExtensionMountW/4,-extra/2,(frameD-champferDist*2)/2])
      rotate([-90,0,0])
        cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+champferDist+extra );
    }
  }
}

module antennaMount(grubScrew = true)
{
  difference()
  {
    union() //antennaMount extension
    {
      /* mounting plate */
      cube([antennaExtensionMountW,frameWallThickness,frameD-champferDist*2]);

      /* trapeze; connection between mounting plate and extension */
      hull()
      {
        translate([0,0,frameD-champferDist*3])
          cube([antennaExtensionMountW,frameWallThickness,champferDist]);
        translate([(antennaExtensionMountW-antennaExtensionDia)/2,0,frameD-champferDist*4+10])
          cube([antennaExtensionDia,frameWallThickness,champferDist]);
      }

      /* extension with hole for antenna */
      hull()
      {
        translate([(antennaExtensionMountW-antennaExtensionDia)/2,0,frameD-champferDist*4+10])
          cube([antennaExtensionDia,frameWallThickness,champferDist]);
        translate([antennaExtensionMountW/2,0,frameD-champferDist*3+10+antennaExtensionLen-antennaExtensionDia/2])
          rotate([-90,0,0])
          cylinder(r=antennaExtensionDia/2, h=frameWallThickness);
      }
    }



    /* screw holes for mounting antenna mount extension to other extension; holes are 1mm wider */
    translate([antennaExtensionMountW-antennaExtensionMountW/4,-extra/2,(frameD-champferDist*2)/2])
    rotate([-90,0,0])
      cylinder(r=(screwDia+1)/2, h=frameWallThickness+champferDist+extra );

    translate([antennaExtensionMountW-3*antennaExtensionMountW/4,-extra/2,(frameD-champferDist*2)/2])
    rotate([-90,0,0])
      cylinder(r=(screwDia+1)/2, h=frameWallThickness+champferDist+extra );

    /* rail hole */
    hull()
    {
      translate([antennaExtensionMountW/2,-extra/2,frameD-champferDist*3+antennaExtensionLen-antennaExtensionDia])
        rotate([-90,0,0])
        cylinder(r=railDia/2, h=frameWallThickness+extra);
      translate([antennaExtensionMountW/2,-extra/2,frameD-champferDist*3+antennaExtensionDia])
        rotate([-90,0,0])
        cylinder(r=railDia/2, h=frameWallThickness+extra);
    }

    /* antenna hole */
    translate([antennaExtensionMountW/2,-extra/2,frameD-champferDist*3+10+antennaExtensionLen-antennaExtensionDia/2])
      rotate([-90,0,0])
      cylinder(r=antennaSocketDia/2, h=frameWallThickness+extra);

    if(grubScrew == true)
    {
      translate([antennaExtensionMountW/2,frameWallThickness/2,frameD-champferDist*3+10+antennaExtensionLen-antennaExtensionDia/2])
        rotate([0,45,0])
        cylinder(r=grubScrewDia/2, h=frameWallThickness+extra);

      translate([antennaExtensionMountW/2,frameWallThickness/2,frameD-champferDist*3+10+antennaExtensionLen-antennaExtensionDia/2])
        rotate([0,-45,0])
        cylinder(r=grubScrewDia/2, h=frameWallThickness+extra);
    }
  }
}


/* #################################################################### */
/* ######################Model######################################### */
/* #################################################################### */

if(1)
{
  frame();
  translate([innerW-frameWallThickness*2+clearance-20,innerH+clearance+frameWallThickness*2,champferDist])
  {
    extensionMount();
//antennaExtensionMountW
    translate([extensionLen-antennaExtensionMountW,frameWallThickness,0])
    antennaMount();
  }
}


/* antennaMount(true); */

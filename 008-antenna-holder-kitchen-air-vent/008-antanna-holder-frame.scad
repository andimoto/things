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

frameThickness = 18; //mm - frame thickness ( z value )

screwDia = 3.2; //mm
insertDia = 4.1; //mm

grubScrewDia = 3.2; //mm

extensionLen = 250; //mm
extensionThickness = 10; //mm
railLen = extensionLen - 40; //mm
railDia = screwDia + 1; //mm

antennaExtensionMountW = 30; //mm
antennaExtensionLen = 120; //mm
antennaExtensionDia = 20; //mm
extensionMountThickness = 6; //mm

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
            frameThickness-champferDist]);
      translate([champferDist,champferDist,frameThickness-champferDist])
      cube([innerW+clearance+2*frameWallThickness-champferDist*2,
            innerH+clearance+2*frameWallThickness-champferDist*2,
            champferDist]);
    }
    translate([frameWallThickness,frameWallThickness,-extra/2])
    cube([innerW+clearance,
          innerH+clearance,
          frameThickness+extra]);

    translate([frameWallThickness,0,8])
      cube([innerW+clearance,frameWallThickness,frameThickness]);
    /* ----- frame end ----- */

    if(holderScrew == true)
    {
      /* screw holes */
      translate([0,frameWallThickness+innerH/4,frameThickness/2])
      rotate([0,90,0])
        cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+clearance/2+extra);

      translate([0,frameWallThickness+innerH-innerH/4,frameThickness/2])
      rotate([0,90,0])
        cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+clearance/2+extra);

      translate([frameWallThickness+clearance+innerW,frameWallThickness+innerH/4,frameThickness/2])
      rotate([0,90,0])
        cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+extra);

      translate([frameWallThickness+clearance+innerW,frameWallThickness+innerH-innerH/4,frameThickness/2])
      rotate([0,90,0])
        cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+extra);
      /* screw holes */
    }


    extraMountingScrew();
  }
}

module extraMountingScrew(useInserts = true)
{
  translate([frameWallThickness+clearance+innerW-10,frameWallThickness+innerH+clearance-extra/2,frameThickness/2])
  rotate([-90,0,0])
    cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+extra);
  translate([frameWallThickness+clearance+innerW-30,frameWallThickness+innerH+clearance-extra/2,frameThickness/2])
  rotate([-90,0,0])
    cylinder(r=getScrewDia(useInserts)/2, h=frameWallThickness+extra);
}




module extension(useInserts = true, mountingHoles = true)
{
  difference() {
    /* extension with champfer */
    hull()
    {
      cube([extensionLen,extensionThickness-champferDist,frameThickness-champferDist*2]);
      translate([champferDist,extensionThickness-champferDist,0])
        cube([extensionLen-champferDist,champferDist,frameThickness-champferDist*2]);
    }

    /* rail hole cutout */
    hull()
    {
      translate([5,-extra/2,(frameThickness-champferDist*2)/2])
      rotate([-90,0,0])
        cylinder(r=railDia/2, h=extensionThickness+champferDist+extra );

      translate([railLen-railDia,-extra/2,(frameThickness-champferDist*2)/2])
      rotate([-90,0,0])
        cylinder(r=railDia/2, h=extensionThickness+champferDist+extra );
    }

    if(mountingHoles == true)
    {
      /* mounting holes */
      translate([extensionLen-antennaExtensionMountW/4,-extra/2,(frameThickness-champferDist*2)/2])
      rotate([-90,0,0])
        cylinder(r=getScrewDia(useInserts)/2, h=extensionThickness+champferDist+extra );

      translate([extensionLen-3*antennaExtensionMountW/4,-extra/2,(frameThickness-champferDist*2)/2])
      rotate([-90,0,0])
        cylinder(r=getScrewDia(useInserts)/2, h=extensionThickness+champferDist+extra );
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
      cube([antennaExtensionMountW,extensionMountThickness,frameThickness-champferDist*2]);

      /* trapeze; connection between mounting plate and extension */
      hull()
      {
        translate([0,0,frameThickness-champferDist*3])
          cube([antennaExtensionMountW,extensionMountThickness,champferDist]);
        translate([(antennaExtensionMountW-antennaExtensionDia)/2,0,frameThickness-champferDist*4+10])
          cube([antennaExtensionDia,extensionMountThickness,champferDist]);
      }

      /* extension with hole for antenna */
      hull()
      {
        translate([(antennaExtensionMountW-antennaExtensionDia)/2,0,frameThickness-champferDist*4+10])
          cube([antennaExtensionDia,extensionMountThickness,champferDist]);
        translate([antennaExtensionMountW/2,0,frameThickness-champferDist*3+10+antennaExtensionLen-antennaExtensionDia/2])
          rotate([-90,0,0])
          cylinder(r=antennaExtensionDia/2, h=extensionMountThickness);
      }
    }



    /* screw holes for mounting antenna mount extension to other extension; holes are 1mm wider */
    translate([antennaExtensionMountW-antennaExtensionMountW/4,-extra/2,(frameThickness-champferDist*2)/2])
    rotate([-90,0,0])
      cylinder(r=(screwDia+1)/2, h=frameWallThickness+champferDist+extra );

    translate([antennaExtensionMountW-3*antennaExtensionMountW/4,-extra/2,(frameThickness-champferDist*2)/2])
    rotate([-90,0,0])
      cylinder(r=(screwDia+1)/2, h=frameWallThickness+champferDist+extra );

    /* rail hole */
    hull()
    {
      translate([antennaExtensionMountW/2,-extra/2,frameThickness-champferDist*3+antennaExtensionLen-antennaExtensionDia])
        rotate([-90,0,0])
        cylinder(r=railDia/2, h=extensionMountThickness+extra);
      translate([antennaExtensionMountW/2,-extra/2,frameThickness-champferDist*3+antennaExtensionDia])
        rotate([-90,0,0])
        cylinder(r=railDia/2, h=extensionMountThickness+extra);
    }

    /* antenna hole */
    translate([antennaExtensionMountW/2,-extra/2,frameThickness-champferDist*3+10+antennaExtensionLen-antennaExtensionDia/2])
      rotate([-90,0,0])
      cylinder(r=antennaSocketDia/2, h=extensionMountThickness+extra);

    if(grubScrew == true)
    {
      translate([antennaExtensionMountW/2,extensionMountThickness/2,frameThickness-champferDist*3+10+antennaExtensionLen-antennaExtensionDia/2])
        rotate([0,45,0])
        cylinder(r=grubScrewDia/2, h=antennaExtensionDia/2+extra);

      translate([antennaExtensionMountW/2,extensionMountThickness/2,frameThickness-champferDist*3+10+antennaExtensionLen-antennaExtensionDia/2])
        rotate([0,-45,0])
        cylinder(r=grubScrewDia/2, h=antennaExtensionDia/2+extra);
    }
  }
}


/* #################################################################### */
/* ######################Model######################################### */
/* #################################################################### */

if(0)
{
  frame();
  translate([innerW-frameWallThickness*2+clearance-20,innerH+clearance+frameWallThickness*2,champferDist])
  {
    extension();
//antennaExtensionMountW
    translate([extensionLen-antennaExtensionMountW,frameWallThickness,0])
    antennaMount();
  }
}


frame();

/* rotate([90,0,0]) */
/* extension(); */
/* antennaMount(grubScrew = true); */

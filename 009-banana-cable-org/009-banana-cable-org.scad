/* 009-banana-cable-org.scad
Author: andimoto@posteo.de
----------------------------
*/

$fn=80;
extra = 0.05;

enableHooks = true;

outerBaseDia = 60;
innerBaseDia = 50;

outerBaseH = 5;
innerBaseH = 5;

wallThickness = 4;


cubeHoleXY = 5;
bananaPlugDia = 3.5; // diameter of banana plug 3.5mm + some extra
bananaPlugHolderH = 20;

function getBottom(i) = (i==0) ? true : 0 ;


module bananaHook()
{
  hull()
  {
    cube([cubeHoleXY*2,cubeHoleXY-0.1,cubeHoleXY-0.1]);

    difference() {
      translate([0,cubeHoleXY-0.1,bananaPlugDia/2-0.3])
        rotate([90,0,0]) cylinder(r=bananaPlugDia/2, h=cubeHoleXY-0.1);
        translate([-cubeHoleXY/2,0,-cubeHoleXY]) cube([cubeHoleXY,cubeHoleXY,cubeHoleXY]);
    }
  }
  difference()
  {
    translate([0,cubeHoleXY+bananaPlugHolderH/2,bananaPlugDia/2-0.3])
      rotate([90,0,0]) cylinder(r=bananaPlugDia/2, h=bananaPlugHolderH+cubeHoleXY);
    translate([-cubeHoleXY/2,-bananaPlugHolderH/2,-cubeHoleXY]) cube([cubeHoleXY,bananaPlugHolderH+cubeHoleXY,cubeHoleXY]);
  }
}
/* translate([bananaPlugHolderH/2+innerBaseDia/2-wallThickness,-cubeHoleXY/2,cubeHoleXY])
rotate([180,0,180]) */
/* bananaHook(); */

module orgBase(bottom = true, hookCutout = true)
{
  difference()
  {
    union()
    {
      cylinder(r2=innerBaseDia/2, r1=outerBaseDia/2, h=outerBaseH);
      translate([0,0,outerBaseH]) cylinder(r=innerBaseDia/2, h=innerBaseH);
      translate([0,0,outerBaseH+innerBaseH]) cylinder(r1=innerBaseDia/2, r2=outerBaseDia/2, h=outerBaseH);

      if(bottom == true)
      {
        translate([0,0,-wallThickness])
          cylinder(r=outerBaseDia/2, h=wallThickness);
      }
    }

    cylinder(r=innerBaseDia/2-wallThickness,h=outerBaseH*2+innerBaseH+extra);

    if(hookCutout ==  true)
    {
      translate([0,-cubeHoleXY/2,0])
        cube([outerBaseDia/2,cubeHoleXY,cubeHoleXY]);
    }
  }
}


/* orgBase(bottom = true, hookCutout = true); */


module cableOrganizer(cnt = 3)
{
  for (i=[0:cnt-1]) {
    translate([0,0,i * (outerBaseH*2+innerBaseH)])
      orgBase(bottom = getBottom(i), hookCutout = enableHooks);
  }

}


cableOrganizer(cnt = 1);

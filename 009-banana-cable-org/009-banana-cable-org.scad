/* 009-banana-cable-org.scad
Author: andimoto@posteo.de
----------------------------
*/
use <threads-scad/threads.scad>


$fn=100;
extra = 0.05;



outerBaseDia = 60;
innerBaseDia = 50;

outerBaseH = 5;
innerBaseH = 5;

wallThickness = 4;

cubeHoleXY = 5;
bananaPlugDia = 4.1; // mid diameter of banana plug 4mm + some extra
bananaPlugHolderH = 20;


lidThickness = 6;
lidGripRadius = 5;



function getBottom(i) = (i==0) ? true : 0 ;
function getThreadPos(i) = (i==threadElement-1) ? true : 0 ;


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
    union()
    {
      translate([0,cubeHoleXY+bananaPlugHolderH/2,bananaPlugDia/2-0.3])
        rotate([90,0,0]) cylinder(r=bananaPlugDia/2, h=bananaPlugHolderH+cubeHoleXY);

      translate([0,cubeHoleXY+bananaPlugHolderH/2,bananaPlugDia/2-0.3])
        sphere(r=bananaPlugDia/2);

      translate([0,-bananaPlugHolderH/2,bananaPlugDia/2-0.3])
        sphere(r=bananaPlugDia/2);
    }
    translate([-cubeHoleXY/2,-bananaPlugHolderH/2-cubeHoleXY/2,-cubeHoleXY])
      cube([cubeHoleXY,bananaPlugHolderH+cubeHoleXY*2,cubeHoleXY]);
  }
}


module orgBase(bottom = true, hookCutout = true, thread = false)
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

    if(thread == true)
    {
      translate([0,0,(outerBaseH+innerBaseH)])
      AugerThread(outer_diam=innerBaseDia-wallThickness*2+2, inner_diam=(innerBaseDia-0-wallThickness*2), height=outerBaseH,
                pitch=2, tooth_angle=45, tolerance=0.4, tip_height=0, tip_min_fract=0);
    }

    if(hookCutout ==  true)
    {
      translate([innerBaseDia/2-wallThickness/2,-cubeHoleXY/2,0])
        cube([outerBaseDia/2,cubeHoleXY,cubeHoleXY]);
    }
    /* DEBUG */
    /* cube([100,1000,20]); */
  }
}

module screwLid()
{
  difference()
  {
    union()
    {
      translate([0,0,lidThickness])
      AugerThread(outer_diam=innerBaseDia-wallThickness*2+1.8, inner_diam=(innerBaseDia-0.2-wallThickness*2), height=outerBaseH,
                pitch=2, tooth_angle=45, tolerance=0.4, tip_height=0, tip_min_fract=0);

      hull()
      {
        translate([0,0,0])
          cylinder(r=outerBaseDia/2-1,h=1);
        translate([0,0,1])
          cylinder(r=outerBaseDia/2,h=lidThickness-1);
      }
    }

    for (i=[0:11]) {
      rotate([0,0,i*360/12])
      translate([outerBaseDia/2+lidGripRadius/2,0,0])
        cylinder(r=lidGripRadius,h=lidThickness);
    }
  }
}

module cableOrganizer(cnt = 3, threadPos = 3)
{
  for (i=[0:cnt-1]) {
    translate([0,0,i * (outerBaseH*2+innerBaseH)])
      orgBase(bottom = getBottom(i), hookCutout = enableHooks, thread = getThreadPos(i));
  }
}

/* ############################################################################ */
/* ########################### create models ################################## */
/* ############################################################################ */

/* translate([bananaPlugHolderH/2+innerBaseDia/2-wallThickness,-cubeHoleXY/2,cubeHoleXY])
rotate([180,0,180])
bananaHook(); */

/* translate([70,0,0])
screwLid(); */

/* orgBase(bottom = true, hookCutout = true, thread = true); */
enableHooks = true;
baseElements = 1;
threadElement = baseElements;
cableOrganizer(cnt = baseElements, threadPos = threadElement);

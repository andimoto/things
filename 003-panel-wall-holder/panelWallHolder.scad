/* panelWallHolder.scad
Author: andimoto@posteo.de
----------------------------
*/
use <threads-scad/threads.scad>

$fn=80;
extra = 0.1;

/* ScrewHole(8, 20, position=[20,20,0], rotation=[0,0,0], pitch=0, tooth_angle=30, tolerance=0.5, tooth_height=0)
cube([50,50,50]); */

panelThickness = 20;
backBracketThickness = 10;
frontBracketThickness = 5;
bottonBracketThickness = 5;
bracketX = 60;
bracketZ = 60;

bracketThickness = backBracketThickness + panelThickness + frontBracketThickness;

module panelWallHolderBrackets()
{
  difference() {
    cube([bracketX,bracketThickness,bracketZ]);
    translate([-extra/2,backBracketThickness,bottonBracketThickness])
      cube([bracketX+extra,panelThickness,bracketZ]);
    translate([0,backBracketThickness+panelThickness-extra/2,bottonBracketThickness])
      cube([(bracketX/3)*2,frontBracketThickness+extra,bracketZ]);
    translate([0,backBracketThickness+panelThickness-extra/2,bracketX-bracketZ/3])
      cube([bracketX,frontBracketThickness+extra,bracketZ/3]);

    translate([-sqrt(2)*10/2,0,bracketZ]) rotate([0,45,0]) cube([10,backBracketThickness,10]);
    translate([bracketX-sqrt(2)*10/2,0,bracketZ]) rotate([0,45,0]) cube([10,backBracketThickness,10]);
    translate([0,bracketThickness,0]) rotate([0,0,-45]) translate([0,-10,0]) cube([10,20,bottonBracketThickness]);
  }
}

CountersunkClearanceHole(4, 10,
    position=[bracketX/3,backBracketThickness,bracketZ/3],
    rotation=[90,0,0],
    sinkdiam=7, sinkangle=45, tolerance=0.4)
CountersunkClearanceHole(4, 10,
    position=[bracketX/3,backBracketThickness,bracketZ/3*2],
    rotation=[90,0,0],
    sinkdiam=7, sinkangle=45, tolerance=0.4)
panelWallHolderBrackets();

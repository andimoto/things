/* enclosure-system.scad
Author: andimoto@posteo.de
----------------------------

*/


/* [Beam Parameters] */

// length of x side of beam
beamX = 20;
// length of y side of beam
beamY = 20;
// length of beam
beamLen = 60;
// Wallthickness of the beam
beamWallThickness = 2;
// Thickness of the beam mount plates at the ends
beamMountThickness = 5;

// generate beam mount plates only on one side of beam or on both
beamMountCnt=2; // [0,1,2]
// enable mounting holes for panels
panelsMountingX = true;
// enable mounting holes for panels
panelsMountingY = true;

// amount of mounting holes on the beams
panelsMountingHolesCnt = 2;
// distance between mounting holes
mountingHolesDist = 20;

// move panel mounting holes on X side in x direction
panelHolesX_MoveX = 0;
// move panel mounting holes on X side in z direction
panelHolesX_MoveZ = 0;
// move panel mounting holes on Y side in y direction
panelHolesY_MoveY = 0;
// move panel mounting holes on Y side in z direction
panelHolesY_MoveZ = 0;

// Diameter of Nut (use most outer diamenter of the nut), for M3 Nut this is typically ~6mm
MountNutDia = 6;
// Thicknes of the Nut
MountNutThick = 3;

// completely enable or disable marker
panelMarker = true;
// overlapping of panel over beam [no marker => 0,beamX or beamY; 0 ]
panelBeamOverlappingDist = 5;

// if enabled, small holes will be created in the beam mounting plates to avoid rotation of beams when stacking them togehter
fixingHoles = true;

/* [Panel Parameters] */

// Panel Width
PanelFront_X = 100;
// Panel Height
PanelFront_Z = 100;
// Panel Thickness
PanelFront_Thick = 3;

/* [other Parameters] */
$fn=70;
extra = 0.01;
// filament thickness
filamentDia = 1.75;

// do a complete enclosure simulation
sim = true;


/* ################ MODULES ################## */
/* ################ MODULES ################## */


module Screw(ScrewDia=3,ScrewLen=10,ScrewHeadDia=6,ScrewHeadLen=3)
{
  translate([0,0,ScrewHeadLen]) cylinder(r=ScrewDia/2,h=ScrewLen);
  cylinder(r=ScrewHeadDia/2,h=ScrewHeadLen);
}
/* Screw(ScrewDia=3,ScrewLen=10,ScrewHeadDia=6,ScrewHeadLen=3); */

module NutScrewCutout(ScrewDia=3, ScrewCutoutLen=15, NutDia=6, NutCutoutLen=10, rotX=0, rotY=0, rotZ=0, zOffset=0, nutFn=6)
{
  translate([0,0,zOffset])
  rotate([rotX,rotY,rotZ])
  union()
  {
    cylinder(r=ScrewDia/2 + 0.2, h=ScrewCutoutLen);
    cylinder(r=NutDia/2 + 0.2, h=NutCutoutLen, $fn=nutFn);
    intersection()
    {
      translate([0,0,NutCutoutLen]) cylinder(r=NutDia/2 + 0.2, h=0.2, $fn=nutFn);
      translate([-ScrewDia/2-0.2,-ScrewDia,NutCutoutLen]) cube([ScrewDia+0.4,ScrewDia*2,0.2]);
    }
    translate([-ScrewDia/2-0.2,-ScrewDia/2-0.2,NutCutoutLen]) cube([ScrewDia+0.4,ScrewDia+0.4,0.4]);
  }
}

/* translate([beamWallThickness,beamWallThickness,extra+beamMountThickness-3])
NutScrewCutout(ScrewDia=3, ScrewCutoutLen=15, NutDia=6, NutCutoutLen=3, rotX=0, rotY=0, rotZ=0, zOffset=3); */

module panelMountingHoles(ScrewDia=3,holeLen=beamWallThickness, holeCnt=3, holeDist=20)
{
  for(i=[0:1:holeCnt-1])
  {
    translate([0,i*holeDist,0]) cylinder(r=ScrewDia/2,h=holeLen);
  }
}
/* rotate([90,00,0])
panelMountingHoles(ScrewDia=3,holeLen=beamWallThickness, holeCnt=5, holeDist=20); */

module beamMount(bX=20,bY=20,bH=100, wallTh=5)
{
  hull()
  {
    cube([bX, beamWallThickness, wallTh]);
    cube([beamWallThickness, bY, wallTh]);
  }
}
/* beamMount(); */



module corner_beam(bX=20,bY=20,bH=100, wallTh=5, btmMountTh=5)
{
  assert((bX > 14), "WARNING: BeamX should be larger than 15mm");
  assert((bY > 14), "WARNING: BeamY should be larger than 15mm");

  difference()
  {
    union()
    {
      difference() {
        cube([bX, bY, bH]);
        translate([wallTh,wallTh,-extra]) cube([bX-wallTh+extra, bY-wallTh+extra, bH+extra*2]);
      }
      if(beamMountCnt>0)
        beamMount(bX,bY,wallTh,btmMountTh);
      if(beamMountCnt>1)
        translate([0,0,bH-btmMountTh]) beamMount(bX,bY,wallTh,btmMountTh);
    }

    /* bottom screw cutouts for connecting multiple beams together */
    translate([wallTh+4,wallTh+4,extra+btmMountTh-MountNutThick])
    NutScrewCutout(ScrewDia=3, ScrewCutoutLen=btmMountTh+extra*2, NutDia=MountNutDia, NutCutoutLen=MountNutThick,
      rotX=180, rotY=0, rotZ=0, zOffset=MountNutThick);
    /* top screw cutouts for connecting multiple beams together */
    translate([wallTh+4,wallTh+4,-extra+bH-btmMountTh])
    NutScrewCutout(ScrewDia=3, ScrewCutoutLen=btmMountTh+extra*2, NutDia=MountNutDia, NutCutoutLen=MountNutThick,
      rotX=0, rotY=0, rotZ=0, zOffset=0);


    /* mounting holes for X side */
    if(panelsMountingX == true)
    {
      holesOffset = (bH - (panelsMountingHolesCnt-1)*mountingHolesDist)/2;

      translate([panelHolesX_MoveX,extra,panelHolesX_MoveZ])
      translate([bX/2,wallTh,holesOffset])
      rotate([90,00,0])
      panelMountingHoles(ScrewDia=3.4,holeLen=wallTh+extra*2, holeCnt=panelsMountingHolesCnt, holeDist=mountingHolesDist);
    }

    /* mounting holes for Y side */
    if(panelsMountingY == true)
    {
      holesOffset = (beamLen - (panelsMountingHolesCnt-1)*mountingHolesDist)/2;

      translate([0,panelHolesY_MoveY,panelHolesY_MoveZ])
      translate([-extra,bY/2,holesOffset])
      rotate([90,00,90])
      panelMountingHoles(ScrewDia=3.4,holeLen=wallTh+extra*2, holeCnt=panelsMountingHolesCnt, holeDist=mountingHolesDist);
    }

    /* fixing holes of beam mounting plates */
    translate([bX-bX/3,wallTh*2,-extra]) cylinder(r=filamentDia/2+0.1, h=btmMountTh+extra*2);
    translate([wallTh*2,bY-bY/3,-extra]) cylinder(r=filamentDia/2+0.1, h=btmMountTh+extra*2);
    translate([bX-bX/3,wallTh*2,bH-btmMountTh-extra]) cylinder(r=filamentDia/2+0.1, h=btmMountTh+extra*2);
    translate([wallTh*2,bY-bY/3,bH-btmMountTh-extra]) cylinder(r=filamentDia/2+0.1, h=btmMountTh+extra*2);

    /* panel marker */
    translate([bX-panelBeamOverlappingDist,0,0]) panelMarker(btmMountTh);
    translate([bX-panelBeamOverlappingDist,0,bH-btmMountTh]) panelMarker(btmMountTh);
    translate([0,bY-panelBeamOverlappingDist,0]) panelMarker(btmMountTh);
    translate([0,bY-panelBeamOverlappingDist,bH-btmMountTh]) panelMarker(btmMountTh);
  }
}

module panelMarker(markerHeight=10)
{
  if(panelMarker == true)
  {
    translate([-sqrt(2*0.6^2)/2,0,-extra])
    rotate([0,0,-45])
    cube([0.6,0.6,markerHeight]);
  }
}


module topCorner(xLen=20, yLen=20, width=10, thickness=4, filaConnect=true, conThickness=3)
{
  difference()
  {
    union()
    {
      cube([xLen,width,thickness]);
      cube([width,yLen,thickness]);

      if(filaConnect == true)
      {
        translate([xLen-5,width,-3]) rotate([0,0,-90]) filaConnect(filaDia=1.75,conLen=width,conWidth=5,conThick=conThickness);
        translate([0,yLen-5,-3]) rotate([0,0,0]) filaConnect(filaDia=1.75,conLen=width,conWidth=5,conThick=conThickness);
      }
    }
    translate([beamWallThickness+4,beamWallThickness+4,extra+beamMountThickness-MountNutThick])
    NutScrewCutout(ScrewDia=3, ScrewCutoutLen=beamMountThickness+extra*2, NutDia=MountNutDia, NutCutoutLen=MountNutThick,
      rotX=180, rotY=0, rotZ=0, zOffset=MountNutThick);
  }
}

module cornerConnector(xLen=30, width=10, thickness=4, filaConnect=true, conThickness=3, panelHolesCnt=3,panelHolesDist=20)
{
  difference()
  {
    union()
    {
    cube([xLen,width,thickness]);

      if(filaConnect == true)
      {
        translate([0,width,-3]) rotate([0,0,-90]) filaConnect(filaDia=1.75,conLen=width,conWidth=5,conThick=conThickness);
        translate([xLen-5,width,-3]) rotate([0,0,-90]) filaConnect(filaDia=1.75,conLen=width,conWidth=5,conThick=conThickness);
      }
    }

    moveHoles = (xLen - (panelHolesCnt-1)*panelHolesDist)/2;
    translate([moveHoles,5,-extra]) rotate([0,0,-90]) panelMountingHoles(ScrewDia=3.4,holeLen=thickness+extra*2, holeCnt=panelHolesCnt, holeDist=panelHolesDist);
  }
}

module filaConnect(filaDia=1.75,conLen=10,conWidth=5,conThick=3)
{
  difference() {
    cube([conLen,conWidth,conThick]);

    translate([conLen/4,-extra,conThick/2])
    rotate([-90,0,0]) cylinder(r=filaDia/2,h=conWidth+extra*2);
    translate([conLen/2+conLen/4,-extra,conThick/2])
    rotate([-90,0,0]) cylinder(r=filaDia/2,h=conWidth+extra*2);
  }
}

/* filaConnect(filaDia=1.75,conLen=10,conWidth=5,conThick=3); */

module panel(panelX=100,panelZ=100,panelThick=3)
{
  color("Ivory", 0.25) cube([panelX,panelThick,panelZ]);
}


if(sim == false)
{
  corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
}


translate([0,0,beamLen*2])
topCorner(xLen=beamX*2, yLen=beamY*2, width=20,thickness=beamMountThickness);

translate([beamX*2,0,beamLen*2])
cornerConnector(xLen=60, width=20, thickness=5, filaConnect=true, conThickness=3,panelHolesCnt=2,panelHolesDist=30);

translate([140,0,beamLen*2])
rotate([0,0,90])
topCorner(xLen=beamX*2, yLen=beamY*2, width=20,thickness=beamMountThickness);

translate([140,140,beamLen*2])
rotate([0,0,180])
topCorner(xLen=beamX*2, yLen=beamY*2, width=20,thickness=beamMountThickness);

translate([0,140,beamLen*2])
rotate([0,0,-90])
topCorner(xLen=beamX*2, yLen=beamY*2, width=20,thickness=beamMountThickness);

/* do simulation of enclosure */
if(sim == true)
{
  union()
  {
    translate([0,0,0]) corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
    translate([0,0,beamLen]) corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
  }

  translate([140,0,0])
  rotate([0,0,90])
  union()
  {
    translate([0,0,0]) corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
    translate([0,0,beamLen]) corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
  }

  translate([140,140,0])
  rotate([0,0,180])
  union()
  {
    translate([0,0,0]) corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
    translate([0,0,beamLen]) corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
  }

  translate([0,140,0])
  rotate([0,0,270])
  union()
  {
    translate([0,0,0]) corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
    translate([0,0,beamLen]) corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
  }


  translate([15,-4,0]) panel(panelX=110,panelZ=120,panelThick=4);
  translate([15,110+30,0]) panel(panelX=110,panelZ=120,panelThick=4);
  translate([110+30+4,15,0]) rotate([0,0,90]) panel(panelX=110,panelZ=120,panelThick=4);
  translate([0,15,0]) rotate([0,0,90]) panel(panelX=110,panelZ=120,panelThick=4);

  translate([15,10,beamMountThickness*2+beamLen*2-1]) rotate([-90,0,0]) panel(panelX=110,panelZ=120,panelThick=4);

}

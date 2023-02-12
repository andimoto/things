/* enclosure-modules.scad
Author: andimoto@posteo.de
----------------------------

*/

/* constant distance from holes in the beams to the overlapping panel mount area */
beamHolesToPlateDist = 5;

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
      translate([bX-panelBeamOverlappingDist-beamHolesToPlateDist,wallTh,holesOffset])
      rotate([90,00,0])
      panelMountingHoles(ScrewDia=3.4,holeLen=wallTh+extra*2, holeCnt=panelsMountingHolesCnt, holeDist=mountingHolesDist);
    }

    /* mounting holes for Y side */
    if(panelsMountingY == true)
    {
      holesOffset = (beamLen - (panelsMountingHolesCnt-1)*mountingHolesDist)/2;

      translate([0,panelHolesY_MoveY,panelHolesY_MoveZ])
      translate([-extra,bY-panelBeamOverlappingDist-beamHolesToPlateDist,holesOffset])
      rotate([90,00,90])
      panelMountingHoles(ScrewDia=3.4,holeLen=wallTh+extra*2, holeCnt=panelsMountingHolesCnt, holeDist=mountingHolesDist);
    }

    if(filamentFixingHoles == true)
    {
      /* fixing holes of beam mounting plates */
      translate([bX-bX/3,wallTh*2,-extra]) cylinder(r=filamentDia/2+0.1, h=btmMountTh+extra*2);
      translate([wallTh*2,bY-bY/3,-extra]) cylinder(r=filamentDia/2+0.1, h=btmMountTh+extra*2);
      translate([bX-bX/3,wallTh*2,bH-btmMountTh-extra]) cylinder(r=filamentDia/2+0.1, h=btmMountTh+extra*2);
      translate([wallTh*2,bY-bY/3,bH-btmMountTh-extra]) cylinder(r=filamentDia/2+0.1, h=btmMountTh+extra*2);
    }

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
      /* placing a L-shaped corner */
      cube([xLen,width,thickness]);
      cube([width,yLen,thickness]);

      /* filament connectors */
      if(filaConnect == true)
      {
        /* check if adding filament connector is plausible
         * otherwise it can conflict with the beam  */
        echo("checking topCorner clearance of filament connector to beam");
        tempXlen = xLen - filaConnectorWidth;
        assert((beamX <= tempXlen), "WARNING: topCornerXLen should be larger than beamX");
        tempYlen = yLen - filaConnectorWidth;
        assert((beamY <= tempYlen), "WARNING: topCornerYLen should be larger than beamY");
        echo("Clearance Ok");
        translate([xLen-5,width,-conThickness]) rotate([0,0,-90])
          filaConnect(filaDia=filamentDia,conLen=width,conWidth=filaConnectorWidth,conThick=conThickness);
        translate([0,yLen-5,-conThickness]) rotate([0,0,0])
          filaConnect(filaDia=filamentDia,conLen=width,conWidth=filaConnectorWidth,conThick=conThickness);
      }
    }

    /* cutout space for the screw and hex-nut */
    translate([beamWallThickness+4,beamWallThickness+4,extra+beamMountThickness-MountNutThick])
    NutScrewCutout(ScrewDia=3, ScrewCutoutLen=beamMountThickness+extra*2, NutDia=MountNutDia, NutCutoutLen=MountNutThick,
      rotX=180, rotY=0, rotZ=0, zOffset=MountNutThick);
  }
}

module cornerConnector(xLen=30, width=10, thickness=4, filaConnect=true, conThickness=3, panelHolesCnt=3,panelHolesDist=20, letter="X")
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

    moveHoles = (xLen - (topFramePanelHolesCnt-1)*topFramePanelHolesDist)/2;
    translate([moveHoles,width-topFramePanelOverlap-5+topFramePanelHolesMoveY,-extra]) rotate([0,0,-90])
      panelMountingHoles(ScrewDia=3.4,holeLen=thickness+extra*2, holeCnt=topFramePanelHolesCnt, holeDist=topFramePanelHolesDist);


    translate([xLen/2,width/2,0])
    linear_extrude(height=0.2)
    text(letter,size=3,halign="center");

    /* overlapping marker */
    translate([0,width-topFramePanelOverlap,thickness-sqrt(2*0.3^2)/2])
    rotate([45,0,0])
    cube([xLen,0.3,0.3]);
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


module panelClamp(length=15,width=10,overlapDist=5, panelThickness=3, addClampThickness=1, holeToPanelDist=5)
{
  assert( ( (panelThickness+addClampThickness) >= (MountNutThick+1)), "WARNING: panelThickness+addClampThickness should be greater or equal to MountNutThick+1");
  color("Green")
  difference()
  {
    cube([length,width,panelThickness+addClampThickness]);
    translate([length-overlapDist,-extra,-extra])
      cube([overlapDist+extra,width+extra*2,panelThickness+extra]);

    translate([length-overlapDist-holeToPanelDist,width/2,addClampThickness+extra])
    NutScrewCutout(ScrewDia=3, ScrewCutoutLen=panelThickness+addClampThickness+extra*2, NutDia=MountNutDia, NutCutoutLen=MountNutThick,
      rotX=180, rotY=0, rotZ=30, zOffset=MountNutThick);
  }
}
/* translate([0,0,5])
panelClamp(length=15,width=10,overlapDist=5, panelThickness=3, addClampThickness=1, holeToPanelDist=5); */

module panel(panelX=100,panelZ=100,panelThick=3)
{
  color("Ivory", 0.25) cube([panelX,panelThick,panelZ]);
}

module enclosureTopFrame()
{
  tempDist = [[0,0],
              [enclosureX,0],
              [0,enclosureY],
              [enclosureX,enclosureY]];

  tempMirror = [[0,0],[1,0]];
  for (i=[0:1]) {
    translate([tempDist[i][0],tempDist[i][1],beamLen*vBeamCount])
    mirror([tempMirror[i][0],tempMirror[i][1],0])
    topCorner(xLen=topCornerXLen, yLen=topCornerYLen, width=topFrameWidth,thickness=beamMountThickness,
      filaConnect=enableTopFrameFilamentConnect, conThickness=3);
  }


  for (i=[0:1]) {
    translate([tempDist[i+2][0],tempDist[i+2][1],beamLen*vBeamCount])
    mirror([tempMirror[i][0],tempMirror[i][1],0])
    mirror([0,1,0])
    topCorner(xLen=topCornerXLen, yLen=topCornerYLen, width=topFrameWidth,thickness=beamMountThickness,
      filaConnect=enableTopFrameFilamentConnect, conThickness=3);
  }

  /* connection plates orthogonal to x axis */
  for(i=[0:1])
  {
    translate([topCornerXLen,enclosureY*i,beamLen*vBeamCount])
    mirror([0,i*1,0])
    cornerConnector(xLen=tempConnectorLenX, width=topFrameWidth, thickness=5,
      filaConnect=enableTopFrameFilamentConnect, conThickness=3,
      panelHolesCnt=2,panelHolesDist=topFramePanelHolesDist,letter="X");
  }

  /* connection plates orthogonal to y axis */
  for(i=[0:1])
  {
    translate([enclosureX*i,tempConnectorLenY+topCornerYLen,beamLen*vBeamCount])
    mirror([1*i,0,0])
    rotate([0,0,-90])
    cornerConnector(xLen=tempConnectorLenY, width=topFrameWidth, thickness=5,
      filaConnect=enableTopFrameFilamentConnect,
      conThickness=3,panelHolesCnt=2,panelHolesDist=topFramePanelHolesDist,letter="Y");
  }

  translate([topCornerXLen+(tempConnectorLenX-topFramePanelHolesDist)/2,topFrameWidth-15,beamLen*vBeamCount+5])
  translate([5,0,0])
  rotate([0,0,90])
  panelClamp(length=15,width=10,overlapDist=topFramePanelOverlap, panelThickness=PanelFront_Thick, addClampThickness=2, holeToPanelDist=5);

  translate([topCornerXLen+(tempConnectorLenX-topFramePanelHolesDist)/2+topFramePanelHolesDist,topFrameWidth-15,beamLen*vBeamCount+5])
  translate([5,0,0])
  rotate([0,0,90])
  panelClamp(length=15,width=10,overlapDist=topFramePanelOverlap, panelThickness=PanelFront_Thick, addClampThickness=2, holeToPanelDist=5);

}

module slot(screwDia=3.4, slotLength=50, thick=4)
{
  hull()
  {
    translate([0,0,0])
    rotate([-90,0,0]) cylinder(r=screwDia/2, h=thick, center=false);
    translate([0,0,slotLength])
    rotate([-90,0,0]) cylinder(r=screwDia/2, h=thick, center=false);
  }
  hull()
  {
    translate([0,0,0])
    rotate([-90,0,0]) cylinder(r=6/2, h=thick-1, center=false);
    translate([0,0,slotLength])
    rotate([-90,0,0]) cylinder(r=6/2, h=thick-1, center=false);
  }
}

module backMountingPlate(plateX=100,plateH=100,plateThick=4,mountingSlots=true,borderDist=15,cableHole=true)
{
  SlotCount = (plateX-borderDist*2)/10;
  echo(SlotCount);

  difference()
  {
    cube([plateX,plateThick,plateH]);

    /* remove edges if panels get mounted inside beams */
    translate([-extra,-extra,0])
    cube([panelBeamOverlappingDist,plateThick+extra*2,beamMountThickness+1]);
    translate([plateX-panelBeamOverlappingDist,-extra,0])
    cube([panelBeamOverlappingDist,plateThick+extra*2,beamMountThickness+1]);

    translate([-extra,-extra,plateH-beamMountThickness-1])
    cube([panelBeamOverlappingDist,plateThick+extra*2,beamMountThickness+1]);
    translate([plateX-panelBeamOverlappingDist,-extra,plateH-beamMountThickness-1])
    cube([panelBeamOverlappingDist,plateThick+extra*2,beamMountThickness+1]);


    if(cableHole==true)
    {
      translate([-25+plateX/2,-extra,0])
      minkowski()
      {
        cube([50,plateThick+extra*2,5]);
        rotate([90,0,0]) cylinder(r=1,plateThick+extra*2);
      }
    }

    if(mountingSlots == true)
    {
      for (i=[0:SlotCount])
      {
        translate([borderDist+10*i,-extra,borderDist])
        slot(screwDia=3.4, slotLength=plateH-borderDist*2,thick=plateThick+extra*2);
      }
    }
  }
}


module enclosureComplete()
{
  tempDist = [[0,0],
              [enclosureX,0],
              [0,enclosureY],
              [enclosureX,enclosureY]];

  tempMirror = [[0,0],[1,0]];
  for (i=[0:1]) {
    translate([tempDist[i][0],tempDist[i][1],0])
    mirror([tempMirror[i][0],tempMirror[i][1],0])
    union()
    {
      translate([0,0,0]) corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
      translate([0,0,beamLen]) corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
    }
  }


  for (i=[0:1]) {
    translate([tempDist[i+2][0],tempDist[i+2][1],0])
    mirror([tempMirror[i][0],tempMirror[i][1],0])
    mirror([0,1,0])
    union()
    {
      translate([0,0,0]) corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
      translate([0,0,beamLen]) corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
    }
  }


  /* translate([15,-4,0]) panel(panelX=110,panelZ=120,panelThick=4);
  translate([15,110+30,0]) panel(panelX=110,panelZ=120,panelThick=4);
  translate([110+30+4,15,0]) rotate([0,0,90]) panel(panelX=110,panelZ=120,panelThick=4);
  translate([0,15,0]) rotate([0,0,90]) panel(panelX=110,panelZ=120,panelThick=4);

  translate([15,10,beamMountThickness*2+beamLen*2-1]) rotate([-90,0,0]) panel(panelX=110,panelZ=120,panelThick=4); */
}

/* laptop-display-casing.scad
Author: andimoto@posteo.de
----------------------------
*/
/* [ Display Dimensions ] */
// absolute Display Length ( X )
absDisplayX = 359;
// absolute Display Depth ( Y )
absDisplayY = 209;
// absolute Display Height ( Z ) (also include connector and electronic height on the back)
absDisplayZ = 6;
// length of the black screen ( x )
screenX=350;
// depth of the black screen ( y )
screenY=200;
// height of screen (should be lower than absDisplayZ as Screen is inside the absolute frame dimensions)
screenZ=4.5;
// length of the connector on the back (in x direction) (give some room for the connector; this will be also the cutout on the back)
connectorX = 35;
// length of the connector on the back (in y direction) (give some room for the connector; this will be also the cutout on the back)
connectorY = 30;
// optional: connector will be default 1mm height
connectorZ = 1;
// move the connector cutout on the back of the display in x direction
connectorXmove = 225;
// move the connector cutout on the back of the display in y direction
connectorYmove = 25;

/* [ Frame Dimensions ] */
// frame width in vertical dimension (left & right)
verticalFrameWidth = 10;
// frame width above the display
upperFrameWidth = 10;
// frame width below the display
lowerFrameWidth = 10;
// tolerance between display and frame on each side
sideClearance = 0.4;
// thickness of the back wall
backwallThickness = 2;
// inner case clearance between display back and back wall
backwallClearance = 2;
// edge radius of the case (bottom and top)
edgeRadius = 3;
// clearance between outer display frame an inner case
frameToCaseClearance = 0.2;
// display frame profiles
displayFrameProfileThickness = 5; //mm
// connector cutout length in Y direction
connectorCutoutX = 40;
// connector cutout length in Y direction
connectorCutoutY = 70;
// move connector cutout by X
moveConCutoutX = 0;
// move connector cutout by Y
moveConCutoutY = 0;
// thickness of the lid
lidFrameThickness = 1;
// select if inserts should be used
useInsertsInFrame = false;

/* [ PCB Case Parameter ] */
// pcb length in x direction
pcbX = 60;
// pcb length in y direction
pcbY = 140;
// pcb length in z direction
pcbZ = 18;
// inner case dimension in x direction
pcbCaseInnerX = 80;
// inner case dimension in y direction
pcbCaseInnerY = 145;
// inner case dimension in z direction
pcbCaseInnerZ = 22;
// wall thickness for horizontal walls (pcb case will be mounted here to display case)
pcbCaseHorizontalWallThickness = 10;
// wall thickness for vertical walls
pcbCaseVerticalWallThickness = 2;
// bottom thickness of pcb case (pcb will be mounted here)
pcbCaseBottomThickness = 2;
// space to route extern pcb with buttons to outside (most display controller have extern pcbs)
externPcbCableSpace = 2;


/* [ Visualization ] */
// show everything build together
showAssembly = false;
// show full assembly with lid frame
assemblyWithLid = false;
// show full assembly with screws
assemblyWithScrews = false;
// show display casing
showCase = false;
// place lidFrame
showLidFrame = false;
// show electronics case
showPcbCase = false;
// cut through the model to view profile
cutView = false;

/* [ Frame Screw Parameter ] */
frameScrewDia = 3.2;
frameScrewLen = 10;
frameScrewHeadLen = 3;
screwHeadThickness = 6.2;
insertDia=4.2;
insertH=6;


/* [ other Parameter ] */
$fn = 80;
extra = 0.015;
cutExtra = 1;





screwHalfXMove=(absDisplayX/2+verticalFrameWidth+sideClearance);
screwHalfYMove=(absDisplayX/2+lowerFrameWidth+sideClearance);
screwTopYMove=(absDisplayY+upperFrameWidth/2+lowerFrameWidth+sideClearance);
screwMaxXMove=(absDisplayX+verticalFrameWidth*2+sideClearance*2);

frameScrews = [
  [verticalFrameWidth/2,lowerFrameWidth/2],
  [screwHalfXMove-verticalFrameWidth,lowerFrameWidth/2],
  [verticalFrameWidth/2,screwTopYMove],
  [screwHalfXMove-verticalFrameWidth,screwTopYMove],

  [screwHalfXMove+verticalFrameWidth,lowerFrameWidth/2],
  [screwMaxXMove-verticalFrameWidth/2,lowerFrameWidth/2],
  [screwHalfXMove+verticalFrameWidth,screwTopYMove],
  [screwMaxXMove-verticalFrameWidth/2,screwTopYMove]
];





if(showAssembly == true)
{
  assembly();
}

if(showAssembly == false && showPcbCase == true)
{
  pcbCase();
}

if(showAssembly == false && showCase == true)
{
  difference()
  {
    displayCase();

    if(cutView == true)
    {
      translate([absDisplayX/2,-extra,-extra])
      cube([absDisplayX,
        absDisplayY+upperFrameWidth+lowerFrameWidth+sideClearance*2+extra*2,
        absDisplayZ+backwallThickness+backwallClearance+extra*2+cutExtra]);
    }
  }
}

if(showAssembly == false && showLidFrame == true)
{
  lidFrame();
}

module assembly()
{
  difference()
  {
    union()
    {
      displayCase();

      translate([verticalFrameWidth+sideClearance*2,lowerFrameWidth+sideClearance*2,backwallThickness+backwallClearance+extra*2])
      LaptopDisplay(absDisplayX, absDisplayY, absDisplayZ, screenX, screenY, screenZ);

      if(assemblyWithLid == true)
      {
        translate([0,0,absDisplayZ+backwallThickness+backwallClearance+extra])
        lidFrame();

        if(assemblyWithScrews == true)
        {
          color("Silver")
          LidScrewSimulation();
        }
      }
    }

    if(cutView == true)
    {
      translate([absDisplayX/2+verticalFrameWidth+sideClearance,-extra,-extra])
      cube([absDisplayX,
        absDisplayY+upperFrameWidth+lowerFrameWidth+sideClearance*2+extra*2,
        absDisplayZ+backwallThickness+backwallClearance+extra*2+cutExtra+2]);
    }
  }
}


module pcbCase()
{
  pcbCaseXTemp = pcbCaseInnerX + pcbCaseVerticalWallThickness*2;
  pcbCaseYTemp = pcbCaseInnerY + pcbCaseHorizontalWallThickness*2;

  difference() {
    cube([pcbCaseXTemp,pcbCaseYTemp,pcbCaseInnerZ+pcbCaseBottomThickness]);

    translate([pcbCaseVerticalWallThickness,pcbCaseHorizontalWallThickness,pcbCaseBottomThickness])
      cube([pcbCaseInnerX,pcbCaseInnerY,pcbCaseInnerZ +extra]);

    tempMoveXCableSpace = pcbCaseXTemp-pcbCaseVerticalWallThickness+extra;
    tempZCableSpace = pcbCaseBottomThickness+pcbCaseInnerZ-externPcbCableSpace;
    translate([tempMoveXCableSpace-extra*2,pcbCaseHorizontalWallThickness,tempZCableSpace])
      cube([pcbCaseVerticalWallThickness+extra*2,pcbCaseInnerY,externPcbCableSpace +extra]);


  }


}


module displayCase()
{
  tempX=absDisplayX+sideClearance*2+verticalFrameWidth*2;
  tempY=absDisplayY+sideClearance*2+upperFrameWidth+lowerFrameWidth;
  tempZ=absDisplayZ + backwallClearance + backwallThickness;

  difference()
  {
    union()
    {
      translate([edgeRadius,edgeRadius,0])
      minkowski()
      {
        cube([tempX-edgeRadius*2,tempY-edgeRadius*2,tempZ]);
        cylinder(r=edgeRadius, h=0.00001);
      }
    }

    translate([verticalFrameWidth+sideClearance,lowerFrameWidth+sideClearance, backwallThickness])
    cube([absDisplayX+sideClearance*2,absDisplayY+sideClearance*2,absDisplayZ+backwallClearance+extra]);

    connectorCutout();

    CaseScrewPlacement(inserts = useInsertsInFrame);
  }

  translate([verticalFrameWidth,lowerFrameWidth+sideClearance,backwallThickness])
  cube([absDisplayX+sideClearance*3, displayFrameProfileThickness,backwallClearance-frameToCaseClearance]);
  translate([verticalFrameWidth,lowerFrameWidth+absDisplayY+sideClearance*3-5,backwallThickness])
  cube([absDisplayX+sideClearance*3, displayFrameProfileThickness,backwallClearance-frameToCaseClearance]);

}

module connectorCutout()
{
  translate([moveConCutoutX+connectorXmove+verticalFrameWidth,
    moveConCutoutY+lowerFrameWidth+sideClearance+connectorYmove,-extra])
  cube([connectorCutoutX,connectorCutoutY,backwallThickness+extra*2]);
}

/* displayCase(); */

module LaptopDisplay(xAbs=360, yAbs=210, zAbs=5, xScreen=350, yScreen=200, zScreen=4.5)
{
  color("grey")
  difference()
  {
    cube([xAbs,yAbs,zAbs]);
    translate([(xAbs-xScreen)/2,(yAbs-yScreen)/2,-extra*2])
    cube([xScreen,yScreen,zAbs+extra*4]);
  }
  color("Black")
  translate([(xAbs-xScreen)/2,(yAbs-yScreen)/2,1])
  cube([xScreen,yScreen,zScreen-1]);

  color("Gold")
  translate([connectorXmove,connectorYmove,0])
  cube([connectorX, connectorY, connectorZ]);
}

/* lidFrame(); */
module lidFrame()
{
  tempX=absDisplayX+sideClearance*2+verticalFrameWidth*2;
  tempY=absDisplayY+sideClearance*2+upperFrameWidth+lowerFrameWidth;
  tempZ=absDisplayZ + backwallClearance + backwallThickness;

  difference()
  {
    union()
    {
      translate([edgeRadius,edgeRadius,0])
      minkowski()
      {
        cube([tempX-edgeRadius*2,tempY-edgeRadius*2,lidFrameThickness]);
        cylinder(r=edgeRadius, h=0.00001);
      }
    }

    translate([(absDisplayX-screenX)/2+verticalFrameWidth+sideClearance,
      (absDisplayX-screenX)/2+lowerFrameWidth+sideClearance,
      -extra])
    cube([screenX+sideClearance*2,screenY+sideClearance*2,absDisplayZ+backwallClearance+extra]);

    LidScrewPlacement();
  }
}


/* #CaseScrewPlacement(); */
module CaseScrewPlacement(inserts = false)
{
  for(point = frameScrews)
  {
    translate([point[0],point[1],backwallThickness])
    union()
    {
      if(inserts == true)
      {
        insertLength=backwallThickness+backwallClearance+absDisplayZ;
        assert((backwallClearance+absDisplayZ) > insertH, "Warning: Insert is higher than Frame Thickness (excluded backwallThickness)!!");

        translate([0,0,insertLength])
        mirror([0,0,1])
        screw(screwD = insertDia, screwLen=insertLength,
          screwHeadD = 0, screwHeadLength = 0);
      }else{
        translate([0,0,frameScrewLen+frameScrewHeadLen])
        mirror([0,0,1])
        screw(screwD = frameScrewDia, screwLen=frameScrewLen,
          screwHeadD = frameScrewDia, screwHeadLength = frameScrewHeadLen);
      }
    }
  }
}

module LidScrewSimulation()
{
  for(point = frameScrews)
  {
    translate([point[0],point[1],-extra])
    translate([0,0,frameScrewLen+frameScrewHeadLen])
    mirror([0,0,1])
    screw(screwD = frameScrewDia+0.4, screwLen=frameScrewLen,
        screwHeadD = screwHeadThickness, screwHeadLength = frameScrewHeadLen);
  }
}

module LidScrewPlacement()
{
  for(point = frameScrews)
  {
    translate([point[0],point[1],-extra])
    translate([0,0,frameScrewLen+frameScrewHeadLen])
    mirror([0,0,1])
    screw(screwD = frameScrewDia+0.4, screwLen=frameScrewLen,
        screwHeadD = screwHeadThickness, screwHeadLength = frameScrewHeadLen);
  }
}

module screw(screwD = 3, screwLen=10, screwHeadD = 6, screwHeadLength = 3)
{
  union()
  {
    /* head */
    cylinder(r=screwHeadD/2, h=screwHeadLength);
    /* screw */
    translate([0,0,screwHeadLength+0.2])
    cylinder(r = screwD/2, h=screwLen);

    translate([0,0,screwHeadLength])
    intersection()
    {
      cylinder(r=screwHeadD/2,h=0.2);
      translate([0,0,0.1])
        cube([screwHeadD,screwD,0.2],center=true);
    }
  }
}



/* translate([verticalFrameWidth+sideClearance*2,lowerFrameWidth+sideClearance*2,backwallThickness+backwallClearance+extra*2])
LaptopDisplay(absDisplayX, absDisplayY, absDisplayZ, screenX, screenY, screenZ); */

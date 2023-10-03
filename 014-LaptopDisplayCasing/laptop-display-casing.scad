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
useInsertsInFrame = true;
// enable mounting inserts on the back side of the display case to mount stand, etc
backMountingHoles = true;
// move pcb case in x direction (from lvds connector)
diffMovePcbCaseX = 0;
// move pcb case in y direction (from lvds connector)
diffMovePcbCaseY = 0;

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
pcbCaseInnerZ = 20;
// wall thickness for horizontal walls (pcb case will be mounted here to display case)
pcbCaseHorizontalWallThickness = 10;
// wall thickness for vertical walls
pcbCaseVerticalWallThickness = 2;
// bottom thickness of pcb case (pcb will be mounted here)
pcbCaseBottomThickness = 2;
// move pcb away from PCB Case walls (just use small values, otherwise PCB will be placed inside PCB Case)
moveDiffPcbX = 0;
// move pcb away from PCB Case walls (just use small values, otherwise PCB will be placed inside PCB Case)
moveDiffPcbY = 0;
// space to route extern pcb with buttons to outside (most display controller have extern pcbs)
externPcbCableSpace = 2;
// use inserts for pcb case
pcbCaseMountUseInserts = true;
// pcb case mount screw dia
pcbCaseMountScrewDia = 3.2;
// pcb case mount screw dia
pcbCaseMountScrewLen = 10;
// pcb case mount screw head len
pcbCaseMountScrewHeadLen = 3;



/* [ Stand Parameter ] */
// distance between hinge and feet of the stand. Main Parameter to control the angel of the display when standing
standFeetLength = -40;
// control the angel of the plate of the stand which touches the ground
standFeetPlateDegree = -14;

/* [ Visualization ] */
// show everything build together
showAssembly = false;
// show full assembly with lid frame
assemblyWithLid = false;
// show full assembly with screws
assemblyWithScrews = false;
// show only display
showDisplay = false;
// show display casing
showCase = false;
// show right part of case (for printing)
showCaseR = false;
// show left part of case (for printing)
showCaseL = false;
// place complete lidFrame
showLidFrame = false;
// place lidFrame parts divided into 2 side parts and 2 parts
showAllLidFrameParts = false;
// show electronics case
showPcbCase = false;
// show stand
showStand = false;
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

// movement of ocb case depends on cutout of lvds connector
movePcbCaseX = connectorXmove + diffMovePcbCaseX;
movePcbCaseY = connectorYmove + diffMovePcbCaseY;

completeX = absDisplayX + sideClearance*2 + verticalFrameWidth*2;
completeY = absDisplayY + sideClearance*2 + upperFrameWidth + lowerFrameWidth;

screwTopYMove=(absDisplayY+upperFrameWidth/2+lowerFrameWidth+sideClearance);
screwMaxXMove=(absDisplayX+verticalFrameWidth*2+sideClearance*2);
screwThirdXMove= (absDisplayX+verticalFrameWidth*2+sideClearance*2)/3;

frameScrews = [
  [verticalFrameWidth/2,lowerFrameWidth/2],
  [verticalFrameWidth/2,screwTopYMove],

  [screwMaxXMove-verticalFrameWidth/2,lowerFrameWidth/2],
  [screwMaxXMove-verticalFrameWidth/2,screwTopYMove],

  [screwThirdXMove-verticalFrameWidth,lowerFrameWidth/2],
  [screwThirdXMove-verticalFrameWidth,screwTopYMove],
  [screwThirdXMove+verticalFrameWidth,lowerFrameWidth/2],
  [screwThirdXMove+verticalFrameWidth,screwTopYMove],

  [screwThirdXMove*2-verticalFrameWidth,lowerFrameWidth/2],
  [screwThirdXMove*2-verticalFrameWidth,screwTopYMove],
  [screwThirdXMove*2+verticalFrameWidth,lowerFrameWidth/2],
  [screwThirdXMove*2+verticalFrameWidth,screwTopYMove]
];

additionalFrameScrews = [
  // lower holes
  /* [verticalFrameWidth+sideClearance+117,lowerFrameWidth/2],
  [verticalFrameWidth+sideClearance+absDisplayX-117,lowerFrameWidth/2], */
  // upper holes
  /* [verticalFrameWidth+sideClearance+117,completeY-lowerFrameWidth/2],
  [verticalFrameWidth+sideClearance+absDisplayX-117,completeY-lowerFrameWidth/2] */
];


midTemp = (lowerFrameWidth+upperFrameWidth+absDisplayY)/2;
rightSideTemp = verticalFrameWidth*2 + sideClearance*2 + absDisplayX - verticalFrameWidth/2;
backFrameMountingInserts = [
  // left side mounting insert holes
  [verticalFrameWidth/2,midTemp-(lowerFrameWidth+upperFrameWidth+absDisplayY)/4],
  [verticalFrameWidth/2,midTemp],
  [verticalFrameWidth/2,midTemp+(lowerFrameWidth+upperFrameWidth+absDisplayY)/4],
  // right side mounting insert holes
  [rightSideTemp,midTemp-(lowerFrameWidth+upperFrameWidth+absDisplayY)/4],
  [rightSideTemp,midTemp],
  [rightSideTemp,midTemp+(lowerFrameWidth+upperFrameWidth+absDisplayY)/4],
];


pcbCaseFrameScrews = [
  [10,pcbCaseHorizontalWallThickness/2],
  [-10+pcbCaseVerticalWallThickness*2+pcbCaseInnerX,pcbCaseHorizontalWallThickness/2],
  [10,pcbCaseHorizontalWallThickness+pcbCaseHorizontalWallThickness/2+pcbCaseInnerY],
  [-10+pcbCaseVerticalWallThickness*2+pcbCaseInnerX,pcbCaseHorizontalWallThickness+pcbCaseHorizontalWallThickness/2+pcbCaseInnerY]
];


// pcb holes
caseStandoffPoints = [
  [3,2],
  [pcbX-2,11],

  [3,pcbY-2.5],
  [pcbX-3,pcbY-2.5]
];

/* stand length in y direction */
lengthY = ((lowerFrameWidth+upperFrameWidth+absDisplayY)/4 ) * 2 + 10;
/* cutout length for hinges of stand */
standCutoutLen = (lengthY - 10*3)/2 - 10;
/* some move parameter */
moveYtemp = 15;
stand2Zlen = 50;

if(showAssembly == false && showDisplay == true)
{
  LaptopDisplay(absDisplayX, absDisplayY, absDisplayZ, screenX, screenY, screenZ);
}


if(showAssembly == true)
{
  rotate([76,0,0])
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

if(showAssembly == false && showLidFrame == false && showAllLidFrameParts == true)
{
  difference()
  {
    lidFrame();

    translate([screwThirdXMove,-extra,-extra])
    cube([completeX+extra,completeY+extra*2,
      lidFrameThickness+extra*2]);
  }


  translate([verticalFrameWidth*3,screwThirdXMove*2+lowerFrameWidth*5,0])
  rotate([0,0,-90])
  difference()
  {
    lidFrame();

    translate([0,-extra,-extra])
    cube([screwThirdXMove,completeY+extra*2,
      lidFrameThickness+extra*2]);

    translate([screwThirdXMove*2,-extra,-extra])
    cube([completeX+extra,completeY+extra*2,
      lidFrameThickness+extra*2]);
  }

  translate([verticalFrameWidth*2-screwThirdXMove*2,lowerFrameWidth*2,0])
  difference()
  {
    lidFrame();

    translate([0,-extra,-extra])
    cube([screwThirdXMove*2,completeY+extra*2,
      lidFrameThickness+extra*2]);


  }
}

if(showAssembly == false && showCase == false && showCaseL == true)
{
  difference()
  {
    displayCase();

    absoluteX = verticalFrameWidth*2 + sideClearance*2 + absDisplayX;
    absoluteY = upperFrameWidth + lowerFrameWidth + sideClearance*2 + absDisplayY;

    translate([absoluteX/2,-extra,-extra])
    cube([absoluteX/2+extra,absoluteY+extra*2,
      absDisplayZ+backwallThickness+backwallClearance+extra*2]);

  }
}

if(showAssembly == false && showCase == false && showCaseR == true)
{
  translate([10,0,0])
  difference()
  {
    displayCase();

    absoluteX = verticalFrameWidth*2 + sideClearance*2 + absDisplayX;
    absoluteY = upperFrameWidth + lowerFrameWidth + sideClearance*2 + absDisplayY;

    translate([-extra,-extra,-extra])
    cube([absoluteX/2+extra,absoluteY+extra*2,
      absDisplayZ+backwallThickness+backwallClearance+extra*2]);

  }
}


if(showAssembly == false && showCase == false && showStand == true)
{
  /* translate([-12.50,0,0])
  mirror([1,0,0])*/

  translate([5,0,0])
  rotate([0,90,0])
  difference()
  {
    union()
    {
      stand();
      stand2();
    }
    if(cutView == true)
    {
      translate([5,-extra,-extra])
      cube([10,lengthY+extra*2,20]);
    }
  }

  rotate([0,90,0])
  mirror([0,0,1])
  difference()
  {
    union()
    {
      stand();
      stand2();
    }
    if(cutView == true)
    {
      translate([5,-extra,-extra])
      cube([10,lengthY+extra*2,20]);
    }
  }
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

      translate([movePcbCaseX,movePcbCaseY,0])
      translate([0,0,-pcbCaseInnerZ-pcbCaseBottomThickness])
      pcbCase();

      mirror([0,0,1])
      {
        translate([10,midTemp-5-(lowerFrameWidth+upperFrameWidth+absDisplayY)/4,0])
        mirror([1,0,0])
        union()
        {
          stand();
          stand2();
        }
        translate([completeX-10,midTemp-5-(lowerFrameWidth+upperFrameWidth+absDisplayY)/4,0])
        union()
        {
          stand();
          stand2();
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
  pcbCaseXBottom = pcbCaseInnerX + pcbCaseVerticalWallThickness*2;
  pcbCaseXTop = pcbCaseInnerX + pcbCaseVerticalWallThickness*2 + pcbCaseInnerZ;
  pcbCaseYTemp = pcbCaseInnerY + pcbCaseHorizontalWallThickness*2;
  pcbCaseZTemp = pcbCaseInnerZ + pcbCaseBottomThickness;

  tempMoveXCableSpace = pcbCaseXBottom-pcbCaseVerticalWallThickness+extra;
  tempZCableSpace = pcbCaseBottomThickness+pcbCaseInnerZ-externPcbCableSpace;

  difference() {
    union()
    {
      difference()
      {
        hull()
        {
          cube([pcbCaseXBottom,pcbCaseYTemp,extra]);

          translate([0,0,pcbCaseZTemp-extra])
          cube([pcbCaseXTop,pcbCaseYTemp,extra]);
        }

        hull()
        {
          translate([pcbCaseVerticalWallThickness,pcbCaseHorizontalWallThickness,pcbCaseBottomThickness])
          cube([pcbCaseXBottom-pcbCaseVerticalWallThickness*2,
            pcbCaseYTemp-pcbCaseHorizontalWallThickness*2,extra]);

          translate([pcbCaseVerticalWallThickness,pcbCaseHorizontalWallThickness,pcbCaseZTemp])
          cube([pcbCaseXTop-pcbCaseVerticalWallThickness*2,pcbCaseYTemp-pcbCaseHorizontalWallThickness*2,extra]);
        }
      } /* difference */

      // move ALL standoffs by pcbCaseHorizontalWallThickness & pcbCaseBottomThickness
      translate([0,pcbCaseHorizontalWallThickness+1,pcbCaseBottomThickness])
      translate([moveDiffPcbX,moveDiffPcbY,0])
      cylinderList(dia=9,height=3, points=caseStandoffPoints);
    } /* union */
    // move ALL standoffs by pcbCaseHorizontalWallThickness & pcbCaseBottomThickness
    translate([0,pcbCaseHorizontalWallThickness+1,0])
    translate([moveDiffPcbX,moveDiffPcbY,0])
    cylinderList(dia=3.8,height=pcbCaseBottomThickness+3+extra, points=caseStandoffPoints);


    // remove left sidewall where connectors of pcb are placed
    translate([-extra,pcbCaseHorizontalWallThickness,pcbCaseBottomThickness])
      cube([pcbCaseVerticalWallThickness+extra*2,pcbCaseInnerY,pcbCaseInnerZ+extra]);

    // remove a small slot to get the cable out for the control button pcb
    translate([pcbCaseXTop-pcbCaseVerticalWallThickness*3,pcbCaseHorizontalWallThickness,tempZCableSpace])
      cube([pcbCaseVerticalWallThickness*4,pcbCaseInnerY,externPcbCableSpace +extra]);

    // remove holes for screws or inserts
    pcbCaseFrameScrews(pcbCaseMountUseInserts);
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

    translate([movePcbCaseX,movePcbCaseY,-extra])
      cylinderList(dia=3.5,height=backwallThickness+extra*2,points=pcbCaseFrameScrews);


    translate([0,0,tempZ-insertH])
      cylinderList(dia=insertDia,height=insertH+extra,points=additionalFrameScrews);

    if(backMountingHoles == true)
    {
      translate([0,0,-extra])
        cylinderList(dia=insertDia ,height=insertH+extra, points=backFrameMountingInserts);
    }
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
      lowerFrameWidth+sideClearance+(absDisplayY-screenY)/2,
      -extra])
    cube([screenX+sideClearance*2,screenY+sideClearance*2,absDisplayZ+backwallClearance+extra]);

    LidScrewPlacement();
  }
}


module stand()
{
  /* lengthY = ((lowerFrameWidth+upperFrameWidth+absDisplayY)/4 ) * 2 + 10; */
  difference()
  {
    union()
    {

      cube([10,lengthY,10]);

      translate([0,0,10])
      hull()
      {
        cube([10,lengthY,0.1]);

        translate([5/2,0,2.5])
        cube([5+5/2,lengthY,0.1]);
      }
    }
    translate([0,5-(lowerFrameWidth+upperFrameWidth+absDisplayY)/4,-extra])
      cylinderList(dia=frameScrewDia+0.4 ,height=10+2.6+extra*2, points=backFrameMountingInserts);

    translate([0,5-(lowerFrameWidth+upperFrameWidth+absDisplayY)/4,12.6-frameScrewHeadLen])
      cylinderList(dia=screwHeadThickness ,height=frameScrewHeadLen+extra, points=backFrameMountingInserts);



    translate([-extra,15,2.6+extra])
      cube([10+extra*2,standCutoutLen,10]);

    translate([-extra,lengthY/2+10,2.6+extra])
      cube([10+extra*2,standCutoutLen,10]);


    translate([5, moveYtemp, 10-(12.6-10)])
    rotate([-90,0,0])
    coneCutout();

    translate([5, moveYtemp+standCutoutLen, 10-(12.6-10)])
    rotate([-90,0,0])
    coneCutout();

    translate([0,standCutoutLen+20,0])
    union()
    {
      translate([5, moveYtemp, 10-(12.6-10)])
      rotate([-90,0,0])
        coneCutout();

      translate([5, moveYtemp+standCutoutLen, 10-(12.6-10)])
      rotate([-90,0,0])
        coneCutout();
    }
  }
}



module stand2()
{
  difference()
  {
    union()
    {
      stand2body();

      hull()
      {
        translate([0,0,12.6+1])
        cube([10,0.1,stand2Zlen-1]);
        translate([0,standFeetLength,12.6+stand2Zlen-stand2Zlen/4])
        rotate([standFeetPlateDegree,0,0])
        cube([10,0.1,stand2Zlen/4]);
      }
    }

    // cutout to save material
    translate([0,0,12.6+1+10])
    hull()
    {
      translate([-extra,10,0])
      cube([10+extra*2,1,stand2Zlen-1-20]);
      translate([-extra,lengthY-1-10,0])
      cube([10+extra*2,1,(stand2Zlen-1)/2-16]);
    }

  }

}

module stand2body()
{
  union()
  {
    translate([0,0,12.6+1])
    hull()
    {
      cube([10,5,stand2Zlen-1]);
      translate([0,lengthY-1,0])
      cube([10,1,(stand2Zlen-1)/2]);
    }

    translate([0,moveYtemp,0])
    {
      hull()
      {
        translate([5/2,0+0.4,2.6+1])
        cube([5,standCutoutLen-0.8,0.1]);
        translate([0,0+0.4,2.6*2+1])
        cube([10,standCutoutLen-0.8,0.1]);
      }
      translate([0,0+0.4,2.6*2+1])
      cube([10,standCutoutLen-0.8,10-2.6]);
    }

    translate([0,lengthY/2+10,0])
    {
      hull()
      {
        translate([5/2,0.4,2.6+1])
        cube([5,standCutoutLen-0.8,0.1]);
        translate([0,0.4,2.6*2+1])
        cube([10,standCutoutLen-0.8,0.1]);
      }
      translate([0,0.4,2.6*2+1])
      cube([10,standCutoutLen-0.8,10-2.6]);
    }

    translate([5, moveYtemp+0.4, 10-(12.6-10)])
    rotate([-90,0,0])
    coneCutout();

    translate([5, moveYtemp+standCutoutLen-0.4, 10-(12.6-10)])
    rotate([-90,0,0])
    coneCutout();

    translate([0,standCutoutLen+20,0])
    union()
    {
      translate([5, moveYtemp+0.4, 10-(12.6-10)])
      rotate([-90,0,0])
        coneCutout();

      translate([5, moveYtemp+standCutoutLen-0.4, 10-(12.6-10)])
      rotate([-90,0,0])
        coneCutout();
    }
  }
}


module coneCutout()
{
  scale([1.05,1.05,1.05])
  cone();
}

module cone()
{
  cylinder(r1=3,r2=1.5,h=2);
  rotate([180,0,0])
  cylinder(r1=3,r2=1.5,h=2);
}


module pcbCaseFrameScrews(inserts = false)
{
  for(point = pcbCaseFrameScrews)
  {
    translate([point[0],point[1],0])
    union()
    {
      if(inserts == true)
      {
        insertLength=insertH+2;

        translate([0,0,pcbCaseBottomThickness+pcbCaseInnerZ-insertLength])
        /* mirror([0,0,1]) */
        screw(screwD = insertDia, screwLen=insertLength,
          screwHeadD = 0, screwHeadLength = 0);
      }else{
        translate([0,0,pcbCaseBottomThickness+pcbCaseInnerZ+extra])
        mirror([0,0,1])
        screw(screwD = pcbCaseMountScrewDia, screwLen=pcbCaseMountScrewLen,
          screwHeadD = pcbCaseMountScrewDia, screwHeadLength = pcbCaseMountScrewHeadLen);
      }
    }
  }
}



module cylinderList(dia=9,height=3,points=[[0,0],[0,0]])
{
  for(point = points)
  {
    translate([point[0],point[1],0])
    cylinder(r=dia/2, h=height);
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
        assert((backwallClearance+absDisplayZ) > insertH,
          "Warning: Insert is higher than Frame Thickness (excluded backwallThickness)!!");

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

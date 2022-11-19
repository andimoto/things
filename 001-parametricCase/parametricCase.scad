/* parametricCase.scad
Author: andimoto@posteo.de
----------------------------
*/
$fn=75;
//debug parameter
extra=0.1;

// inner case parameter x
caseX=31.5;
// inner case parameter y
caseY=70;
// inner case parameter z
caseZ=35;

// wall thickness will be added to each side
wallThickness=2;

/* Param snapInBlockY sets the amount of snap-in lines on the lid
   and the case (snap-in lines don't go through the complete case/lid)
*/
// length of snap-in line (lid & case)
snapInBlockY=30;
// thicknes of the snap-in part (lid/case)
snapInBlockZ=1.5;

/* this gives a clearance for the snapInBlocks to be cut away
   only for lid part. it cuts out some material from the snapInBlocks
   (better said: from the inner middle) to save some filament. */
// clearance between lid cutout and snap-in side of the lid
snapInBlockClearance=8;

// lid thickness (just top part; not inner)
lidThickness=2;
// snapIn bulge radius
lidFixRad=1;
// fine tuning of the bulge line
lidFixXMov=0.5;

// clearance of the inner lid part to the case
lidClearance = 0.15;

// screw plate Y thickness
screwPlateY=10;
// screw plate height
screwPlateZ=4;

// screw radius of the screw plate
screwR=3/2;
// radius of screw head
screwHeadR=5/2;

pocketX = 20;


/*
'paramCase' : creates a case with given parameters
parameter: 'caseMountingEnable' creates some 'wings'
at side of the case to enable mounting case with screws
*/
module paramCase(caseMountingEnable = false)
{
  difference() {
    cube([caseX+wallThickness*2,caseY+wallThickness*2,caseZ+snapInBlockZ*2+wallThickness]);
    translate([wallThickness,wallThickness,wallThickness]) cube([caseX,caseY,caseZ+snapInBlockZ*2+extra]);

    /* place cutout for left side into this module */
    cutoutLeft();

    /* place cutout for right side into this module */
    translate([caseX+wallThickness,wallThickness,0])
    rotate([90,0,90])
    cutoutRight();

    /* place cutout for y=caseY side into this module */
    cutoutUpper();

    /* place cutout for front side into this module */
    cutoutLower();

    /* place cutout for bottom side into this module */
    cutoutBottom();

    /* fixBlock */
    translate([wallThickness,0,caseZ+wallThickness])
      lidFixBlock(lidPart = false);
    translate([wallThickness,caseY+wallThickness*2-snapInBlockY,caseZ+wallThickness])
      lidFixBlock(lidPart = false);
  }


  if(caseMountingEnable == true)
  {
    translate([0,-screwPlateY,0]) screwPlate();
    translate([0,caseY+wallThickness*2,0]) screwPlate();
  }
}

/* return clearence parameter for lidFixBlocks to separate between cutout from case
and actual lid part */
function getLidClearance(lid = true) = (lid==true) ? lidClearance : 0;
module lidFixBlock(lidPart = true)
{
  union()
  {
    translate([getLidClearance(lidPart),0,0])
      cube([caseX-getLidClearance(lidPart)*2,snapInBlockY,snapInBlockZ*2]);
    translate([lidFixXMov+getLidClearance(lidPart),0,snapInBlockZ]) rotate([-90,0,0])
      cylinder(r=lidFixRad,h=snapInBlockY);
    translate([caseX-lidFixXMov-getLidClearance(lidPart),0,snapInBlockZ]) rotate([-90,0,0])
      cylinder(r=lidFixRad,h=snapInBlockY);
  }
}
/* lidFixBlock(); */




/* ###################################################################################### */
/* ###################################################################################### */
/* ###################################################################################### */
/* Everything from here are extra modules which can be 'filled' */
/* or created to generate specific cutouts or other modules */

/* place your cutout design for the left here
   left means x = 0
*/
module cutoutLeft()
{
  /* example */
  /* translate([0,caseY/2,caseZ/2])
  cube([wallThickness, 10,10]); */
}

/* place your cutout design for the lid here
   right means x = caseX+wall
*/
module cutoutRight()
{
  /* example */
  translate([2,0,0])
  union()
  {
    translate([12.4-6,8,0]) cube([13,5,wallThickness*2]);
    translate([41.4-4,6,0]) cube([10,8,wallThickness*2]);
    translate([54-4,6,0]) cube([10,8,wallThickness*2]);
  }

  translate([27,22,0]) cube([20,10,wallThickness*2]);
}

/* place your cutout design for the lid here
   right means x = caseX+wall
*/
module cutoutUpper()
{
  /* example */
  /* translate([caseX/2,caseY+wallThickness,caseZ/2])
  cube([10,wallThickness,10]); */
}

module cutoutLower()
{
  /* example */
  /* translate([caseX/2,0,caseZ/2])
  cube([10,wallThickness,10]); */
}

/* place your cutout design for the bottom here */
module cutoutBottom()
{
  /* example */
  holeArray = [[0,0],[23,0],[23,58],[0,58]];
  bottomScrewR = 2.8/2;
  /* i=0; */

  translate([wallThickness+1+3.5,wallThickness+2+3.5,0])
  for(hole = holeArray)
  {

    translate([ hole[0], hole[1], 0]) cylinder(r=bottomScrewR, h=wallThickness*3+extra);
  }
}

/* ***** module for cutting out the window from the lid *****
   this function is optional and only defines the cutout for the lid.
   if this is not needed, this function can be removed and the call
   should be also removed from 'cutoutLid()' hook */
module cutOutLidWindow()
{
  windowX = 50;
  windowY = 100;
  windowPosX = 0;
  windowPosY = 10;
  rad = 1;

  /* position cutout */
  translate([windowPosX,windowPosY,-extra])
  /* move cutout into the middle */
  translate([caseX/2+wallThickness-(windowX)/2,0,0])
  /* compensate minkowski() */
  translate([rad,rad,0])
  minkowski() {
    cube([windowX-rad*2,windowY-rad*2,lidThickness+extra*2]);
    cylinder(r=rad,h=0.0000001);
  }


  /* cutout some screws */
  screwR = 3.2/2; // using 3mm screw
  screwHoleArray = [
    /* upper and lower screws */
    [-windowX/2+5,windowPosY-5],
    [-windowX/2+5,windowY+windowPosY+5],
    [windowX/2-5,windowPosY-5],
    [windowX/2-5,windowY+windowPosY+5],
    /* screws on left and right */
    [-windowX/2-5,windowPosY+5],
    [-windowX/2-5,windowY+windowPosY-5],
    [windowX/2+5,windowPosY+5],
    [windowX/2+5,windowY+windowPosY-5]
  ];

  for(hole = screwHoleArray)
	{
		translate([hole[0],hole[1],0])
    translate([wallThickness+caseX/2,0,-snapInBlockZ*2])
    cylinder(r=3.2/2,h=lidThickness+snapInBlockZ*2);
	}

}

module cutoutPSCableHole()
{
  psCableHolePosY = 140;
  psCableHolePosX = 15;
  psCableR = 15;

  translate([caseX+wallThickness+2-psCableHolePosX,psCableHolePosY+wallThickness-psCableR,-snapInBlockZ*2])
  cube([psCableHolePosX,psCableR*2, lidThickness+snapInBlockZ*2]);
  translate([caseX+wallThickness+2-psCableHolePosX,psCableHolePosY+wallThickness,-snapInBlockZ*2])
  cylinder(r=psCableR,h=lidThickness+snapInBlockZ*2);
}

module cutoutUSBCableHole()
{
  usbCableHolePosY = 190;
  usbCableHolePosX = 20;
  usbCableR = 10;

  translate([caseX+wallThickness+2-usbCableHolePosX,usbCableHolePosY+wallThickness-usbCableR,-snapInBlockZ*2])
  cube([usbCableHolePosX,usbCableR*2, lidThickness+snapInBlockZ*2]);
  translate([caseX+wallThickness+2-usbCableHolePosX,usbCableHolePosY+wallThickness,-snapInBlockZ*2])
  cylinder(r=usbCableR,h=lidThickness+snapInBlockZ*2);
}


module airVent()
{
  hull()
  {
    translate([wallThickness+caseX/2-caseX/6,0,0]) cylinder(r=2,h=wallThickness*3);
    translate([wallThickness+caseX/2+caseX/6,0,0]) cylinder(r=2,h=wallThickness*3);
  }
}

module cutoutLid()
{
  cutoutBottom();

  translate([0,wallThickness+caseY/2-caseY/4,0]) airVent();
  translate([0,wallThickness+caseY/2-caseY/8,0]) airVent();
  translate([0,wallThickness+caseY/2,0]) airVent();
  translate([0,wallThickness+caseY/2+caseY/8,0]) airVent();
  translate([0,wallThickness+caseY/2+caseY/4,0]) airVent();
}

/* ##########################end of custom lid cutout structure ######################### */

module screwPlate()
{
  difference() {
    cube([caseX+wallThickness*2,screwPlateY,wallThickness]);
    translate([(caseX+wallThickness*2)/2,screwPlateY/2,wallThickness/2]) cylinder(r1=screwR,r2=screwHeadR,h=wallThickness/2);
    translate([(caseX+wallThickness*2)/2,screwPlateY/2,0]) cylinder(r=screwR,h=wallThickness/2);
  }
}


module paramCaseLid(cutoutLidEnable = false)
{
  difference()
  {
    union()
    {
      /* lid */
      translate([0,0,snapInBlockZ*2]) cube([caseX+wallThickness*2,caseY+wallThickness*2,wallThickness]);

      /* fixation block will be cut out from wall */
      translate([wallThickness,0,0])
        lidFixBlock();
      /* fixation block will be cut out from wall */
      translate([wallThickness,caseY+wallThickness*2-snapInBlockY,0])
        lidFixBlock();
    } /* union lid */
    /* cutout for snapInBlocks to save some filament */
    translate([wallThickness+snapInBlockClearance,wallThickness+snapInBlockClearance,0])
      cube([(caseX-snapInBlockClearance*2),(caseY-snapInBlockClearance*2),snapInBlockZ*2]);

    /* cutout a pocket in the lid to enable easier opening with fingers */
    translate([caseX/2+wallThickness-pocketX/2,/*wallThickness+snapInBlockClearance*/0,0])
      cube([pocketX,wallThickness,snapInBlockZ]);
    translate([caseX/2+wallThickness-pocketX/2,caseY+wallThickness,0])
      cube([pocketX,wallThickness,snapInBlockZ]);

    if(cutoutLidEnable == true)
      cutoutLid();
  }
}


module otherCutouts()
{
  /* place other cutous here and place "otherCutouts()" in modules where you need it */
}


module completeModel(caseMounting = true, lidCutout = true)
{
  /* place case */
  paramCase( caseMountingEnable = caseMounting );

  /* place lid */
  translate([-20,0,lidThickness+snapInBlockZ*2])
  rotate([0,180,0])
  paramCaseLid( cutoutLidEnable = lidCutout );
}

/*
###########################################################################################
#####################################      Model Placing      #############################
###########################################################################################
*/
//   uncomment model functions
//   remove '/* .. */' or '//' from functions to enable them

completeModel(caseMounting = true, lidCutout = true);

/* paramCase( caseMountingEnable = true ); */
/* paramCaseLid( cutoutLidEnable = true ); */

/* ################################# Debug Cutouts ##########################################*/
/* if cutouts on the sides are needed, remove comments from needed cutouts and create them   */
/* without the other models. when ready, place the case models and check if your cutouts fits*/
/* ##########################################################################################*/

/* cutoutBottom(); */
/* cutoutRight(); */
/* cutoutLeft(); */
/* cutoutBack(); */
/* cutoutFront(); */

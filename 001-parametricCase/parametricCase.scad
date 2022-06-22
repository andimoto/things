$fn=75;
extra=0.1; //debug parameter

/* inner case parameters */
caseX=70;
caseY=210;
caseZ=80;

/* wall thickness will be added to each side */
wallThickness=2;

snapInBlockY=30;
snapInBlockZ=1.5;

/* this gives a clearance for the snapInBlocks to be cutout.
   only for lid part. it cuts out some material from the snapInBlocks
   to save some filament. */
snapInBlockClearance=8;

lidThickness=2;
/* snapIn bulge radius */
lidFixRad=1;
lidFixXMov=0.5;

lidClearance = 0.2;

screwPlateY=10;
screwPlateZ=4;

screwR=3.2/2;
screwHeadR=5/2;

pocketX = 20;

module paramCase(screwPlateUpDown = false)
{
  difference() {
    cube([caseX+wallThickness*2,caseY+wallThickness*2,caseZ+snapInBlockZ*2+wallThickness]);
    translate([wallThickness,wallThickness,wallThickness]) cube([caseX,caseY,caseZ+snapInBlockZ*2+extra]);

    /* place cutout for left side into this module */
    cutoutLeft();

    /* place cutout for right side into this module */
    cutoutRight();

    /* place cutout for head side into this module */
    cutoutBack();

    /* place cutout for bottom side into this module */
    cutoutFront();

    /* fixBlock */
    translate([wallThickness,0,caseZ+wallThickness])
      lidFixBlock(lidPart = false);
    translate([wallThickness,caseY+wallThickness*2-snapInBlockY,caseZ+wallThickness])
      lidFixBlock(lidPart = false);
  }

  if(screwPlateUpDown == true)
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

module cutoutLeft()
{

}

module cutoutRight()
{

}

module cutoutBack()
{
  /* translate([wallThickness,caseY+wallThickness,wallThickness+pcbZ-pcbThickness])
    cube([caseX,wallThickness,potiZ+pcbThickness]); */
}

module cutoutFront()
{

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
  cableHolePosY = 175;
  cableHolePosX = 20;
  cableR = 5;

  translate([caseX+wallThickness+2-cableHolePosX,cableHolePosY+wallThickness-cableR,0])
  cube([cableHolePosX,cableR*2, lidThickness]);
  translate([caseX+wallThickness+2-cableHolePosX,cableHolePosY+wallThickness,0])
  cylinder(r=cableR,h=lidThickness);
}

module cutoutUSBCableHole()
{
  cableHolePosY = 140;
  cableHolePosX = 15;
  cableR = 10;

  translate([caseX+wallThickness+2-cableHolePosX,cableHolePosY+wallThickness-cableR,0])
  cube([cableHolePosX,cableR*2, lidThickness]);
  translate([caseX+wallThickness+2-cableHolePosX,cableHolePosY+wallThickness,0])
  cylinder(r=cableR,h=lidThickness);
}

module cutoutLid()
{
  translate([0,0,snapInBlockZ*2])
  cutOutLidWindow();


  translate([0,0,snapInBlockZ*2])
  cutoutPSCableHole();

  translate([0,0,snapInBlockZ*2])
  cutoutUSBCableHole();
}

/* cutoutLid(); */

module screwPlate()
{
  difference() {
    cube([caseX+wallThickness*2,screwPlateY,wallThickness]);
    translate([(caseX+wallThickness*2)/2,screwPlateY/2,wallThickness/2]) cylinder(r1=screwR,r2=screwHeadR,h=wallThickness/2);
    translate([(caseX+wallThickness*2)/2,screwPlateY/2,0]) cylinder(r=screwR,h=wallThickness/2);
  }
}
/* translate([0,-screwPlateY,0]) screwPlate(); */

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


module windowFrame()
{
  rad=3;
  difference() {
    translate([rad+wallThickness+caseX/2-(caseX-wallThickness)/2,rad,0])
    minkowski()
    {
      cube([caseX-wallThickness-rad*2,120-rad*2,lidThickness]);
      cylinder(r=rad, h=0.0000001);
    }

    cutOutLidWindow();

  }
}
/* translate([0,0,lidThickness+snapInBlockZ*2+2]) */
#windowFrame();
/* paramCase(); */

/* translate([-10,0,lidThickness+snapInBlockZ*2])
rotate([0,180,0]) */
/* translate([0,0,22]) */
/* paramCaseLid(); */

/* paramCaseLid(true); */

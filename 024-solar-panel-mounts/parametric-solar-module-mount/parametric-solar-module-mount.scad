$fn=80;
extra=0.02;

/* [Show Parts] */
// Show Top Clamps for fixing Solar Panels
showClamps = true;
// Show Main Frame Solar Panels
showFrame = true;
// Show Hinge
showHinge = true;

/* [Solar Panel Parameter] */
// Solar Panel X Len [mm]
solPnlX = 80;
// Solar Panel Y Len [mm]
solPnlY = 45;
// Solar Panel Z Height [mm]
solPnlZ = 2;
// Solar Panel Clearance to Frame
solPnlClearance = 1.5;
// Move Solar Panel in Z
solPnlZMove = 0;
// Solar Panel count in X Direction
solPnlCntX = 2;
// Solar Panel count in Y Direction
solPnlCntY = 2;

/* [Screw Parameters] */
// Screw Diameter
screwDia = 3.2;
// Screw Length (or cutout depth of screws)
screwLen = 8;
// Move outer screws into the middle
sideScrewXMove = 3;

/* [Frame Parameters] */
mountFrame1X = 10;
mountFrame2X = 10;
mountFrameMid = 8;
mountFrame1Y = 3;
mountFrame2Y = 3;
mountFrameZ = 5;
mountFrame2Move = mountFrameZ + 1;

/* [Solar Panels Clamp Parameters] */
// Clamp Length (y Direction)
clampYLen = 60;
// Clamp Height (z Direction)
clampZLen = 1;
// Additional Y Move
clampYMove = 8;
// Screw Hole x Move
clampScrewXMove = 5;
// Screw Hole y Move
clampScrewYMove = 0;
// Clamp Fixture Y Move
clampFixtureYMove = 10;
// Clamp Fixture Pin Dia
clampFixturePinDia = 4;
// Clamp Fixture Pin Z Len
clampFixturePinZ = 4;
// Clamp Fixtur Key Length X
clampFixtureKeyX = 5;
// Clamp Fixtur Key Length Y
clampFixtureKeyY = 2;

/* [Hinge Plate Parameters] */
// Hinge Plate Width (x Direction)
hingePlateX = 20;
// Hinge Plate Length (y Direction)
hingePlateY = 110;
// Hinge Plate Thickness (z Direction)
hingePlateZ = mountFrameZ + 3;
// Cutout to Frame
hingeToFrameCutout = 10;
// Clearance for cutout
hingeFrameClearance = 1;
// additional x move
hingePlateMoveX = 0;
// additional y move
hingePlateMoveY = 0;

/* [Other Parameters] */
tempX = mountFrame1X + ((solPnlX)*solPnlCntX) + (mountFrameMid * (solPnlCntX-1)) +  mountFrame2X;
tempY = mountFrame1Y + (solPnlY)*solPnlCntY + mountFrame2Y;
tempCutX = solPnlX - solPnlClearance*2;
tempCutY = (solPnlY*solPnlCntY) + extra;

clampYLenTemp = tempY - screwLen*2;

if(showHinge == true)
{
  hingePlate();
}

module hingePlate()
{
  tempYMove = (hingePlateY - tempY)/2;
  tempZMove = (mountFrameZ - hingePlateZ);
  difference()
  {
    translate([-hingeToFrameCutout-hingeFrameClearance,-tempYMove,tempZMove])
    cube([hingePlateX,hingePlateY,hingePlateZ]);

    translate([-hingeFrameClearance,-hingeFrameClearance,tempZMove-extra])
    cube([hingeToFrameCutout+extra,hingePlateY-tempYMove*2+hingeFrameClearance*2,hingePlateZ+extra*2]);

    translate([0,0,tempZMove+hingePlateZ/2])
    union()
    {
      translate([sideScrewXMove,
        hingePlateY-tempYMove-screwLen+extra, 0])
      rotate([-90,0,0])
      cylinder(d=screwDia+0.5,h=screwLen+extra*2);
      translate([sideScrewXMove,
        hingeFrameClearance-hingeToFrameCutout, 0])
      rotate([-90,0,0])
      cylinder(d=screwDia+0.5,h=screwLen+extra*2);
    }
  }
}

module clampPlate(xLen=10, yLen=20, zLen=1, screwXPos=0,fixture=true,
  fixtureDia=4, fixtureZ=4, cutoutExtra=0)
{
  difference()
  {
    cube([xLen+cutoutExtra,yLen,zLen]);
    translate([screwXPos,yLen/2-extra,-extra])
    cylinder(d=screwDia,h=screwLen+extra*2);
  }
  if(fixture==true)
  {
    translate([xLen/2,clampFixtureYMove,-fixtureZ])
    clampPin(pinDia=fixtureDia+cutoutExtra, pinL=fixtureZ,
      lx=clampFixtureKeyX+cutoutExtra,ly=clampFixtureKeyY+cutoutExtra,rot=90);
    translate([xLen/2,yLen-clampFixtureYMove,-fixtureZ])
    clampPin(pinDia=fixtureDia+cutoutExtra, pinL=fixtureZ,
      lx=clampFixtureKeyX+cutoutExtra,ly=clampFixtureKeyY+cutoutExtra,rot=-90);
  }
}

if(showClamps == true)
{
  translate([0,clampYMove,mountFrameZ])
  clampPlate(xLen=mountFrame1X+solPnlClearance, yLen=clampYLenTemp, zLen=clampZLen,
    screwXPos=clampScrewXMove,fixture=true,
    fixtureDia=clampFixturePinDia, fixtureZ=clampFixturePinZ);

  translate([tempX,clampYMove+clampYLenTemp,mountFrameZ])
  rotate([0,0,180])
  clampPlate(xLen=mountFrame1X+solPnlClearance, yLen=clampYLenTemp, zLen=clampZLen,
    screwXPos=clampScrewXMove,fixture=true,
    fixtureDia=clampFixturePinDia, fixtureZ=clampFixturePinZ);

  if(solPnlCntX > 1)
  {
    for (j=[1:solPnlCntX-1]) {
      tempClampPlateMove = mountFrame1X/2-solPnlClearance/2 + j*(solPnlX + mountFrameMid)
        - mountFrameMid/2;

      translate([tempClampPlateMove,clampYMove,mountFrameZ+extra])
      clampPlate(xLen=mountFrame1X+solPnlClearance, yLen=clampYLenTemp, zLen=clampZLen,
        screwXPos=(mountFrame1X+solPnlClearance)/2, fixture=true,
        fixtureDia=clampFixturePinDia,
        fixtureZ=clampFixturePinZ);
    }
  }
}

/* clampPin(pinDia=4, pinL=4, lx=5,ly=2,rot=90); */
module clampPin(pinDia=4, pinL=4, lx=5,ly=2, rot=0)
{
  rotate([0,0,rot])
  union()
  {
    cylinder(d=pinDia, h=pinL);
    translate([0,-ly/2,0])
    cube([pinDia+lx,ly,pinL]);
  }
}

/* solPnl(); */
module solPnl(yLen=40)
{
  translate([0,0,solPnlClearance/2])
  rotate([-90,0,0])
  hull()
  {
    translate([solPnlClearance,0,0])
      cylinder(r=solPnlClearance, h=yLen);
    translate([solPnlX-solPnlClearance,0,0])
      cylinder(r=solPnlClearance, h=yLen);
  }
}

module solPnlCutout(yLen=40)
{
  cube([solPnlX,yLen,mountFrameZ]);
}


if(showFrame == true)
{
  parametricMount();
}

module parametricMount()
{
  difference()
  {
    cube([tempX,tempY,mountFrameZ]);

    for (i=[0:solPnlCntX-1]) {
      tempMoveX=mountFrame1X + i*(solPnlX + mountFrameMid);
      translate([tempMoveX+solPnlClearance,mountFrame1Y,-extra])
      cube([tempCutX,tempCutY,mountFrameZ+extra*2]);

      /* translate([tempMoveX,mountFrame1Y,solPnlZMove])
      solPnl(yLen=(solPnlY*solPnlCntY)+extra); */
      translate([tempMoveX,mountFrame1Y,solPnlZMove-solPnlZ])
      translate([0,0,mountFrameZ])
      solPnlCutout(yLen=(solPnlY*solPnlCntY)+extra);
    }



    translate([sideScrewXMove,tempY-screwLen,mountFrameZ/2])
    rotate([-90,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);
    translate([sideScrewXMove,-extra,mountFrameZ/2])
    rotate([-90,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);

    translate([clampScrewXMove,tempY/2-extra,-extra])
    rotate([0,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);

    translate([0,clampYMove,mountFrameZ+extra])
    clampPlate(xLen=mountFrame1X+solPnlClearance,
      yLen=clampYLenTemp, zLen=clampZLen, screwXPos=clampScrewXMove,
      fixture=true, fixtureDia=clampFixturePinDia, fixtureZ=screwLen, cutoutExtra=0.5);




    if(solPnlCntX > 1)
    {
      for (i=[1:solPnlCntX-1]) {
        tempScrewMove = mountFrame1X + i*(solPnlX + mountFrameMid)
          - mountFrameMid/2;

        translate([tempScrewMove,tempY-screwLen,mountFrameZ/2])
        rotate([-90,0,0])
        cylinder(d=screwDia,h=screwLen+extra*2);

        translate([tempScrewMove,-extra,mountFrameZ/2])
        rotate([-90,0,0])
        cylinder(d=screwDia,h=screwLen+extra*2);

        translate([tempScrewMove,tempY/2-extra,-extra])
        rotate([0,0,0])
        cylinder(d=screwDia,h=screwLen+extra*2);

        // pin cutout for clampPlate (tempX-mountFrame1X-solPnlClearance)/2  tempScrewMove
        translate([tempScrewMove-(solPnlClearance+mountFrame1X)/2,clampYMove,mountFrameZ+extra])
        clampPlate(xLen=mountFrame1X+solPnlClearance, yLen=clampYLenTemp, zLen=clampZLen,
          screwXPos=(mountFrame1X+solPnlClearance)/2, fixture=true,
          fixtureDia=clampFixturePinDia,
          fixtureZ=screwLen, cutoutExtra=0.5);
      }
    }

    /* // pin cutout for clampPlate
    translate([(tempX-mountFrame1X-solPnlClearance)/2,clampYMove,mountFrameZ+extra])
    clampPlate(xLen=mountFrame1X+solPnlClearance, yLen=clampYLenTemp, zLen=clampZLen,
      screwXPos=(mountFrame1X+solPnlClearance)/2, fixture=true,
      fixtureDia=clampFixturePinDia,
      fixtureZ=screwLen, cutoutExtra=0.5); */

    translate([tempX-sideScrewXMove,tempY-screwLen,mountFrameZ/2])
    rotate([-90,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);
    translate([tempX-sideScrewXMove,-extra,mountFrameZ/2])
    rotate([-90,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);

    // pin cutout for clampPlate
    translate([tempX-clampScrewXMove,tempY/2-extra,-extra])
    rotate([0,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);

    // pin cutout for clampPlate
    translate([tempX-mountFrame2X-solPnlClearance,clampYMove,mountFrameZ+extra])
    clampPlate(xLen=mountFrame2X+solPnlClearance, yLen=clampYLenTemp, zLen=clampZLen,
      screwXPos=-clampScrewXMove,
      fixture=true, fixtureDia=clampFixturePinDia, fixtureZ=screwLen, cutoutExtra=0.5);
  }
}

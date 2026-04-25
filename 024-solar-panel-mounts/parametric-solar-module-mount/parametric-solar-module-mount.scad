$fn=80;
extra=0.02;

// Solar Panel X Len [mm]
solPnlX = 80;
// Solar Panel Y Len [mm]
solPnlY = 45;
// Solar Panel Z Height [mm]
solPnlZ = 2;

solPnlClearance = 1.5;
solPnlZMove = 0;


solPnlCntX = 2;
solPnlCntY = 2;


screwDia = 3.2;
screwLen = 8;
sideScrewXMove = 3;


mountFrame1X = 10;
mountFrame2X = 10;
mountFrameMid = 8;
mountFrame1Y = 3;
mountFrame2Y = 3;
mountFrameZ = 5;
mountFrame2Move = mountFrameZ + 1;

clampYLen = 60;
clampZLen = 1;
clampScrewXMove = 5;
clampScrewYMove = 0;
clampFixtureYMove = 10;
clampFixturePinDia = 4;
clampFixturePinZ = 4;
clampFixtureKeyX = 5;
clampFixtureKeyY = 2;

tempX = mountFrame1X + ((solPnlX)*solPnlCntX) + (mountFrameMid * (solPnlCntX-1)) +  mountFrame2X;
tempY = mountFrame1Y + (solPnlY)*solPnlCntY + mountFrame2Y;
tempCutX = solPnlX - solPnlClearance*2;
tempCutY = (solPnlY*solPnlCntY) + extra;

clampYLenTemp = tempY - screwLen*2;


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

/* translate([0,screwLen,mountFrameZ])
clampPlate(xLen=mountFrame1X+solPnlClearance, yLen=clampYLenTemp, zLen=clampZLen,
  screwXPos=clampScrewXMove,fixture=true,
  fixtureDia=clampFixturePinDia, fixtureZ=clampFixturePinZ); */


/* #translate([(tempX-mountFrame1X-solPnlClearance)/2,screwLen,mountFrameZ+extra])
clampPlate(xLen=mountFrame1X+solPnlClearance/2, yLen=clampYLenTemp, zLen=clampZLen,
  screwXPos=(mountFrame1X+solPnlClearance)/2, fixture=true, fixtureDia=clampFixturePinDia,
  fixtureZ=screwLen, cutoutExtra=0.5); */


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


parametricMount();

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

    translate([0,screwLen,mountFrameZ+extra])
    clampPlate(xLen=mountFrame1X+solPnlClearance, yLen=clampYLenTemp, zLen=clampZLen, screwXPos=clampScrewXMove,
      fixture=true, fixtureDia=clampFixturePinDia, fixtureZ=screwLen, cutoutExtra=0.5);




    if(solPnlCntX > 1)
    {
      for (i=[1:solPnlCntX-1]) {
        tempScrewMove = mountFrame1X + i*(solPnlX + mountFrameMid) - mountFrameMid/2;
        translate([tempScrewMove,tempY-screwLen,mountFrameZ/2])
        rotate([-90,0,0])
        cylinder(d=screwDia,h=screwLen+extra*2);

        translate([tempScrewMove,-extra,mountFrameZ/2])
        rotate([-90,0,0])
        cylinder(d=screwDia,h=screwLen+extra*2);

        translate([tempScrewMove,tempY/2-extra,-extra])
        rotate([0,0,0])
        cylinder(d=screwDia,h=screwLen+extra*2);
      }
    }

    #translate([(tempX-mountFrame1X-solPnlClearance)/2,screwLen,mountFrameZ+extra])
    clampPlate(xLen=mountFrame1X+solPnlClearance/2, yLen=clampYLenTemp, zLen=clampZLen,
      screwXPos=(mountFrame1X+solPnlClearance)/2, fixture=true, fixtureDia=clampFixturePinDia,
      fixtureZ=screwLen, cutoutExtra=0.5);

    translate([tempX-sideScrewXMove,tempY-screwLen,mountFrameZ/2])
    rotate([-90,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);
    translate([tempX-sideScrewXMove,-extra,mountFrameZ/2])
    rotate([-90,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);

    translate([tempX-clampScrewXMove,tempY/2-extra,-extra])
    rotate([0,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);

    translate([tempX-mountFrame2X-solPnlClearance,screwLen,mountFrameZ+extra])
    clampPlate(xLen=mountFrame2X+solPnlClearance, yLen=clampYLenTemp, zLen=clampZLen, screwXPos=-clampScrewXMove,
      fixture=true, fixtureDia=clampFixturePinDia, fixtureZ=screwLen, cutoutExtra=0.5);
  }
}

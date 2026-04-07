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


mountFrame1X = 6;
mountFrame2X = 6;
mountFrameMid = 8;
mountFrame1Y = 3;
mountFrame2Y = 3;
mountFrameZ = 5;
mountFrame2Move = mountFrameZ + 1;

clampYLen = 60;
clampZLen = 1;
clampScrewXMove = 3;
clampScrewYMove = 0;

screwDia = 3.2;
screwLen = 8;
screwXMove = 3;



tempX = mountFrame1X + ((solPnlX)*solPnlCntX) + (mountFrameMid * (solPnlCntX-1)) +  mountFrame2X;
tempY = mountFrame1Y + (solPnlY)*solPnlCntY + mountFrame2Y;
tempCutX = solPnlX - solPnlClearance*2;
tempCutY = (solPnlY*solPnlCntY) + extra;

module clampPlate(xLen=10, yLen=20, zLen=1, screwXPos=0,fixture=true)
{

  cube([xLen,yLen,zLen]);
}

translate([0,tempY/2-clampYLen/2,mountFrameZ+2])
#clampPlate(xLen=mountFrame1X+solPnlClearance, yLen=clampYLen, zLen=clampZLen, screwXPos=0,fixture=true);

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



    translate([screwXMove,tempY-screwLen,mountFrameZ/2])
    rotate([-90,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);
    translate([screwXMove,-extra,mountFrameZ/2])
    rotate([-90,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);

    translate([clampScrewXMove,tempY/2-extra,-extra])
    rotate([0,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);

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

    translate([tempX-screwXMove,tempY-screwLen,mountFrameZ/2])
    rotate([-90,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);
    translate([tempX-screwXMove,-extra,mountFrameZ/2])
    rotate([-90,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);

    translate([tempX-clampScrewXMove,tempY/2-extra,-extra])
    rotate([0,0,0])
    cylinder(d=screwDia,h=screwLen+extra*2);
  }

  /* #translate([0,tempY+mountFrame2Move,0])
  rotate([90,0,0])
  union()
  {
    difference()
    {
      translate([0,0,0])
      cube([tempX,mountFrame2Y,mountFrameZ]);

      translate([screwXMove,0,mountFrameZ/2])
      rotate([-90,0,0])
      cylinder(d=screwDia,h=mountFrame2Y+extra*2);


      for (i=[1:solPnlCntX-1]) {
        tempScrewMove = mountFrame1X + i*(solPnlX + mountFrameMid) - mountFrameMid/2;
        translate([tempScrewMove,0,mountFrameZ/2-extra])
        rotate([-90,0,0])
        #cylinder(d=screwDia,h=mountFrame2Y+extra*2);
      }

      translate([tempX-screwXMove,0,mountFrameZ/2])
      rotate([-90,0,0])
      cylinder(d=screwDia,h=mountFrame2Y+extra*2);

    }
  } */
}

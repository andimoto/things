$fn=80;
extra=0.02;

// Solar Panel Vars
solFrameTh = 1; //mm
clipCutInDepth = 12; //mm
solFrameMntTh =18;

// Clip Vars
clipX = 100; //mm
/* clipY = 30;  //mm */
clipBaseY = 15;  //mm
clipTh = 16; //mm
clipRad = 3; //mm

clipPhaseTh = 5;

// Screw Vars
solPanScrewHoles = 4;
screwDia = 3.0; //mm

screwXDist = clipX / (solPanScrewHoles+1);
screwYDist = clipBaseY/2;
/* screw */

solFrameInnerXDist = 159;
mntBaseY = 80;
mntBaseTh = 5;
mntPhaseTh = 5;

mntBaseScrewX = screwYDist;
mntBaseScrewY = (mntBaseY - (screwXDist*(solPanScrewHoles-1)))/2;

socketScrewDia = 3.2;

plateMountHolesXDistance = 10;
plateMountHolesClearance = 10;
plateLenForHoles = solFrameInnerXDist - clipBaseY*2 - plateMountHolesClearance*2;
plateMountHolesRest = plateLenForHoles % plateMountHolesClearance;
plateMountHolesCnt = (plateLenForHoles-plateMountHolesRest)/plateMountHolesXDistance;
plateMntHoleYDist = 40;

// Bracket Clearance between Wall an Hole; taken 2x
bracketClearance = 5; //mm
bracketPlateThickness = 5;
holesPerBracket = 2;

rodBaseAngleCut = true;
rodBaseAngleCutExtra = 10;
rodBaseAngle = 45;
rodBaseY = 20;
rodOffset = 20;
rodDistance = 45;

rodDia = 8.3;
rodDiaMountSocket = 8;



// not used
angleBlockDia = 50;
angleBlockBaseTh = 10;


// electronics case back plate
// hole to hole distance
caseHoleXDist = 109;
caseHoleYDist = 69;
caseMountPlateClearance = 5;
caseMountPlateThickness = 5;
caseMountArmThickness = 2;
caseMountXHoleNumber = 4;
caseMountYHoleNumber = 7;
moveMountHolesY = 0;

// case mount arm
mountArmRodDia = rodDia;
mountArmRodDiaXBlock = 20;
mountArmLen = 40;
mountArmZ = rodDistance;
mountArmPlateThickness = 5;
mountArmTravesThickness = 5;
mountArmClearance = 5;
mountArmRotatorDia = 20;
mountArmXHoles = caseMountXHoleNumber;
mountArmYHoles = 4;

saveHole = true;
saveHoleDia = 25;

shaftMountSocketH = 50;
shaftMountWallThickness = 8;

tmpShaftY = plateMountHolesXDistance*mountArmXHoles;
tmpShaftZ = mountArmZ + rodDia + mountArmClearance*2;
tmpSocketRadius = (tmpShaftY/2) / cos(30);
tmpSocketRadiusCutout = (tmpShaftY/2 - shaftMountWallThickness) / cos(30);

shaftMountRad = (tmpShaftY/2 - shaftMountWallThickness);
shaftBlockH = 60;
/* translate([15,0,-clipTh])
rotate([0,0,90])
frameClip();

translate([solFrameInnerXDist-clipBaseY,clipX,-clipTh])
rotate([0,0,-90])
frameClip();

translate([-55,clipX,-clipTh])
rotate([0,0,-90])
frameClip(); */



/* translate([0,(clipX-mntBaseY)/2,0])
solPanMount(); */


/* translate([-40,(clipX-mntBaseY)/2,0])
mirror([1,0,0])
solPanMount(); */


/* bracketMount(); */
/* translate([mountArmRodDiaXBlock/2,tmpShaftY/2,-(shaftMountSocketH)-extra]) */
shaftMountRotator();
module shaftMountRotator()
{
  tmpRad = (tmpShaftY/2 - shaftMountWallThickness);
  tmpLen = tmpSocketRadiusCutout - tmpRad;
  tmpZ = shaftMountSocketH-shaftMountWallThickness;
  difference()
  {
    union()
    {
      cylinder(r=tmpRad, h=tmpZ);
      translate([-tmpRad*3/2,-tmpRad+tmpLen,-(shaftBlockH)])
      cube([tmpRad*3,tmpRad*2-tmpLen,shaftBlockH+extra*2]);
    }
    translate([-tmpRad,-tmpRad,-extra])
    cube([tmpRad*2,tmpLen,tmpZ+extra*2]);

    translate([0,-tmpRad+extra,-shaftBlockH/5])
      rotate([-90,0,0])
      cylinder(d=rodDia, h=tmpRad*2+extra*2);

    translate([0,-tmpRad+extra,-shaftBlockH+shaftBlockH/5*2.5])
      rotate([-90,0,0])
      cylinder(d=rodDia, h=tmpRad*2+extra*2);

    translate([0,-tmpRad+extra,-shaftBlockH+shaftBlockH/5])
      rotate([-90,0,0])
      cylinder(d=rodDia, h=tmpRad*2+extra*2);
  }

}


/* shaftMount(); */
module shaftMount()
{


  difference()
  {
    cube([mountArmRodDiaXBlock,tmpShaftY,tmpShaftZ]);

    moveRodX = mountArmRodDiaXBlock/2;
    translate([moveRodX,-extra, rodDia/2+mountArmClearance])
    union()
    {
      translate([-extra,0, 0])
        rotate([-90,0,0])
        cylinder(d=rodDia, h=tmpShaftY+extra*2);

      translate([-extra,0,rodDistance])
        rotate([-90,0,0])
        cylinder(d=rodDia, h=tmpShaftY+extra*2);
    }
  }


  difference()
  {
    translate([mountArmRodDiaXBlock/2,tmpShaftY/2,-shaftMountSocketH])
    cylinder(r=tmpSocketRadius, h=shaftMountSocketH, $fn=6);


    translate([mountArmRodDiaXBlock/2,tmpShaftY/2,-shaftMountSocketH/2])
    rotate([0,0,60])
    translate([0,-(tmpShaftY+extra*2)/2,0])
    rotate([-90,0,0])
      cylinder(d=rodDia, h=tmpShaftY+extra*2);

    translate([mountArmRodDiaXBlock/2,tmpShaftY/2,-shaftMountSocketH-extra])
      cylinder(r=tmpSocketRadiusCutout, h=shaftMountSocketH-shaftMountWallThickness, $fn=6);
  }
}


/* mountArm(); */
module mountArm()
{
  tmpZ = mountArmZ+mountArmClearance;
  tmpY = plateMountHolesXDistance*mountArmXHoles+mountArmClearance*2;
  union()
  {
    difference()
    {
      tmpX = mountArmPlateThickness;


      cube([mountArmPlateThickness,tmpY,tmpZ]);

      translate([0,mountArmClearance+mountArmTravesThickness,
        tmpZ/2-(plateMountHolesXDistance*(mountArmYHoles-1))/2])
      rotate([90,0,90])
      for(iy=[0:mountArmYHoles-1])
      {
        for(ix=[0:mountArmXHoles-1])
        {
          translate([plateMountHolesXDistance*ix,plateMountHolesXDistance*iy,-extra])
            rotate([0,0,0])
            cylinder(d=screwDia, h=mountArmPlateThickness+extra*2);
        }
      }
    }
  }


  union()
  {
    difference()
    {
      tmpZ2 = mountArmZ + rodDia + mountArmClearance*2;
      union()
      {
        hull()
        {
          translate([mountArmPlateThickness,0,0])
          cube([extra,mountArmTravesThickness,tmpZ]);
          translate([mountArmPlateThickness+mountArmLen,0,0])
          cube([extra,mountArmTravesThickness,tmpZ2]);
        }
        translate([mountArmPlateThickness+mountArmLen,0,0])
          cube([mountArmRodDiaXBlock,mountArmTravesThickness,tmpZ2]);

        translate([0,tmpY-mountArmTravesThickness,0])
        hull()
        {
          translate([mountArmPlateThickness,0,0])
          cube([extra,mountArmTravesThickness,tmpZ]);
          translate([mountArmPlateThickness+mountArmLen,0,0])
          cube([extra,mountArmTravesThickness,tmpZ2]);
        }
        translate([mountArmPlateThickness+mountArmLen,tmpY-mountArmTravesThickness,0])
          cube([mountArmRodDiaXBlock,mountArmTravesThickness,tmpZ2]);
      }

      moveRodX = mountArmPlateThickness+mountArmLen+mountArmRodDiaXBlock/2;
      translate([moveRodX,-extra, rodDia/2+mountArmClearance])
      union()
      {
        translate([-extra,0, 0])
          rotate([-90,0,0])
          cylinder(d=rodDia, h=tmpY+extra*2);

        translate([-extra,0,rodDistance])
          rotate([-90,0,0])
          cylinder(d=rodDia, h=tmpY+extra*2);
      }

      if(saveHole == true)
      {
        moveHoleX = mountArmPlateThickness+mountArmLen/2;
        translate([moveHoleX,-extra,tmpZ/2])
        rotate([-90,0,0])
        cylinder(d=saveHoleDia, h=tmpY+extra*2);
      }
    }
  }
}


tmpArmX = caseHoleXDist+caseMountPlateClearance*2 - caseMountPlateClearance*2;

/* caseMountPlate(); */
module caseMountPlate()
{
  tmpPlateX = caseMountXHoleNumber*plateMountHolesXDistance+caseMountPlateClearance*2;
  tmpPlateY = caseHoleYDist+caseMountPlateClearance*2;
  difference()
  {
    union()
    {
      cube([tmpPlateX,tmpPlateY,caseMountPlateThickness]);

      translate([-(tmpArmX-tmpPlateX)/2,0,0])
      sideArm();
      translate([-(tmpArmX-tmpPlateX)/2,tmpPlateY-caseMountPlateClearance*2,0])
      sideArm();
    }
    translate([(tmpPlateX/2-caseMountXHoleNumber)/2,caseMountPlateClearance*2+moveMountHolesY,0])
    for(iy=[0:caseMountYHoleNumber-1])
    {
      for(ix=[0:caseMountXHoleNumber-1])
      {
        translate([plateMountHolesXDistance*ix,plateMountHolesXDistance*iy,-extra])
          rotate([0,0,0])
          cylinder(d=screwDia, h=caseMountPlateThickness+extra*2);
      }
    }

  }
}

module sideArm()
{
  difference()
  {
    union()
    {
      cube([tmpArmX,caseMountPlateClearance*2,caseMountArmThickness]);
      translate([0,caseMountPlateClearance,0])
      cylinder(d=caseMountPlateClearance*2, h=caseMountArmThickness);
      translate([tmpArmX,caseMountPlateClearance,0])
      cylinder(d=caseMountPlateClearance*2, h=caseMountArmThickness);
    }
    translate([tmpArmX,caseMountPlateClearance,-extra])
    cylinder(d=screwDia,h=caseMountArmThickness+extra*2);
    translate([0,caseMountPlateClearance,-extra])
    cylinder(d=screwDia,h=caseMountArmThickness+extra*2);
  }
}

module bracketMount()
{
  bracketMountAngled();
  difference()
  {
    cube([plateMountHolesXDistance*holesPerBracket,
    bracketPlateThickness,plateMntHoleYDist+bracketClearance*2]);


    for(ix=[0:holesPerBracket])
    {
      translate([bracketClearance+plateMountHolesXDistance*ix,-extra,bracketClearance])
        rotate([-90,0,0])
        cylinder(d=screwDia, h=bracketPlateThickness+extra*2);

      translate([bracketClearance+plateMountHolesXDistance*ix,-extra,bracketClearance+plateMntHoleYDist])
        rotate([-90,0,0])
        cylinder(d=screwDia, h=bracketPlateThickness+extra*2);
    }
  }
}



/* bracketMountAngled(); */
module bracketMountAngled()
{
  angledLen = tan(rodBaseAngle)*(bracketClearance*2+plateMntHoleYDist);

  difference()
  {
    hull()
    {
      translate([0,bracketPlateThickness,0])
      cube([bracketPlateThickness,angledLen+rodBaseY+rodOffset,extra]);

      translate([0,bracketPlateThickness,bracketClearance*2+plateMntHoleYDist-extra])
      cube([bracketPlateThickness,rodBaseY+rodOffset,extra]);
    }

    if((rodBaseAngleCut == true))
    {
      if((rodBaseAngle > 30) )
      {
        translate([-extra,angledLen+rodBaseY+rodOffset-bracketPlateThickness-rodBaseAngleCutExtra,-extra])
        cube([bracketPlateThickness+extra*2,
          bracketClearance*2+bracketPlateThickness+rodBaseAngleCutExtra,
          plateMntHoleYDist+bracketClearance*2]);
      }
    }

    tmpZ = plateMntHoleYDist+bracketClearance*2-bracketClearance-rodDia/2;
    tmpY = bracketPlateThickness+bracketClearance+rodDia/2;
    translate([0,tmpY+rodOffset, tmpZ])
    rotate([rodBaseAngle,0,0])
    union()
    {
      translate([-extra,0, 0])
        rotate([0,90,0])
        cylinder(d=rodDia, h=bracketPlateThickness+extra*2);

      translate([-extra,0,-rodDistance])
        rotate([0,90,0])
        cylinder(d=rodDia, h=bracketPlateThickness+extra*2);
    }

    translate([-extra,bracketPlateThickness+bracketClearance,(bracketClearance*2+plateMntHoleYDist)/2])
    rotate([0,90,0])
    cylinder(d=screwDia, h=bracketPlateThickness+extra*2);
  }

}


/* angleBlock(); */

module angleBlock()
{
  difference()
  {
    cylinder(d=angleBlockDia, h=angleBlockBaseTh);
    union()
    {
      for(a=[0:30:360])
      {
        rotate([0,0,a])
        translate([0,angleBlockDia/2-6,-extra])
        screw(screwD = 3.2, screwLen=10, screwHeadD = 6, screwHeadThickness = 3);
      }
    }
  }
}

module screw(screwD = 3, screwLen=10, screwHeadD = 6, screwHeadThickness = 3)
{
  union()
  {
    /* head */
    cylinder(r=screwHeadD/2, h=screwHeadThickness);
    /* screw */
    translate([0,0,screwHeadThickness])
    cylinder(r = screwD/2, h=screwLen);
  }
}


module solPanMount()
{
  echo("Base Plate Mount Hole Distance: x", plateMountHolesXDistance, " y ", plateMntHoleYDist);
  difference()
  {
    union()
    {
      solPanMountBase();
      echo(plateMountHolesCnt);
    }

    translate([mntBaseScrewX,mntBaseScrewY,-extra])
    rotate([0,0,90])
    clipScrewHoles(dia=screwDia+0.2, holeCnt=solPanScrewHoles);

    translate([solFrameInnerXDist-mntBaseScrewX,mntBaseScrewY,-extra])
    rotate([0,0,90])
    clipScrewHoles(dia=screwDia+0.2, holeCnt=solPanScrewHoles);

    translate([clipBaseY+plateMountHolesClearance+plateMountHolesRest/2,mntBaseY/2-plateMntHoleYDist/2,0])
    for(iy=[0:1])
    {
      for(ix=[0:plateMountHolesCnt])
      {
        translate([plateMountHolesXDistance*ix,plateMntHoleYDist*iy,-extra])
        cylinder(d=socketScrewDia, h=mntBaseTh+extra*2);
      }
    }
  }
}



module solPanMountBase()
{
  union()
  {
    hull()
    {
      translate([0,mntPhaseTh,0])
      cube([extra, mntBaseY-mntPhaseTh*2, mntBaseTh]);
      translate([mntPhaseTh,0,0])
      cube([extra, mntBaseY, mntBaseTh]);
    }
    translate([mntPhaseTh,0,0])
    cube([solFrameInnerXDist-mntPhaseTh*2, mntBaseY, mntBaseTh]);
    hull()
    {
      translate([solFrameInnerXDist-mntPhaseTh,0,0])
      cube([extra, mntBaseY, mntBaseTh]);
      translate([solFrameInnerXDist,mntPhaseTh,0])
      cube([extra, mntBaseY-mntPhaseTh*2, mntBaseTh]);
    }
  }
}



module frameClip()
{
  difference()
  {
    frameClipBase();

    translate([-extra,clipBaseY,clipTh/2-solFrameTh/2])
    cube([clipX+extra*2, clipCutInDepth+extra*2,solFrameTh]);

    translate([screwXDist,screwYDist,-extra])
    clipScrewHoles(dia=screwDia, holeCnt=solPanScrewHoles);

    translate([screwXDist,clipBaseY,-extra])
    clipScrewHoles(dia=screwDia, holeCnt=solPanScrewHoles);

    translate([screwXDist,clipBaseY+clipCutInDepth/2,-extra])
    clipScrewHoles(dia=screwDia, holeCnt=solPanScrewHoles);
  }
}

module frameClipBase()
{
  union()
  {
    hull()
    {
      translate([clipPhaseTh,0,0])
      cube([clipX-clipPhaseTh*2,extra,clipTh]);
      translate([0,clipPhaseTh,0])
      cube([clipX,extra,clipTh]);
    }

    translate([0,clipPhaseTh,0])
    cube([clipX,clipBaseY-clipPhaseTh,clipTh]);
    translate([0,clipBaseY,0])
    cube([clipX,clipCutInDepth-clipPhaseTh,clipTh]);


    hull()
    {
      translate([0,clipBaseY+clipCutInDepth-clipPhaseTh,0])
      cube([clipX,extra,clipTh]);
      translate([clipPhaseTh,clipBaseY+clipCutInDepth,0])
      cube([clipX-clipPhaseTh*2,extra,clipTh]);
    }
  }
}





module clipScrewHoles(dia=3, holeCnt=2)
{
  for (i=[0:holeCnt-1])
  {
    translate([screwXDist*i,0,0])
    cylinder(r=dia/2, h=clipTh+extra*2);
  }
}

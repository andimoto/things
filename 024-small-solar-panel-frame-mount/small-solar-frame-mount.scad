$fn=100;
extra=0.02;

// Solar Panel Vars
solFrameTh = 1; //mm
clipCutInDepth = 12; //mm

// Clip Vars
clipX = 100; //mm
/* clipY = 30;  //mm */
clipBaseY = 15;  //mm
clipTh = 16; //mm
clipRad = 3; //mm

clipPhaseTh = 5;

// Screw Vars
solPanScrewHoles = 4;
screwDia = 3.2; //mm

screwXDist = clipX / (solPanScrewHoles+1);
screwYDist = clipBaseY/2;
/* screw */

solFrameInnerXDist = 159;
mntBaseY = 80;
mntBaseTh = 5;
mntPhaseTh = 5;

mntBaseScrewX = screwYDist;
mntBaseScrewY = (mntBaseY - (screwXDist*(solPanScrewHoles-1)))/2;


mntSocketX = 50;
mntSocketY = 50;
mntSocketH = 10;
moveSocketX = 0;
moveSocketY = 0;
mntSockWall = 10;

socketScrewDist = 40;

socketScrewDia = 3.2;

tmpX = solFrameInnerXDist/2-mntSocketX/2;
tmpY = mntBaseY/2-mntSocketY/2;



translate([15,0,-clipTh])
rotate([0,0,90])
frameClip();

translate([solFrameInnerXDist-clipBaseY,clipX,-clipTh])
rotate([0,0,-90])
frameClip();

translate([0,(clipX-mntBaseY)/2,0])
solPanMount();
module solPanMount()
{
  difference()
  {
    union()
    {
      solPanMountBase();
      echo("====SocketPosX:", tmpX+moveSocketX, "====");
      echo("====SocketPosY:", tmpY+moveSocketY, "====");
      translate([tmpX+moveSocketX,tmpY+moveSocketY,mntBaseTh-extra])
      difference()
      {
        cube([mntSocketX,mntSocketY,mntSocketH]);

        translate([mntSockWall/2,mntSockWall/2,0])
        for(iy=[0:1])
        {
          for(ix=[0:1])
          {
            translate([socketScrewDist*ix,socketScrewDist*iy,0])
            cylinder(d=socketScrewDia, h=mntSocketH+extra);
          }
        }

      }
    }

    translate([tmpX+moveSocketX,tmpY+moveSocketY,-extra])
    translate([mntSockWall,mntSockWall,0])
    cube([mntSocketX-mntSockWall*2,mntSocketY-mntSockWall*2,mntBaseTh+mntSocketH+extra*2]);

    translate([mntBaseScrewX,mntBaseScrewY,-extra])
    rotate([0,0,90])
    clipScrewHoles(dia=screwDia+0.2, holeCnt=solPanScrewHoles);

    translate([solFrameInnerXDist-mntBaseScrewX,mntBaseScrewY,-extra])
    rotate([0,0,90])
    clipScrewHoles(dia=screwDia+0.2, holeCnt=solPanScrewHoles);
  }
}

module mntSocket()
{


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
  /* translate([screwXDist,0,0]) */
  for (i=[0:holeCnt-1])
  {
    translate([screwXDist*i,0,0])
    cylinder(r=dia/2, h=clipTh+extra*2);
  }

}

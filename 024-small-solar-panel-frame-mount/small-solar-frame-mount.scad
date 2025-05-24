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
mntBaseTh = 5;
mntPhaseTh = 5;

mntBaseScrewX = screwYDist;

translate([15,0,-clipTh])
rotate([0,0,90])
frameClip();

translate([solFrameInnerXDist-clipBaseY,clipX,-clipTh])
rotate([0,0,-90])
frameClip();

solPanMount();
module solPanMount()
{
  difference()
  {
    solPanMountBase();

    translate([mntBaseScrewX,0,-extra])
    rotate([0,0,90])
    clipScrewHoles(dia=screwDia+0.2);

    translate([solFrameInnerXDist-mntBaseScrewX,0,-extra])
    rotate([0,0,90])
    clipScrewHoles(dia=screwDia+0.2);
  }
}


module solPanMountBase()
{
  union()
  {
    hull()
    {
      translate([0,mntPhaseTh,0])
      cube([extra, clipX-mntPhaseTh*2, mntBaseTh]);
      translate([mntPhaseTh,0,0])
      cube([extra, clipX, mntBaseTh]);
    }
    translate([mntPhaseTh,0,0])
    cube([solFrameInnerXDist-mntPhaseTh*2, clipX, mntBaseTh]);
    hull()
    {
      translate([solFrameInnerXDist-mntPhaseTh,0,0])
      cube([extra, clipX, mntBaseTh]);
      translate([solFrameInnerXDist,mntPhaseTh,0])
      cube([extra, clipX-mntPhaseTh*2, mntBaseTh]);
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

    translate([0,screwYDist,-extra])
    clipScrewHoles(dia=screwDia);

    translate([0,clipBaseY,-extra])
    clipScrewHoles(dia=screwDia);

    translate([0,clipBaseY+clipCutInDepth/2,-extra])
    clipScrewHoles(dia=screwDia);
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


module clipScrewHoles(dia=3)
{
  translate([screwXDist,0,0])
  for (i=[0:solPanScrewHoles-1])
  {
    translate([screwXDist*i,0,0])
    cylinder(r=dia/2, h=clipTh+extra*2);
  }

}

$fn=100;
extra=0.02;

file = "supFin-LargeForMini.stl";


usFinLen = 120;
usFinThick = 8.6;
usFinHeight = 24;

finCutOutLen = 20;
finCutoutheight = 10;

finChampfer = 5;


axisLen = 140;
axisHeight = 100;
axisThick = 40;
axisChampfer = 10;

axisCutoutWall = 15;
axisVerticalCutoutH = 20;
axisVerticalCutoutH2 = 10;


screwHoleDia = 5;
blockScrewDia = 4.2;
blockScrewHeadDia = 8;
blockScrewHeadLen = 4;

blockHoleXZMove = 7.6;


axisDia = 8.6;
axisScrewHeight = 83;




/* translate([0,-10,0])
usFinBase(); */

module usFinBase()
{
  difference()
  {
    union()
    {
      translate([-43.2802,0,0])
      rotate([0,0,-45])
      import(file,convexity=3);
    }
    translate([0,-5,24])
    cube([170,10,190]);
  }
}


/* usBoxSmallFinRail(); */
module usBoxSmallFinRail()
{
  translate([0,0,0])
  difference()
  {
    hull()
    {
      translate([0,0,finChampfer])
      cube([usFinLen,usFinThick,usFinHeight-finChampfer]);
      translate([finChampfer,0,0])
      cube([usFinLen - finChampfer*2,usFinThick,extra]);
    }

    tempXMove = usFinLen/2 - (finCutOutLen+finChampfer*2)/2;
    translate([tempXMove,-extra,0])
    hull()
    {
      translate([finChampfer,0,finCutoutheight + extra])
      cube([finCutOutLen,usFinThick+extra*2,extra]);
      translate([-finChampfer,0,usFinHeight + extra])
      cube([finCutOutLen + finChampfer*4,usFinThick+extra*2,extra]);
    }

    union()
    {
      translate([blockHoleXZMove,-extra,7.6])
      rotate([-90,0,0])
      cylinder(r=blockScrewDia/2, h=usFinThick+extra*2);

      translate([blockHoleXZMove,-extra,7.6])
      rotate([-90,0,0])
      cylinder(r=blockScrewHeadDia/2, h=blockScrewHeadLen+extra);
    }

    union()
    {
      translate([usFinLen-blockHoleXZMove,-extra,blockHoleXZMove])
      rotate([-90,0,0])
      cylinder(r=blockScrewDia/2, h=usFinThick+extra*2);

      translate([usFinLen-blockHoleXZMove,-extra,blockHoleXZMove])
      rotate([-90,0,0])
      cylinder(r=blockScrewHeadDia/2, h=blockScrewHeadLen+extra);
    }

    translate([usFinLen/2,usFinThick/2,-extra])
    cylinder(r=screwHoleDia/2, h=usFinHeight);
  }
}



wagon();
module wagon()
{
  difference()
  {
    union()
    {
      usBoxSmallFinRail();

      hull()
      {
        translate([0,0,usFinHeight])
        cube([usFinLen,usFinThick,extra]);

        union()
        {

          translate([0,usFinThick/2-axisLen/2,axisHeight-axisThick+extra])
          cube([axisThick,axisLen,axisThick-axisChampfer]);
        }
      }
      hull()
      {
        translate([axisChampfer,usFinThick/2-axisLen/2,axisHeight])
        cube([axisThick/2,axisLen,extra]);
        translate([0,usFinThick/2-axisLen/2,axisHeight-axisChampfer])
        cube([axisThick,axisLen,extra]);
      }
    }


    translate([-extra,0,0])
    union()
    {
      hull()
      {
        hull()
        {
          tempYMove= -(axisLen-axisCutoutWall*2)/2 + usFinThick/2;
          translate([0,tempYMove,axisHeight-axisChampfer*1.5-axisVerticalCutoutH])
          cube([extra,axisLen-axisCutoutWall*2,axisVerticalCutoutH]);
          translate([usFinLen,tempYMove+axisCutoutWall*2,axisHeight-axisChampfer*1.5-axisVerticalCutoutH2])
          cube([extra,axisLen-axisCutoutWall*2-axisCutoutWall*4,axisVerticalCutoutH2]);
        }

        translate([0,0,usFinHeight+axisCutoutWall])
        cube([usFinLen+extra*2,usFinThick,extra]);
      }
    }


    tempXMove = usFinLen/2 - (finCutOutLen+finChampfer*2)/2;
    translate([0,0,10+usFinHeight*2])
    mirror([0,0,1])
    translate([tempXMove,-extra,0])
    hull()
    {
      translate([finChampfer*2,-usFinThick/2,finCutoutheight + extra])
      cube([finCutOutLen+finChampfer*4,usFinThick*2+extra*2,extra]);
      translate([-finChampfer,-usFinThick/2,10+usFinHeight + extra])
      cube([finCutOutLen + finChampfer*4,usFinThick*2+extra*2,extra]);
    }

    translate([axisThick/2,usFinThick/2-axisLen/2-extra,axisScrewHeight])
    rotate([-90,0,0])
    cylinder(r=axisDia/2, h=axisLen+extra*2);
  }

}

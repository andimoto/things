$fn=100;
extra=0.02;

/* [ Fin Mount Selection ] */
// select 'true' for US Box Fin Style Mount, 'false' for Slide In Fin Style Mount
usFinSelection = false;

/* [ Dimensions for US Box Fin Mount ] */
// length of mount inside US Fin Box
usFinLen = 160;
usFinThick = 8.6;
usFinHeight = 24;

finCutOutLen = 20;
finCutoutheight = 10;

finChampfer = 5;

/* [ Dimensions for Slide-In Fin Mount ] */
slideFinLen = 160;
slideFinThick1 = 15.8;
slideFinThick2 = 19.6;
slideFinHeight = 24;
slideFinBaseThick1 = 30.5;
slideFinBaseThick2 = 34.5;
slideFinBaseHeight = 4;
slideFinFixerLen = 15;
slideFinFixerHeight = 6;



/*Dimensions of Trolley part*/
// length of the wheel axis
axisLen = 160;
axisHeight = 115;
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


axisDia = 9.5;
axisScrewHeight = 15;

axisTunnelDia = 12;

M4ScrewDia = 4;  // optional: for stability
moveYStabScrew = 50;
stabScrewCoutoutLen = 40;


function getFinLen() = (usFinSelection==true) ? usFinLen : slideFinLen;
function getFinThick1() = (usFinSelection==true) ? usFinThick : slideFinThick1;
function getFinThick2() = (usFinSelection==true) ? usFinThick : slideFinThick2;
function getFinHeight() = (usFinSelection==true) ? usFinHeight : slideFinHeight;



/* usBoxSmallFinRail(); */
module usBoxSmallFinRail()
{
  translate([0,0,0])
  difference()
  {
    hull()
    {
      translate([0,0,finChampfer])
      cube([getFinLen(),getFinThick1(),getFinHeight()-finChampfer]);
      translate([finChampfer,0,0])
      cube([getFinLen() - finChampfer*2,getFinThick1(),extra]);
    }

    tempXMove = getFinLen()/2 - (finCutOutLen+finChampfer*2)/2;
    translate([tempXMove,-extra,0])
    hull()
    {
      translate([finChampfer,0,getFinHeight() - finCutoutheight + extra])
      cube([finCutOutLen,getFinThick1()+extra*2,extra]);
      translate([-finChampfer,0,-extra])
      cube([finCutOutLen + finChampfer*4,getFinThick1()+extra*2,extra]);
    }

    union()
    {
      translate([blockHoleXZMove,-extra,7.6])
      rotate([-90,0,0])
      cylinder(r=blockScrewDia/2, h=getFinThick1()+extra*2);

      translate([blockHoleXZMove,-extra,7.6])
      rotate([-90,0,0])
      cylinder(r=blockScrewHeadDia/2, h=blockScrewHeadLen+extra);
    }

    union()
    {
      translate([getFinLen()-blockHoleXZMove,-extra,blockHoleXZMove])
      rotate([-90,0,0])
      cylinder(r=blockScrewDia/2, h=getFinThick1()+extra*2);

      translate([getFinLen()-blockHoleXZMove,-extra,blockHoleXZMove])
      rotate([-90,0,0])
      cylinder(r=blockScrewHeadDia/2, h=blockScrewHeadLen+extra);
    }

    translate([getFinLen()/2,getFinThick1()/2,-extra])
    cylinder(r=screwHoleDia/2, h=getFinHeight()+extra*2);
  }
}



/* slideInFinRail(); */
module slideInFinRail()
{
  translate([0,slideFinThick1/2,0])
  difference()
  {
    union()
    {
      hull()
      {
        translate([slideFinThick1/3,-slideFinThick1/2,0])
        cube([extra,slideFinThick1, slideFinHeight]);
        translate([slideFinLen-extra,-slideFinThick2/2,0])
        cube([extra,slideFinThick2, slideFinHeight]);
      }

      translate([slideFinThick1/3,0,0])
      cylinder(r=slideFinThick1/2, h=slideFinHeight );


      hull()
      {
        translate([0,-slideFinBaseThick1/2,0])
        cube([extra,slideFinBaseThick1, slideFinBaseHeight]);
        translate([slideFinLen-extra,-slideFinBaseThick2/2,0])
        cube([extra,slideFinBaseThick2, slideFinBaseHeight]);
      }
    }
    translate([-slideFinThick1,-slideFinThick1/2,-extra])
    cube([slideFinThick1,slideFinThick1,slideFinHeight+extra*2]);

    translate([30+slideFinThick1/3,-slideFinThick2/2,5.5])
    cube([slideFinFixerLen,slideFinThick2,slideFinFixerHeight]);

  }
}



wagon();
module wagon()
{
  difference()
  {
    union()
    {
      if(usFinSelection == true)
      {
        usBoxSmallFinRail();
      }
      if(usFinSelection == false)
      {
        slideInFinRail();
      }

      hull()
      {
        translate([0,getFinThick1()/2,0])
        hull()
        {
          translate([0,-getFinThick1()/2,getFinHeight()])
          cube([extra,getFinThick1(),extra]);
          translate([getFinLen(),-getFinThick2()/2,getFinHeight()])
          cube([extra,getFinThick2(),extra]);
        }

        union()
        {

          translate([0,getFinThick1()/2-axisLen/2,axisHeight-axisThick+extra])
          cube([axisThick,axisLen,axisThick-axisChampfer]);
        }
      }
      hull()
      {
        translate([axisChampfer,getFinThick1()/2-axisLen/2,axisHeight])
        cube([axisThick/2,axisLen,extra]);
        translate([0,getFinThick1()/2-axisLen/2,axisHeight-axisChampfer])
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
          tempYMove= -(axisLen-axisCutoutWall*2)/2 + getFinThick1()/2;
          translate([0,tempYMove,axisHeight-axisChampfer*1.5-axisVerticalCutoutH])
          cube([extra,axisLen-axisCutoutWall*2,axisVerticalCutoutH]);
          translate([getFinLen(),tempYMove+axisCutoutWall*2,axisHeight-axisChampfer*1.5-axisVerticalCutoutH2])
          cube([extra,axisLen-axisCutoutWall*2-axisCutoutWall*4,axisVerticalCutoutH2]);
        }

        translate([0,0,getFinHeight()+axisCutoutWall])
        cube([getFinLen()+extra*2,getFinThick1(),extra]);
      }
    }


    tempXMove = getFinLen()/2 - (finCutOutLen+finChampfer*2)/2;

    if(usFinSelection == true)
    {
      translate([0,0,10+getFinHeight()*2])
      mirror([0,0,1])
      translate([tempXMove,-extra,0])
      hull()
      {
        translate([-finChampfer*4-2,-getFinThick1()/2-getFinThick1(),finCutoutheight+extra])
        cube([finCutOutLen+finChampfer*10,getFinThick1()*4+extra*2,extra]);
        translate([0,-getFinThick1()-getFinThick1()/2,10+getFinHeight() + extra])
        cube([finCutOutLen + finChampfer*2,getFinThick1()*4+extra*2,extra]);
      }
    }

    translate([axisThick/2,getFinThick1()/2-axisLen/2-extra,axisHeight-axisScrewHeight])
    rotate([-90,0,0])
    cylinder(r=axisDia/2, h=axisLen+extra*2, $fn=6);


    translate([axisThick/2,moveYStabScrew+getFinThick1()/2,getFinHeight()])
    cylinder(r=M4ScrewDia/2, h=stabScrewCoutoutLen);
    translate([axisThick/2,-moveYStabScrew+getFinThick1()/2,getFinHeight()])
    cylinder(r=M4ScrewDia/2, h=stabScrewCoutoutLen);
  }


  difference()
  {
    translate([axisThick/2,getFinThick1()/2-axisLen/2,axisHeight-axisScrewHeight])
    rotate([-90,0,0])
    cylinder(r=axisTunnelDia/2, h=axisLen, $fn=6);

    translate([axisThick/2,getFinThick1()/2-axisLen/2-extra,axisHeight-axisScrewHeight])
    rotate([-90,0,0])
    cylinder(r=axisDia/2, h=axisLen+extra*2, $fn=6);

  }

}

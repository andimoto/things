/* rollerBlindBlend.scad
Author: andimoto@posteo.de
----------------------------
*/

$fn=80;
extra = 0.1;

vWidthFront=50;
vHeightFront=194;

vWidthBack=56.5;
vHeightBack=201;



vDepth=8.3;

radiusFront=1;
radiusBack=4.5;

diffInnerOuter = 1.5;

module bar(widthFront=50,heightFront=200,widthBack=55,heightBack=210,thickness=5, radFront=1,radBack=4)
{
  diffHeight=heightBack-heightFront-radiusBack-radiusFront;
  diffWidth=widthBack-widthFront-radiusBack-radiusFront;

  hull()
  {
    translate([radBack,radBack,thickness])
    minkowski()
    {
      cube([widthFront-radFront*2,heightFront-radFront*2,extra/5]);
      cylinder(r=radFront,h=extra/5);
    }

    translate([radBack,radBack,0])
    minkowski()
    {
      cube([widthBack-radBack*2,heightBack-radBack*2,extra/5]);
      cylinder(r=radBack,h=extra/5);
    }
  }

}

cutoutX=38;
cutoutY=18;

cutoutMoveY=32;

rad1ScrewHole1=6 /*mm*//2;
rad2ScrewHole1=10 /*mm*//2;
rad1ScrewHole2=6 /*mm*//2;
rad2ScrewHole2=10 /*mm*//2;

posHole1Y=200;
posHole2Y=cutoutMoveY-17.5;

module cutout()
{
  cube([cutoutX,cutoutY,diffInnerOuter*2+extra]);
}

module blend()
{
  difference() {

    bar(vWidthFront,vHeightFront,vWidthBack,vHeightBack,vDepth,radiusFront,radiusBack);
    translate([diffInnerOuter,diffInnerOuter,-diffInnerOuter])
      bar(vWidthFront-diffInnerOuter*2,vHeightFront-diffInnerOuter*2,vWidthBack-diffInnerOuter*2,vHeightBack-diffInnerOuter*2,
          vDepth-diffInnerOuter,radiusFront,radiusBack);

    moveXtemp = vWidthFront - cutoutX;
    translate([radiusBack-radiusFront+moveXtemp/2,radiusBack-radiusFront+cutoutMoveY,vDepth-diffInnerOuter*2])
      cutout();

    translate([radiusBack-radiusFront+vWidthFront/2,radiusBack-radiusFront+vHeightFront-posHole2Y,vDepth-diffInnerOuter*2])
      cylinder(r1=rad1ScrewHole2,r2=rad2ScrewHole2,h=diffInnerOuter*2+extra);
    translate([radiusBack-radiusFront+vWidthFront/2,radiusBack-radiusFront+posHole2Y,vDepth-diffInnerOuter*2])
      cylinder(r1=rad1ScrewHole2,r2=rad2ScrewHole2,h=diffInnerOuter*2+extra);
  }
}


blend();

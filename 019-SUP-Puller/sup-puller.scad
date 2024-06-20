$fn=100;
extra=0.02;


supDia = 155;
clampWallThickness = 18;
clampH = 110;

champfer = 2; //mm

rodDia = 9.5;
rodTubeLen = 100;
rodTubeWall = 8;

strapWidth = 50;
strapTh = 5;

extensionX1 = 30;
extensionX2 = 10;

saveFilament = true;

sup_puller();
module sup_puller()
{
  difference()
  {
    corpus();
    /* cylinder(r=(supDia/2+clampWallThickness), h=clampH); */
    translate([0,0,-extra])
    {
      translate([0,0,-extra])
        cylinder(r2=(supDia/2), r1=(supDia/2)+champfer, h=champfer);
      translate([0,0,champfer-extra*2])
        cylinder(r=(supDia/2), h=clampH-champfer);
      translate([0,0,clampH-champfer+extra*2])
        cylinder(r1=(supDia/2), r2=(supDia/2)+champfer, h=champfer);

      translate([-supDia/2-clampWallThickness-extra*2,
        -supDia/2-clampWallThickness-extra,
        0])
        cube([supDia/2+clampWallThickness+extra*2,supDia+clampWallThickness*2+extra*2,clampH+extra*2]);
    }
    union() {
      tempZmove = clampH/2 - strapWidth/2;
      translate([0,0,tempZmove])
      strapCutout();
    }

    cutoutX = 10;
    tempCutoutLen = clampWallThickness*2+supDia;
    tempZmove = clampH/2 - strapWidth/2;
    translate([0,-supDia/2-clampWallThickness,tempZmove])
    cube([cutoutX,tempCutoutLen,clampH/2]);
    translate([20,-supDia/2-clampWallThickness,tempZmove])
    cube([cutoutX,tempCutoutLen,clampH/2]);
    translate([40,-supDia/2-clampWallThickness,tempZmove])
    cube([cutoutX,tempCutoutLen,clampH/2]);
    /* translate([60,-supDia/2-clampWallThickness,tempZmove])
    cube([cutoutX,tempCutoutLen,clampH/2]); */
    /* translate([40,-supDia/2-clampWallThickness,tempZmove])
    cube([cutoutX,tempCutoutLen,clampH/2]); */

  }

  translate([-extensionX1,-(supDia/2+clampWallThickness),0])
  extension(lenX=extensionX1, wallTh=clampWallThickness, zHeight=clampH, chmpf=champfer);

  translate([-extensionX2,(supDia/2+clampWallThickness),0])
  mirror([0,1,0])
  extension(lenX=extensionX2, wallTh=clampWallThickness, zHeight=clampH, chmpf=champfer);
  /* cube([extensionX1,clampWallThickness,clampH-champfer*2]);*/

}





module strapCutout()
{
difference()
{
 cylinder(r=(supDia/2+clampWallThickness)+strapTh, h=strapWidth);
 translate([0,0,-extra])
 cylinder(r=(supDia/2+clampWallThickness), h=strapWidth+extra*2);
 translate([-supDia/2-clampWallThickness-strapTh-extra*2,
   -supDia/2-clampWallThickness-strapTh-extra,
   0])
   cube([supDia/2+clampWallThickness+extra*2,supDia+clampWallThickness*2+strapTh*2+extra*2,clampH+extra*2]);
}
}

/* corpus(); */
module corpus()
{
  difference()
  {
    union()
    {
      cylinder(r=(supDia/2+clampWallThickness), h=clampH);

      hull()
      {
        translate([supDia/2,-rodTubeLen/2,0])
          cube([extra,rodTubeLen,clampH]);

        translate([supDia/2+clampWallThickness+rodDia/2+rodTubeWall*2,-rodTubeLen/2,clampH/2])
          rotate([-90,0,0])
          cylinder(r=(rodDia/2)+rodTubeWall,h=rodTubeLen);
      }
    }

    translate([supDia/2+clampWallThickness+rodDia/2+rodTubeWall*2,-rodTubeLen/2-extra,clampH/2])
      rotate([-90,0,0])
      cylinder(r=(rodDia/2),h=rodTubeLen+extra*2, $fn=6);

    translate([-supDia/2-clampWallThickness-extra*2,-supDia/2-clampWallThickness-extra,0])
      cube([supDia/2+clampWallThickness+extra*2,supDia+clampWallThickness*2+extra*2,clampH+extra*2]);

  }
}


module extension(lenX=10, wallTh=10, zHeight=10, chmpf=1)
{
  difference()
  {
    hull()
    {
      cube([lenX, wallTh-chmpf, 0.01]);
      translate([0,0,chmpf])
        cube([lenX, wallTh, zHeight-2*chmpf]);
      translate([0,0,zHeight])
        cube([lenX, wallTh-chmpf, 0.01]);
    }

    if(saveFilament)
    {

      translate([-5,0,clampH/2])
      rotate([-90,0,0])
      {
        scale([1,((clampH-20)/lenX),1])
        cylinder(r=lenX/2,h=clampWallThickness);
      }
    }
  }
}

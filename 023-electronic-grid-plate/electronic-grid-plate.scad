$fn=70;
extra=0.02;

xLen = 70;
yLen = 30;
plateThickness = 1;
cornerRad = 2;

outerStripTh = 3;
innerStripTh = 2;

cutoutNumX = 6;
cutoutNumY = 4;
cutoutRad = 0.5;

cutoutX = (xLen-(outerStripTh*2)-(cutoutNumX-1)*innerStripTh)/cutoutNumX;
cutoutY = (yLen-(outerStripTh*2)-(cutoutNumY-1)*innerStripTh)/cutoutNumY;

screwDia = 3.1;
screwDistX = 47.5;
screwDistY = 23;
screwRingTh = 2;

screwMountMoveX = 8.8;
screwMountMoveY = 0;

module plate()
{
  difference()
  {
    union()
    {
      difference()
      {
        translate([cornerRad,cornerRad,0])
        minkowski()
        {
          cube([xLen-cornerRad*2,yLen-cornerRad*2,plateThickness]);
          cylinder(r=cornerRad, h=0.001);
        }

        translate([outerStripTh,outerStripTh,0])
        for (iy = [0:1:cutoutNumY-1])
        {
          for (ix = [0:1:cutoutNumX-1])
          {
            translate([innerStripTh*ix+cutoutX*ix,innerStripTh*iy+cutoutY*iy,0])
            cutout();
          }
        }
      }
      translate([(xLen/2-screwDistX/2)+screwMountMoveX,(yLen/2-screwDistY/2)+screwMountMoveY,0])
      for (iScY = [0:1])
      {
        for (iScX = [0:1])
        {
          translate([screwDistX*iScX,screwDistY*iScY,0])
          cylinder(d=screwDia+screwRingTh*2,h=plateThickness);
        }
      }
    } /*union: plate w/ cutouts*/

    translate([(xLen/2-screwDistX/2)+screwMountMoveX,(yLen/2-screwDistY/2)+screwMountMoveY,0])
    for (iScY = [0:1])
    {
      for (iScX = [0:1])
      {
        translate([screwDistX*iScX,screwDistY*iScY,-extra])
        cylinder(d=screwDia,h=plateThickness+extra*2);
      }
    }

  }
}



module cutout()
{
  translate([cutoutRad,cutoutRad,-extra])
  minkowski()
  {
    cube([cutoutX-cutoutRad*2, cutoutY-cutoutRad*2, plateThickness+extra*2]);
    cylinder(r=cutoutRad, h=0.001);
  }
}


/* cutout(); */
plate();

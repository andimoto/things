$fn=20;
extra=0.005;

pixelSideDim = 9;
pixelWallDim = 1.2;
pixelFootDim = 0.4;
pixelTopSocketThick = 0.4;
pixelNotchSphereRad = 2;
pixelNotchOffset = 1.7;

matrixPixelCntX = 5;
matrixPixelCntY = 5;

matrixBtmThick = 1;
matrixWallThickness = 0.8;
matrixToPixelClearance = 0.1;

notchHoldRad = 1;

matrixDimX = (matrixPixelCntX * (pixelSideDim+matrixToPixelClearance)) + (matrixPixelCntX+1)*matrixWallThickness;
matrixDimY = (matrixPixelCntY * (pixelSideDim+matrixToPixelClearance)) + (matrixPixelCntY+1)*matrixWallThickness;

matrix();

module matrix()
{

  difference()
  {
    union()
    {
      cube([matrixDimX,matrixDimY,matrixBtmThick+pixelSideDim+matrixToPixelClearance]);
    }

    translate([matrixWallThickness,matrixWallThickness,matrixBtmThick+extra])
    for (ynum = [0:matrixPixelCntY-1])
    {
      for (xnum = [0:matrixPixelCntX-1])
      {
        translate([xnum*(pixelSideDim+matrixToPixelClearance+matrixWallThickness),
                   ynum*(pixelSideDim+matrixToPixelClearance+matrixWallThickness),
                   0])
        cube(pixelSideDim+matrixToPixelClearance);

        translate([pixelWallDim/2,pixelWallDim/2,-matrixBtmThick-extra*2])
        translate([xnum*(pixelSideDim+matrixToPixelClearance+matrixWallThickness),
                   ynum*(pixelSideDim+matrixToPixelClearance+matrixWallThickness),
                   0])
        cube(pixelSideDim-pixelWallDim);



        translate([(pixelSideDim+matrixToPixelClearance+matrixWallThickness)*xnum,0,0])
        translate([((pixelSideDim+matrixToPixelClearance)/2),-matrixWallThickness/2,(pixelSideDim+matrixToPixelClearance)/2])
        rotate([-90,0,0])
        cylinder(r=notchHoldRad,h=(pixelSideDim+matrixToPixelClearance+matrixWallThickness)*matrixPixelCntY);

        translate([0,(pixelSideDim+matrixToPixelClearance+matrixWallThickness)*ynum,0])
        translate([-matrixWallThickness/2,((pixelSideDim+matrixToPixelClearance)/2),(pixelSideDim+matrixToPixelClearance)/2])
        rotate([0,90,0])
        cylinder(r=notchHoldRad,h=(pixelSideDim+matrixToPixelClearance+matrixWallThickness)*matrixPixelCntX);

      }
    }
  }
}

translate([-20,0,0])
pixel();

module pixel()
{
  difference()
  {
    union()
    {
      cube(pixelSideDim);
      translate([0,0,pixelSideDim])
      hull()
      {
        translate([-pixelFootDim/2,-pixelFootDim/2,pixelFootDim])
        cube([pixelSideDim+pixelFootDim,pixelSideDim+pixelFootDim, extra]);
        cube([pixelSideDim,pixelSideDim, extra]);
      }
      translate([-pixelFootDim/2,-pixelFootDim/2,pixelSideDim+pixelFootDim])
      cube([pixelSideDim+pixelFootDim,pixelSideDim+pixelFootDim, pixelTopSocketThick]);

      translate([pixelSideDim/2,0,pixelSideDim/2])
      translate([0,pixelNotchOffset,0])
      sphere(r=pixelNotchSphereRad);
      translate([pixelSideDim/2,pixelSideDim,pixelSideDim/2])
      translate([0,-pixelNotchOffset,0])
      sphere(r=pixelNotchSphereRad);
    }

    translate([pixelWallDim,pixelWallDim,-extra])
    cube(pixelSideDim-pixelWallDim*2);
  }
}

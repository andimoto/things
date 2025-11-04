$fn=80;
extra=0.02;


plateZ = 4;
plateX = 120;
plateY = 120;

plateR = 5;

funnelOuterDia = 100;
funnelWallTh = 2;
funnelZ = 80;

toleranceRad = 2;

mntHoleDist = 93;
fanHoleDist = 105;

mntHoleEnable = true;
mntHoleRotation = 8;
mntHoleList=[[mntHoleDist/2,mntHoleDist/2],[-mntHoleDist/2,mntHoleDist/2],
      [mntHoleDist/2,-mntHoleDist/2],[-mntHoleDist/2,-mntHoleDist/2]];

fanHoleEnable = true;
fanHoleRotation = 0;
fanHoleList=[[fanHoleDist/2,fanHoleDist/2],[-fanHoleDist/2,fanHoleDist/2],
      [fanHoleDist/2,-fanHoleDist/2],[-fanHoleDist/2,-fanHoleDist/2]];


function getTolerance(mount = false) = (mount==true) ? toleranceRad : 0 ;

translate([plateX+10,0,0])
tubeFlange(plateThickness=plateZ,mountPlate = true);

tubeFlange(plateThickness=plateZ);
module tubeFlange(plateThickness = 3, mountPlate=false)
{
  difference()
  {
    union()
    {
      translate([plateR,plateR,0])
      minkowski()
      {
        cube([plateX-plateR*2,plateY-plateR*2,plateThickness]);
        cylinder(r=plateR,h=0.0001);
      }

      translate([plateX/2,plateY/2,0])
      cylinder(r=(funnelOuterDia/2), h=funnelZ+plateThickness, center=false);
    }

    translate([plateX/2,plateY/2,-extra])
    cylinder(r=(funnelOuterDia/2)-funnelWallTh, h=funnelZ+plateThickness+extra*2, center=false);

    if(mountPlate == true)
    {
      translate([plateX/2,plateY/2,-extra])
      cylinder(r=(funnelOuterDia/2)+getTolerance(true), h=funnelZ+plateThickness+extra*2, center=false);
    }

    if(mntHoleEnable == true)
    {
      translate([plateX/2,plateY/2,-extra])
      rotate([0,0,mntHoleRotation])
      cylinderList(dia=4,height=plateThickness+extra*2,points=mntHoleList);
    }

    if(fanHoleEnable == true)
    {
      translate([plateX/2,plateY/2,-extra])
      rotate([0,0,fanHoleRotation])
      cylinderList(dia=4,height=plateThickness+extra*2,points=fanHoleList);
    }
  }
}



module cylinderList(dia=9,height=3,points=[[0,0],[1,1]])
{
  for(point = points)
  {
    translate([point[0],point[1],0])
    cylinder(d=dia, h=height);
  }
}

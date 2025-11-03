$fn=80;
extra=0.02;


plateZ = 2;
plateX = 110;
plateY = 110;

plateR = 5;

funnelOuterDia = 100;
funnelWallTh = 2;
funnelZ = 100;


funnel();
module funnel()
{
  difference()
  {
    union()
    {
      plate();

    }

  }

}

function getSkirtX() = (mount==true) ? skirtX : 0 ;

plate();
module plate(mountPlate=false)
{
  difference()
  {
    translate([plateR,plateR,0])
    minkowski()
    {
      cube([plateX-plateR*2,plateY-plateR*2,plateZ]);
      cylinder(r=plateR,h=0.0001);
    }

    /* plateTolerance = */
    translate([plateX/2,plateY/2,-extra])
    cylinder(r=(funnelOuterDia/2)-funnelWallTh, h=funnelZ+plateZ, center=false);
  }
}

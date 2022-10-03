$fn=150;

layerHeigth=0.2;

fanXY=80;
fanZ=18;

cutoutHoleDia=37; /* set diameter of necessaty blowout hole */
cutoutHoleR=cutoutHoleDia/2;
cutoutTubeLen=30;
wallThickness=2;

screwR=1.95;
screwDistance=71.4;
fanHole=76;
frontPlateThickness=4;

module mountingScrewHoles()
{
  cylinder(r=screwR, h=frontPlateThickness, center=false);
  translate([screwDistance,0,0]) cylinder(r=screwR, h=frontPlateThickness, center=false);
  translate([0,screwDistance,0]) cylinder(r=screwR, h=frontPlateThickness, center=false);
  translate([screwDistance,screwDistance,0]) cylinder(r=screwR, h=frontPlateThickness, center=false);
}

/* translate([(fanXY-screwDistance)/2,(fanXY-screwDistance)/2,0])
mountingScrewHoles(); */

module fanMountingPlate()
{
  difference() {
    cube([fanXY,fanXY,frontPlateThickness]);

    translate([fanXY/2,fanXY/2,0])
      cylinder(r=fanHole/2, h=frontPlateThickness, center=false);

    translate([(fanXY-screwDistance)/2,(fanXY-screwDistance)/2,0])
      mountingScrewHoles();
  }
}

/* fanMountingPlate(); */


module fanOut()
{

  difference() {
    union()
    {
      fanMountingPlate();
      difference() {
        hull()
        {
          cube([fanXY,fanXY,fanZ]);
          translate([fanXY/2,0,cutoutHoleR]) rotate([-90,0,0]) cylinder(r=cutoutHoleR,h=fanXY);
        }
        hull()
        {
          translate([wallThickness,wallThickness,0]) cube([fanXY-wallThickness*2,fanXY-wallThickness*2,fanZ]);
          translate([fanXY/2,wallThickness,cutoutHoleR]) rotate([-90,0,0]) cylinder(r=cutoutHoleR-wallThickness/2,h=fanXY-wallThickness*2);
        }
      }
      translate([fanXY/2,-cutoutTubeLen,cutoutHoleR]) rotate([-90,0,0]) cylinder(r=cutoutHoleR,h=cutoutTubeLen);
    }
    translate([fanXY/2,-cutoutTubeLen,cutoutHoleR]) rotate([-90,0,0]) cylinder(r=cutoutHoleR-wallThickness,h=cutoutTubeLen+wallThickness-layerHeigth);
  }
}

fanOut();

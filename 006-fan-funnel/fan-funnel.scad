$fn=150;
extra=0.01;
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

/* fanOut(); */


module filterEdge()
{
/* translate([0,0,0])  cylinder(r=cutoutHoleR,h=10); */
  difference()
  {
    union()
    {
      cube([cutoutHoleR*4+wallThickness*2,cutoutHoleR*2+wallThickness*2,10+wallThickness]);
      translate([cutoutHoleR*4+wallThickness*2,cutoutHoleR+wallThickness,0])
        cylinder(r=cutoutHoleR+wallThickness,h=wallThickness*2+20);

      hull()
      {
        translate([0,cutoutHoleR*2+wallThickness*2,0])
        cube([cutoutHoleR*2+wallThickness*2,1,10+wallThickness]);

        translate([cutoutHoleR+wallThickness,80,cutoutHoleR+wallThickness+1])
          rotate([-90,0,0])
          cylinder(r=cutoutHoleR+wallThickness,h=1);
      }

      translate([cutoutHoleR+wallThickness,80,cutoutHoleR+wallThickness+1])
        rotate([-90,0,0])
        cylinder(r=cutoutHoleR+wallThickness,h=20);
    }

    translate([cutoutHoleR*4+wallThickness*2,cutoutHoleR+wallThickness,wallThickness])
      cylinder(r=cutoutHoleR,h=10-wallThickness);

    translate([cutoutHoleR*4+wallThickness*2,cutoutHoleR+wallThickness,10+0.2])
      cylinder(r=cutoutHoleR,h=10+wallThickness*2);

    translate([wallThickness,wallThickness,wallThickness]) cube([cutoutHoleR*4+wallThickness*2,cutoutHoleR*2,10-wallThickness]);

    translate([wallThickness,cutoutHoleR*2,wallThickness])
    cube([cutoutHoleR*2,wallThickness*2+extra,10-wallThickness]);

    hull()
    {
      translate([wallThickness,cutoutHoleR*2+wallThickness*2,wallThickness])
      cube([cutoutHoleR*2,1,10-wallThickness]);

      translate([cutoutHoleR+wallThickness,80,cutoutHoleR+wallThickness+1])
        rotate([-90,0,0])
        cylinder(r=cutoutHoleR,h=1);
    }

    translate([cutoutHoleR+wallThickness,80,cutoutHoleR+wallThickness+1])
      rotate([-90,0,0])
      cylinder(r=cutoutHoleR,h=20+extra);

    translate([wallThickness,wallThickness,-extra])
      cube([cutoutHoleR*2,cutoutHoleR*2,wallThickness+extra*2]);
  }
}


/* difference()
{
  filterEdge();
  translate([0,0,0])
  cube([100,cutoutHoleR*2+wallThickness*2,40]);
} */

/* difference()
{
  filterEdge();
  translate([0,cutoutHoleR*2+wallThickness*2,0])
  cube([100,cutoutHoleR*2+wallThickness*2+21,50]);

  if(0)
  {
    translate([0,cutoutHoleR,0])
    cube([100,cutoutHoleR*2+wallThickness*2+21,50]);
  }
} */


module filterCardridge()
{
  difference()
  {
    union()
    {
      cube([cutoutHoleR*2+wallThickness*2,cutoutHoleR*2+wallThickness*2,wallThickness]);
      translate([wallThickness+extra,wallThickness+extra,wallThickness]) cube([cutoutHoleR*2-extra*2,cutoutHoleR*2-extra*2,10]);
    }
    translate([wallThickness*2,wallThickness*2,wallThickness])
      cube([cutoutHoleR*2-wallThickness*2,cutoutHoleR*2-wallThickness*2,10]);

    translate([0,0,wallThickness])
    hull()
    {
      translate([wallThickness,wallThickness*2-1,10-1]) cube([cutoutHoleR*2-wallThickness+extra*2,cutoutHoleR*2-wallThickness*2+2,0.1]);
      translate([wallThickness,wallThickness*2,10-0.1]) cube([cutoutHoleR*2-wallThickness+extra*2,cutoutHoleR*2-wallThickness*2,0.1]);
    }

    for(i=[0:8])
    {
      translate([0,3.85*i,0])
      translate([wallThickness*2,wallThickness*2,wallThickness+1])
        cube([cutoutHoleR*2,2,7]);
    }

    for(i=[0:8])
    {
      translate([3.85*i,0,0])
      translate([wallThickness*2,wallThickness,wallThickness+1])
        cube([2,cutoutHoleR*2,7]);
    }
  }
}

translate([0,0,-18])
filterCardridge();


module cardridgeTopSlide()
{
  /* closeing plate for cardridge */
  hull()
  {
    translate([wallThickness,wallThickness*2-1,10-1]) cube([cutoutHoleR*2-wallThickness,cutoutHoleR*2-wallThickness*2+2-0.4,0.1]);
    translate([wallThickness,wallThickness*2,10-0.1]) cube([cutoutHoleR*2-wallThickness,cutoutHoleR*2-wallThickness*2-0.4,0.1]);
  }
}
/* cardridgeTopSlide(); */

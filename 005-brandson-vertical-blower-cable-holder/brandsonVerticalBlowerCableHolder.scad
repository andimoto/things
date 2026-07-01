/* brandsonVerticalBlowerCableHolder.scad
Author: andimoto@posteo.de
----------------------------
*/

$fn=150;
extra = 0.1;

dBlower = 134; //mm outer diameter
dButtonRing = 118; //mm button plate diameter
hButtonRing = 9; //mm height of button plate diameter

wallThickness = 2; //mm
remoteWidth = 40; //mm
remoteLen = 75; //mm
remoteH = 8; //mm

plugExtra = 10; //mm

module bbf_holder_v1()
{
  difference() {
    union()
    {
      cylinder(r=dBlower/2,h=hButtonRing);
      translate([0,-remoteWidth/2-wallThickness,0]) cube([dBlower/2+remoteH,remoteWidth+wallThickness*2,hButtonRing]);

      translate([dBlower/2,-remoteWidth/2-wallThickness,0]) cube([remoteH+wallThickness*2,remoteWidth+wallThickness*2,remoteLen+plugExtra]);
    }
    /* cutout for panel ring */
    translate([0,0,-extra/2]) cylinder(r=dButtonRing/2,h=hButtonRing+extra);

    /* cutout for remote pocket */
    translate([dBlower/2+wallThickness,-remoteWidth/2,-extra]) cube([remoteH,remoteWidth,remoteLen-wallThickness]);

    /* holes for plug */
    translate([dBlower/2+remoteH/2+wallThickness,0,remoteLen])
    union()
    {
      translate([0,(2+15)/2,0]) cylinder(r=4.5/2,h=plugExtra);
      translate([0,-(2+15)/2,0]) cylinder(r=4.5/2,h=plugExtra);
    }
  }
}

bbf_holder_v2_top();

rodHolderDia = 25;
rodHolderDia_base = 35;

baseRodHoleAngle=30;
rodAngle = 90;

module bbf_holder_v2_top()
{
  difference() {
    union()
    {
      hull()
      {
        cylinder(r=dBlower/2,h=hButtonRing);
        rotate([0,0,baseRodHoleAngle])
        translate([dBlower/2 + rodHolderDia/2,0,0])
          cylinder(d=rodHolderDia, h=hButtonRing);

        rotate([0,0,baseRodHoleAngle+rodAngle])
        translate([dBlower/2 + rodHolderDia/2,0,0])
          cylinder(d=rodHolderDia, h=hButtonRing);


        translate([0,-remoteWidth/2-wallThickness,0])
        cube([dBlower/2+remoteH,remoteWidth+wallThickness*2,hButtonRing]);
      }
      /* translate([0,-remoteWidth/2-wallThickness,0]) cube([dBlower/2+remoteH,remoteWidth+wallThickness*2,hButtonRing]); */

      translate([dBlower/2,-remoteWidth/2-wallThickness,0]) cube([remoteH+wallThickness*2,remoteWidth+wallThickness*2,remoteLen+plugExtra]);
    }
    /* cutout for panel ring */
    translate([0,0,-extra/2]) cylinder(r=dButtonRing/2,h=hButtonRing+extra);

    /* cutout for remote pocket */
    translate([dBlower/2+wallThickness,-remoteWidth/2,-extra]) cube([remoteH,remoteWidth,remoteLen-wallThickness]);

    /* holes for plug */
    translate([dBlower/2+remoteH/2+wallThickness,0,remoteLen])
    union()
    {
      translate([0,(2+15)/2,0]) cylinder(r=4.5/2,h=plugExtra);
      translate([0,-(2+15)/2,0]) cylinder(r=4.5/2,h=plugExtra);
    }


    rotate([0,0,baseRodHoleAngle])
    translate([dBlower/2 + rodHolderDia/2,0,-extra])
      cylinder(d=9, h=hButtonRing+extra*2);

    rotate([0,0,baseRodHoleAngle+rodAngle])
    translate([dBlower/2 + rodHolderDia/2,0,-extra])
      cylinder(d=9, h=hButtonRing+extra*2);
  }
}

bottlePlateWall = 5;
bottlePlateDia = 100;
bottlePlateH=40;

/* bbf_holder_v2_BottleBase(); */
module bbf_holder_v2_BottleBase()
{
  difference() {
    union()
    {
      hull()
      {
        /* #cylinder(r=dBlower/2,h=hButtonRing); */
        rotate([0,0,baseRodHoleAngle])
        translate([dBlower/2 + rodHolderDia_base/2,0,0])
          cylinder(d=rodHolderDia_base, h=bottlePlateH);

        rotate([0,0,baseRodHoleAngle+rodAngle])
        translate([dBlower/2 + rodHolderDia_base/2,0,0])
          cylinder(d=rodHolderDia_base, h=bottlePlateH);

        rotate([0,0,baseRodHoleAngle+rodAngle/2])
        translate([dBlower,0,-extra/2])
          cylinder(r=(bottlePlateDia+bottlePlateWall)/2,h=bottlePlateH/2+extra);

      }

    }
    /* cutout for panel ring */
    translate([0,0,-extra/2]) cylinder(r=dBlower/2,h=bottlePlateH+extra);

    rotate([0,0,baseRodHoleAngle+rodAngle/2])
    translate([dBlower,0,hButtonRing-4])
      cylinder(r=(bottlePlateDia)/2,h=bottlePlateH+extra);

    // rod holes
    rotate([0,0,baseRodHoleAngle])
    translate([dBlower/2 + rodHolderDia/2,0,-extra])
      cylinder(d=9, h=bottlePlateH+extra*2);

    rotate([0,0,baseRodHoleAngle+rodAngle])
    translate([dBlower/2 + rodHolderDia/2,0,-extra])
      cylinder(d=9, h=bottlePlateH+extra*2);


    rotate([0,0,-18+baseRodHoleAngle+rodAngle/2])
    translate([60,-2.5,hButtonRing])
    cube([50,5,bottlePlateH-hButtonRing*2]);

    rotate([0,0,-9+baseRodHoleAngle+rodAngle/2])
    translate([60,-2.5,hButtonRing])
    cube([50,5,bottlePlateH-hButtonRing*2]);

    rotate([0,0,baseRodHoleAngle+rodAngle/2])
    translate([60,-2.5,hButtonRing])
    cube([50,5,bottlePlateH-hButtonRing*2]);

    rotate([0,0,9+baseRodHoleAngle+rodAngle/2])
    translate([60,-2.5,hButtonRing])
    cube([50,5,bottlePlateH-hButtonRing*2]);

    rotate([0,0,18+baseRodHoleAngle+rodAngle/2])
    translate([60,-2.5,hButtonRing])
    cube([50,5,bottlePlateH-hButtonRing*2]);

  }
}

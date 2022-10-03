/* 006-fan-funnel-upgrade.scad
Author: andimoto@posteo.de
----------------------------
*/
$fn = 100;
tubeDia = 37; //mm
wallThickness = 2; //mm

lampInnerDia = 47.7; //mm
lampOuterDia = 89.4; //mm
lampHeight = 7; //mm

cableR = 5; //mm
screwDia = 3.2; //mm


module tube()
{
  difference()
  {
    cylinder(r=tubeDia/2+wallThickness, h=30);
    cylinder(r=tubeDia/2, h=30);
  }

  translate([0,0,30])
  difference()
  {

    hull()
    {
      cylinder(r=tubeDia/2+wallThickness, h=0.001);

      translate([-2.7,0,10.3]) rotate([0,-30,0])
        cylinder(r=tubeDia/2+wallThickness, h=0.001);
    }
    hull()
    {
      cylinder(r=tubeDia/2, h=0.001);

      translate([-2.7,0,10.3]) rotate([0,-30,0])
        cylinder(r=tubeDia/2, h=0.0012);
    }

  }
  translate([-2.7,0,40.2]) rotate([0,-30,0])
  difference()
  {
    cylinder(r=tubeDia/2+wallThickness, h=50);
    cylinder(r=tubeDia/2, h=50);
  }
}
/* tube(); */

module lamp_holder()
{
  translate([0,-tubeDia/2-lampOuterDia/2-wallThickness,0])
  union()
  {
    difference() {
      union()
      {
        difference()
        {
          hull()
          {
            cylinder(r=lampOuterDia/2+wallThickness, h=lampHeight+wallThickness);
            translate([0,lampOuterDia/2+wallThickness+tubeDia/2,0])
              cylinder(r=tubeDia/2+wallThickness, h=lampHeight+wallThickness);
          }
          translate([0,lampOuterDia/2+wallThickness+tubeDia/2,0])
          cylinder(r=tubeDia/2, h=lampHeight+wallThickness);
        }
      }

      translate([0,0,wallThickness])
      difference()
      {
        cylinder(r=lampOuterDia/2, h=lampHeight);
        cylinder(r=lampInnerDia/2, h=lampHeight);
      }
      cylinder(r=lampInnerDia/2-wallThickness,lampHeight+wallThickness);

      /* cable hole */
      rotate([0,0,-120]) translate([0,-lampOuterDia/2+wallThickness/2,lampHeight])
        rotate([90,0,0]) cylinder(r=cableR,wallThickness*3);

        /* screw holes for keeping the round led lamp in place */
      rotate([0,0,-90]) translate([0,-lampOuterDia/2+wallThickness/2,lampHeight-wallThickness])
        rotate([90,0,0]) cylinder(r=screwDia/2,wallThickness*1.5);
      rotate([0,0,90]) translate([0,-lampOuterDia/2+wallThickness/2,lampHeight-wallThickness])
        rotate([90,0,0]) cylinder(r=screwDia/2,wallThickness*1.5);
    }
  }
}
/* lamp_holder(); */


module fan_funnel_lamp()
{
  rotate([0,0,90]) lamp_holder();
  tube();
}



fan_funnel_lamp();

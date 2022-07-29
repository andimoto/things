/* parametricCap.scad
Author: andimoto@posteo.de
----------------------------
*/
$fn=80;
flatness = 0.00001;

diaInner = 68.5;
hInner = 6.5;
wallThickness = 2;
champferDiff = 1;

diaFingerCone1 = 10;
fingerConeXMove = -3;

innerHingeSpace = 12;

hingePlateWidth = 7;
hingePlateThickness = wallThickness*2;
hingePlateR = 3;  //this can also be half hingePlateWidth

hingeExtraMove = 0;

hingeTubeDia = 3.5;

module cap(hinge = false, fingerCone = false)
{
  difference()
  {
    union()
    {
      hull()
      {
        translate([0,0,0]) cylinder(r=-champferDiff+wallThickness+diaInner/2,h=flatness);
        translate([0,0,champferDiff]) cylinder(r=wallThickness+diaInner/2,h=hInner+wallThickness);
      }
      if(fingerCone == true)
      {
        translate([(diaInner/2)+fingerConeXMove,0,0]) fingerGrip();
      }
    }
    translate([0,0,wallThickness+champferDiff]) cylinder(r=diaInner/2,h=hInner);

    if(hinge == true)
    {
      difference()
      {
        /* hinge cutout from wall */
        cylinder(r=wallThickness+diaInner/2,h=hInner+wallThickness+champferDiff);
        cylinder(r=diaInner/2,h=hInner+wallThickness+champferDiff);
        translate([-(diaInner+wallThickness*2)/2,innerHingeSpace/2,0])
          cube([diaInner+wallThickness*2,(diaInner+wallThickness)/2,hInner+wallThickness+champferDiff]);
        translate([-(diaInner+wallThickness*2)/2,-(innerHingeSpace/2+(diaInner+wallThickness)/2),0])
          cube([diaInner+wallThickness*2,(diaInner+wallThickness)/2,hInner+wallThickness+champferDiff]);
        translate([(diaInner/2+wallThickness*2)/2,-(diaInner/2+wallThickness)/2,0])
          cube([diaInner/2+wallThickness*2,(diaInner+wallThickness)/2,hInner+wallThickness+champferDiff]);
      } // difference of hinge end
    } // if close
  } // difference of cap end

  if(hinge == true)
  {
    translate([-(diaInner/2+hingePlateWidth+hingeExtraMove),innerHingeSpace/2,0])
      hingePlate(true);
    translate([-(diaInner/2+hingePlateWidth+hingeExtraMove),-(hingePlateThickness+innerHingeSpace/2),0])
      hingePlate();
  }

}

cap(true, true);

module hingePlate(hingeTube = false)
{
  translate([hingePlateR,hingePlateThickness,hInner+wallThickness+champferDiff])
    rotate([90,0,0]) cylinder(r=hingePlateR,h=hingePlateThickness);
  hull()
  {
    translate([champferDiff,0,0])
      cube([hingePlateWidth-champferDiff+wallThickness/2,hingePlateThickness,flatness]);
    translate([0,0,champferDiff])
      cube([hingePlateWidth,hingePlateThickness,hInner+wallThickness]);
  }
  if(hingeTube == true)
  {
    translate([hingePlateR,0,hInner+wallThickness+champferDiff])
    rotate([90,0,0]) cylinder(r=hingeTubeDia/2,h=innerHingeSpace);
  }
}
/* hingePlate(true); */

module fingerGrip()
{
  hull()
  {
    cylinder(r=diaFingerCone1-champferDiff,h=flatness);
    translate([0,0,champferDiff]) cylinder(r=diaFingerCone1,h=hInner-2);
    translate([0,0,champferDiff*2+hInner-2]) cylinder(r=diaFingerCone1-champferDiff,h=flatness);
  }
}

/* fingerGrip(); */

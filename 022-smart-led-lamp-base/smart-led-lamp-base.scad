$fn=100;
extra=0.02;

baseDia = 95;
innerBaseDia = 92.1;
baseH = 20;
baseWallThick = 3;
champferH = 3;
baseDiaLow = baseDia - champferH;

baseHoleDia = 4;
baseHoleMove = 20;

baseMountCylH = 16.5 + baseH +champferH;
baseMountCylWall = 1;

screwDia = 2.5;

difference()
{

  union()
  {
    difference()
    {
      translate([0,0,champferH])
      cylinder(r=baseDia/2,h=baseH);

      translate([0,0,champferH+extra])
      cylinder(r=(baseDia/2)-baseWallThick,h=baseH);
    }
    cylinder(r1=baseDiaLow/2, r2=baseDia/2, h=champferH);

    union()
    {
    translate([baseHoleMove,0,0])
    cylinder(r=(baseHoleDia/2)+baseMountCylWall,h=champferH+baseMountCylH);
    translate([-baseHoleMove,0,0])
    cylinder(r=(baseHoleDia/2)+baseMountCylWall,h=champferH+baseMountCylH);

    translate([baseHoleMove,0,champferH])
    cylinder(r1=(baseHoleDia/2)+baseMountCylWall+champferH,
      r2=(baseHoleDia/2)+baseMountCylWall,
      h=champferH);
    translate([-baseHoleMove,0,champferH])
    cylinder(r1=(baseHoleDia/2)+baseMountCylWall+champferH,
      r2=(baseHoleDia/2)+baseMountCylWall,
      h=champferH);
    }


  }
  translate([baseHoleMove,0,-extra])
  cylinder(r=baseHoleDia/2,h=champferH+baseMountCylH-baseMountCylWall+extra);
  translate([-baseHoleMove,0,-extra])
  cylinder(r=baseHoleDia/2,h=champferH+baseMountCylH-baseMountCylWall+extra);


  translate([baseHoleMove,0,0])
  cylinder(r=screwDia/2,h=champferH+baseMountCylH-baseMountCylWall);
  translate([-baseHoleMove,0,0])
  cylinder(r=screwDia/2,h=champferH+baseMountCylH-baseMountCylWall);


  translate([baseHoleMove,0,champferH+baseMountCylH-baseMountCylWall])
  cylinder(r1=baseHoleDia/2, r2=screwDia/2,h=baseMountCylWall+extra);
  translate([-baseHoleMove,0,champferH+baseMountCylH-baseMountCylWall])
  cylinder(r1=baseHoleDia/2, r2=screwDia/2,h=baseMountCylWall+extra);

  /* debug */
  /* cube([100,50,400]); */

}

$fn=80;
extra=0.01;

rad=4;
height=20;

wall=1;
xLen=56;
yLen=56;
yLenPlay=1;

/* FRAME */
{
  translate([rad-wall,rad-wall,0]) /* place inner dimension to root x=0 y=0 */
  difference()
  {
    minkowski()
    {
      cube([xLen+wall*2-rad*2,yLen+wall*2+yLenPlay-rad*2,height]);
      cylinder(r=rad,h=0.001);
    }
    translate([wall,wall,-extra])
    minkowski()
    {
      cube([xLen-rad*2,yLen+yLenPlay-rad*2,height+extra*2]);
      cylinder(r=rad,h=0.001);
    }
  }

  translate([-0.2,10,height-0.5])
  rotate([-90,0,0])
  cylinder(r=0.5,h=40);

  translate([xLen+0.2,10,height-0.5])
  rotate([-90,0,0])
  cylinder(r=0.5,h=40);

  translate([-0.2,10,0.5])
  rotate([-90,0,0])
  cylinder(r=0.5,h=40);

  translate([xLen+0.2,10,0.5])
  rotate([-90,0,0])
  cylinder(r=0.5,h=40);
}

/* LUG */
{
  translate([(xLen)/2,-11.5,0])
  difference() {
    hull()
    {
      cylinder(r=11,h=1);
      translate([-11,0,0])
      cube([22,11,1]);
    }
    cylinder(r=8,h=1+extra);
  }
}

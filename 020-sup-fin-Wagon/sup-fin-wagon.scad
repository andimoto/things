$fn=100;
extra=0.02;

file = "supFin-LargeForMini.stl";


usFinBase();

module usFinBase()
{
  difference()
  {
    union()
    {
      translate([-43.2802,0,0])
      rotate([0,0,-45])
      import(file,convexity=3);
    }
    translate([0,-5,24])
    cube([170,10,190]);
  }
}

/* by andimoto
a quick and dirty script

this is just an idea for creating a small workshop table for my small flat
with some space and a working plate to pull out

this script is configurable
 */

// select if it is a one element besta or two element
bigBesta = true;
// besta with feet
feet = true;
// select if besta has round feet
roundFeet = false;

// display mod
mod = true;



translate([0,0,0])
union()
{
  /* base */
  color("Cornsilk") cube([1200/2,395,640]);

  if(bigBesta == true)
  {
    color("Cornsilk") translate([1200/2,0,0]) cube([1200/2,395,640]);
  }
  translate([5,-20,5])
  union()
  {
    /* doors left */
    color("BurlyWood") cube([590,20,630]);
    color("Cornsilk") translate([5,-0.2,5]) cube([580,20,620]);

      if(bigBesta == true)
      {
        /* doors right */
      translate([600,0,0]){

        color("BurlyWood") cube([590,20,630]);
        color("Cornsilk") translate([5,-0.2,5]) cube([580,20,620]);
      }
    }
  }

  if(feet == true)
  {
    color("Cornsilk")
    {
      translate([20,20,-100]) feet();
      translate([20,395-44-20,-100]) feet();


      if(bigBesta == true)
      {
        translate([1200-44-20,20,-100]) feet();
        translate([1200-44-20,395-44-20,-100]) feet();
      }else{
        translate([1200/2-44-20,20,-100]) feet();
        translate([1200/2-44-20,395-44-20,-100]) feet();
      }
    }
  }
}


module feet()
{
  if(roundFeet == false)
  {
    cube([44,44,100]);
  }else{
    translate([22,22,0]) cylinder(r=22,h=100);
  }
}


if(mod == true)
{
  /* working plate on top */
  color("BurlyWood") translate([0,0,640+100]) cube([1200/2,395,30]);
  if(bigBesta == true)
  {
    color("BurlyWood") translate([1200/2,0,640+100]) cube([1200/2,395,30]);
  }

  color("BurlyWood")
  translate([0,0,640]) cube([50,395,100]);

  if(bigBesta == true)
  {
    color("BurlyWood")
    translate([1200-50,0,640]) cube([50,395,100]);

    color("Silver")
    translate([1200-50-20,0,640]) cube([20,350,50]);
  }else{
    color("BurlyWood")
    translate([1200/2-50,0,640]) cube([50,395,100]);

    color("Silver")
    translate([1200/2-50-20,0,640]) cube([20,350,50]);
  }

  translate([0,-350*$t,0])
  {
    color("Silver")
    translate([50,0,640]) cube([20,350+350*$t,50]);
    if(bigBesta == true)
    {
      color("Silver")
      translate([1200-50-20,0,640]) cube([20,350,50]);
    }else{
      color("Silver")
      translate([1200/2-50-20,0,640]) cube([20,350,50]);
    }
  }


  /* working plate in between */
  translate([0,-350*$t,0])
  {
    color("BurlyWood") translate([50+20,0,640+10]) cube([1200/2-140,395,30]);
    if(bigBesta == true)
    {
      color("BurlyWood") translate([1200/2-50-20,0,640+10]) cube([1200/2,395,30]);
    }
  }

}

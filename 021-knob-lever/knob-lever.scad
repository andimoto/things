$fn=100;
extra=0.02;

dKnob = 45;
hKnob = 11;
wKnobHandle = 17;
leverWallThickness = 5;

dLever = 10;
moveLever = 70;

watchWindowX = 13;
watchWindowY = 10;

moveWatchWinX = ((dKnob/2) -1 + 0.4);


module knobLever()
{
  difference()
  {
    hull()
    {
      cylinder(r=(dKnob/2+leverWallThickness), h=hKnob);

      translate([moveLever,0,0])
      cylinder(r=(dLever/2), h=hKnob);
    }

    intersection()
    {
      cylinder(r=(dKnob/2), h=hKnob+extra);

      translate([-dKnob/2,-wKnobHandle/2,1])
      cube([dKnob,wKnobHandle,hKnob+extra]);
    }

    translate([moveWatchWinX,-watchWindowY/2,1])
    cube([watchWindowX,watchWindowY,hKnob]);

    hull()
    {
      translate([moveWatchWinX,-watchWindowY/2,1])
      cube([watchWindowX,watchWindowY,extra]);
      translate([moveWatchWinX-1/2,-(watchWindowY+1)/2,-extra])
      cube([watchWindowX+1,watchWindowY+1,extra]);
    }

    translate([0,0,-extra/2])
    cylinder(r2=3/2, r1=4.5/2, h=1+extra);

  }
}


knobLever();

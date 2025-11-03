$fn=150;
extra = 0.005;

innerFanX=48;
innerFanY=70;
innerFanZ=10;

fanRoundness=true;
fanRad=500;
fanRadCut=1.4;

wallThickness=3;
hoseWallThick=5;

innerHoseDia1=31.2;
innerHoseDia2=30.8;
outerHoseZ=10;

funnelHeight=50;

placeLonghole=true;
screwDia=3;


clampDia=8;
clampLen=15;
clampWallThick=3;

ribThickness=3.9;

module funnel(x,y,z, hoseDia1, hoseDia2, hoseZ, funnelZ)
{
  hull()
  {
    translate([1,1,0])
    minkowski()
    {
      cube([x-2,y-2,z]);
      cylinder(r=1,h=0.00000000000001);
    }
    translate([x/2,y/2,funnelZ-hoseZ]) cylinder(r=hoseDia2/2, h=0.0000000000001, center=false);
  }
  translate([x/2,y/2,funnelZ-hoseZ]) cylinder(r1=hoseDia2/2,r2=hoseDia1/2, h=hoseZ, center=false);
}

module longHole()
{
  hull()
  {
    translate([-1,0,0]) rotate([0,90,0]) cylinder(r=screwDia/2, h=innerFanX+2*wallThickness+2);
    translate([-1,8,0]) rotate([0,90,0]) cylinder(r=screwDia/2, h=innerFanX+2*wallThickness+2);
  }
}

module carFanFunnel()
{
  difference()
  {
    funnel( innerFanX+2*wallThickness,
            innerFanY+2*wallThickness,
            innerFanZ,
            innerHoseDia1+2*hoseWallThick,innerHoseDia2+2*hoseWallThick, outerHoseZ, funnelHeight);
    translate([wallThickness,wallThickness,0])
    funnel(innerFanX,innerFanY,innerFanZ,innerHoseDia1,innerHoseDia2, outerHoseZ, funnelHeight);

    if(fanRoundness == true)
    {
      translate([0,(innerFanY+2*wallThickness)/2,-fanRad+fanRadCut]) rotate([0,90,0]) cylinder(r=fanRad,h=innerFanX+2*wallThickness);
    }

    if(placeLonghole == true)
    {
      translate([0,10,innerFanZ/2]) longHole();
      translate([0,innerFanY+2*wallThickness-8-10,innerFanZ/2]) longHole();
      translate([0,innerFanY/2+wallThickness-4,innerFanZ/2]) longHole();
    }
  }
}

module trapez() {
  hull()
  {
    cube([clampDia-1,1,clampWallThick]);
    translate([0,clampLen-1,0]) cube([clampDia/4,1,clampWallThick]);
  }
}

module clamp2()
{
  difference()
  {
    hull()
    {
      translate([3,innerFanZ-1+clampLen,0]) cube([(clampDia)+ribThickness-0.2,1,clampWallThick]);
      translate([0,innerFanZ-1,0]) cube([(clampDia-1)*2+ribThickness-0.2,1,clampWallThick]);
      translate([clampDia-1+ribThickness/2,innerFanZ/2,0]) cylinder(r=innerFanZ/2,h=clampWallThick);
    }

    translate([clampDia-1,innerFanZ-1,0]) cube([ribThickness-0.2,1+clampLen,clampWallThick]);
    translate([clampDia-1.1+ribThickness/2,innerFanZ/2,0]) cylinder(r=(screwDia-0.2)/2,h=clampWallThick);
  }
}


module clamp1()
{
  translate([1,1,0])
  difference() {
    minkowski()
    {
      cube([innerFanZ+clampLen-2,clampDia-2,clampWallThick]);
      cylinder(r=1,h=0.00000000000001);
    }
    translate([innerFanZ/2-1,clampDia/2-1,0]) cylinder(r=(screwDia-0.2)/2,h=clampWallThick);
  }
}


module hook()
{
  hull()
  {
    translate([0,2,0]) cube([10,8,0.0000000000001]);
    translate([0,0,3]) cube([10,3,0.0000000000001]);
  }
}


fanOutX=120;
fanOutY=120;
fanOutZ=30;

fanOutInnerDia=60;

adapterH = 40;

shaftLen=40;


hook = false;
fanCutOut = true;
fanDia = 110;

enChambers = true;
slotCutOut = false;
slotCnt = 12;
slotSpace = 8;
chambSepCnt = 2;

module fanOut()
{
  difference()
  {
    hull()
    {
      translate([0,adapterH,-fanOutZ/2]) cube([fanOutX,0.0000000000001,fanOutZ]);
      translate([(fanOutX)/2,0,0]) rotate([90,0,0]) cylinder(r=fanOutInnerDia/2+wallThickness,h=0.0000000000001);
    }

    translate([wallThickness,0,0])
    hull()
    {
      translate([0,adapterH+extra,-fanOutZ/2+wallThickness]) cube([fanOutX-2*wallThickness,0.0000000000001,fanOutZ-wallThickness*2]);
      translate([(fanOutX-2*wallThickness)/2,0,0]) rotate([90,0,0]) cylinder(r=fanOutInnerDia/2,h=extra);
    }
  }

  difference()
  {
    translate([(fanOutX)/2,0,0]) rotate([90,0,0]) cylinder(r=fanOutInnerDia/2+wallThickness,h=shaftLen);
    translate([(fanOutX)/2,extra,0]) rotate([90,0,0]) cylinder(r=fanOutInnerDia/2,h=shaftLen+extra*2);
  }

  difference()
  {
    translate([0,shaftLen,-fanOutZ/2]) cube([fanOutX,fanOutY,fanOutZ]);
    translate([wallThickness,shaftLen-extra,-fanOutZ/2+wallThickness])
      cube([fanOutX-2*wallThickness,fanOutY-wallThickness,fanOutZ-wallThickness*2]);

    if(fanCutOut == true)
    {
      translate([fanOutX/2,shaftLen+fanOutY/2,fanOutZ/2-wallThickness-extra])
      rotate([0,0,45/2])
      cylinder(d=fanDia, h = wallThickness+extra*2, $fn=8);
    }

    if(slotCutOut == true)
    {
      for(i=[0:slotCnt])
      {
        translate([wallThickness,52+(i*slotSpace),fanOutZ/2-wallThickness*2])
        rotate([120,0,0]) cube([fanOutX-2*wallThickness,20,3]);
      }
    }
  }

  if(hook == true)
  {
    translate([0,30,fanOutZ/2]) hook();
    translate([40,30,fanOutZ/2]) hook();
  }

  if(enChambers == true)
  {
    chambX = ((fanOutX)) / (chambSepCnt+1);
    echo(chambX);
    /* translate([wallThickness,0,0]) */
    for(i=[1:chambSepCnt])
    {
      translate([(chambX*i)-wallThickness/2,shaftLen,-fanOutZ/2])
        cube([wallThickness,fanOutY-wallThickness,fanOutZ]);
    }
  }
}

/* clamp1(); */
/* clamp2(); */
difference() {
  /* carFanFunnel(); */
  fanOut();
  /* translate([50,-60,fanOutZ/2-wallThickness-extra]) cube([100,300,100]); */
}

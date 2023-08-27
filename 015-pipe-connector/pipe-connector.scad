/* pipe-connector.scad
Author: andimoto@posteo.de
----------------------------
*/

$fn=80;

outerDia = 22;
wallThickness = 10;
length = 80;

screwSetThickness = 5;
screwEndClearence = 10;

insertDia=3;
insertH=6;

extra = 0.01;



/* pipe(); */
module pipe()
{
  difference()
  {
    cylinder(r=outerDia/2+wallThickness, h=length);
    translate([0,0,-extra])
    cylinder(r=outerDia/2, h=length+extra*2);
  }
}

translate([0,10,0])
mirror([0,1,0])
pipeCon1();
module pipeCon1()
{
  difference()
  {
    pipe();
    translate([-outerDia/2-wallThickness,0,-extra])
    cube([outerDia+wallThickness*2,outerDia+wallThickness,length+extra*2]);

    screws();
  }
}

/* pipeCon2(); */
module pipeCon2()
{
  difference()
  {
    pipe();
    translate([-outerDia/2-wallThickness,0,-extra])
    cube([outerDia+wallThickness*2,outerDia+wallThickness,length+extra*2]);

    inserts();
  }

}

/* inserts(); */
module inserts()
{
  translate([-outerDia/2-wallThickness/2,-insertH+extra,screwEndClearence])
  rotate([-90,0,0])
  cylinder(r=insertDia/2,h=insertH);
  translate([-outerDia/2-wallThickness/2,-insertH+extra,length-screwEndClearence])
  rotate([-90,0,0])
  cylinder(r=insertDia/2,h=insertH);

  translate([outerDia/2+wallThickness/2,-insertH+extra,screwEndClearence])
  rotate([-90,0,0])
  cylinder(r=insertDia/2,h=insertH);
  translate([outerDia/2+wallThickness/2,-insertH+extra,length-screwEndClearence])
  rotate([-90,0,0])
  cylinder(r=insertDia/2,h=insertH);
}


module screws()
{
  translate([-outerDia/2-wallThickness/2,-outerDia/2-wallThickness-screwSetThickness,screwEndClearence])
  rotate([-90,0,0])
  screw(screwD=3.2, screwHeadD = 6.4, screwHeadThickness =outerDia/2+wallThickness);
  translate([-outerDia/2-wallThickness/2,-outerDia/2-wallThickness-screwSetThickness,length-screwEndClearence])
  rotate([-90,0,0])
  screw(screwD=3.2, screwHeadD = 6.4, screwHeadThickness =outerDia/2+wallThickness);

  translate([outerDia/2+wallThickness/2,-outerDia/2-wallThickness-screwSetThickness,screwEndClearence])
  rotate([-90,0,0])
  screw(screwD=3.2, screwHeadD = 6.4, screwHeadThickness =outerDia/2+wallThickness);
  translate([outerDia/2+wallThickness/2,-outerDia/2-wallThickness-screwSetThickness,length-screwEndClearence])
  rotate([-90,0,0])
  screw(screwD=3.2, screwHeadD = 6.4, screwHeadThickness =outerDia/2+wallThickness);
}


/* screw(screwD=3, screwHeadD = 6, screwHeadThickness =3); */
module screw(screwD = 3, screwLen=10, screwHeadD = 6, screwHeadThickness = 3)
{
  union()
  {
    /* head */
    cylinder(r=screwHeadD/2, h=screwHeadThickness);
    /* screw */
    translate([0,0,screwHeadThickness+0.2])
    cylinder(r = screwD/2, h=screwLen);

    translate([0,0,screwHeadThickness])
    intersection()
    {
      cylinder(r=screwHeadD/2,h=0.2);
      translate([0,0,0.1])
        cube([screwHeadD,screwD,0.2],center=true);
    }
  }
}


/* [ Cover Parameters ] */
// length of the long side
innerX = 305;
// length of the short side
innerY = 105;
// inner height (the height of the object to cover + extra space)
innerHeight = 6;
//
sideExtra = 2;
heightExtra = 1;

pinDia = 5.2;
pinHeight = 5;

pinCntX = 4;
pinCntY = 4;
// cut cover in half (if printbed is not big enough)
cutInHalf=false; //[true, false]

colorVar = "white";


/* [ other Parameter ] */
$fn = 80;
extra = 0.01;



module rectangularCover(x_in=100, y_in=100, z_in=5, pinCntX=3, pinCntY=3, half = false)
{
  longestX=x_in+sideExtra*2+(innerHeight*2);
  longestY=y_in+sideExtra*2+(innerHeight*2);
  echo(str("Longest X Side = ", longestX," mm"));
  echo(str("Longest Y Side = ", longestY," mm"));

  difference()
  {
    union() // rectangularCover
    {
      difference()
      {
        hull()
        {
          cube([x_in+sideExtra*2,y_in+sideExtra*2,extra]);

          translate([-innerHeight,-innerHeight,innerHeight+heightExtra-extra])
          cube([longestX,longestY,extra]);
        }

        translate([sideExtra,sideExtra,heightExtra])
        cube([x_in,y_in,z_in+extra]);
      }


      for (i=[1:pinCntX])
      {
        tempX1=(x_in+sideExtra+innerHeight)/(pinCntX-1);
        translate([tempX1*(i-1),0,0])
        translate([-(sideExtra*2-innerHeight/2),-(sideExtra*2-innerHeight/2),innerHeight+heightExtra])
        pin(pinDia,pinHeight);


        tempX2=(x_in+sideExtra+innerHeight)/(pinCntX-1);
        translate([tempX2*(i-1),y_in+sideExtra+innerHeight,0])
        translate([-(sideExtra*2-innerHeight/2),-(sideExtra*2-innerHeight/2),innerHeight+heightExtra])
        pin(pinDia,pinHeight);
      }

      for (i=[1:pinCntY])
      {
        tempY1=(y_in+sideExtra+innerHeight)/(pinCntY-1);
        translate([0,tempY1*(i-1),0])
        translate([-(sideExtra*2-innerHeight/2),-(sideExtra*2-innerHeight/2),innerHeight+heightExtra])
        pin(pinDia,pinHeight);

        tempY2=(y_in+sideExtra+innerHeight)/(pinCntY-1);
        translate([x_in+sideExtra+innerHeight,tempY2*(i-1),0])
        translate([-(sideExtra*2-innerHeight/2),-(sideExtra*2-innerHeight/2),innerHeight+heightExtra])
        pin(pinDia,pinHeight);
      }
    } //end rectangularCover

    if(half == true)
    {
      translate([-innerHeight,-innerHeight,-extra])
        cube([(longestX)/2,longestY,innerHeight+heightExtra+pinHeight+extra*2]);
    }

  }
}


module pin(pinDia=5,pinHeight=4)
{
  cylinder(r=pinDia/2,h=pinHeight-1);

  translate([0,0,pinHeight-1])
    cylinder(r1=(pinDia)/2,r2=(pinDia-2)/2,h=1);
}


color(colorVar)
rectangularCover(innerX, innerY, innerHeight, pinCntX=4, pinCntY=3, half = cutInHalf);

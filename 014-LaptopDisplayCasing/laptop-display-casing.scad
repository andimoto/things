/* laptop-display-casing.scad
Author: andimoto@posteo.de
----------------------------
*/


absDisplayX= 359;
absDisplayY= 209;
absDisplayZ= 6;




/* [ other Parameter ] */
$fn = 80;
extra = 0.015;


module LaptopDisplay(xAbs=360, yAbs=210, zAbs=5, xScreen=350, yScreen=200, zScreen=4.5)
{

  color("grey")
  difference()
  {
    cube([xAbs,yAbs,zAbs]);
    translate([(xAbs-xScreen)/2,(yAbs-yScreen)/2,-extra])
    cube([xScreen,yScreen,zAbs+extra*2]);
  }
  color("DarkSlateGray")
  translate([(xAbs-xScreen)/2,(yAbs-yScreen)/2,0])
  cube([xScreen,yScreen,zScreen]);
}



LaptopDisplay(absDisplayX);

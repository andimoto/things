/* laptop-display-casing.scad
Author: andimoto@posteo.de
----------------------------
*/
/* [ Display Dimensions ] */
// absolute Display Length ( X )
absDisplayX = 359;
// absolute Display Depth ( Y )
absDisplayY = 209;
// absolute Display Height ( Z ) (also include connector and electronic height on the back)
absDisplayZ = 6;
// length of the black screen ( x )
screenX=350;
// depth of the black screen ( y )
screenY=200;
// height of screen (should be lower than absDisplayZ as Screen is inside the absolute frame dimensions)
screenZ=4.5;
// length of the connector on the back (in x direction) (give some room for the connector; this will be also the cutout on the back)
connectorX = 35;
// length of the connector on the back (in y direction) (give some room for the connector; this will be also the cutout on the back)
connectorY = 30;
// optional: connector will be default 1mm height
connectorZ = 1;
// move the connector cutout on the back of the display in x direction
connectorXmove = 225;
// move the connector cutout on the back of the display in y direction
connectorYmove = 25;

/* [ Frame Dimensions ] */
// frame width in vertical dimension (left & right)
verticalFrameWidth = 10;
// frame width above the display
upperFrameWidth = 10;
// frame width below the display
lowerFrameWidth = 10;
// tolerance between display and frame on each side
sideClearance = 0.4;
// thickness of the back wall
backwallThickness = 2;
// inner case clearance between display back and back wall
backwallClearance = 2;
// edge radius of the case (bottom and top)
edgeRadius = 3;

/* [ other Parameter ] */
$fn = 80;
extra = 0.015;


module casingBottom()
{
  tempX=absDisplayX+sideClearance*2+verticalFrameWidth*2;
  tempY=absDisplayY+sideClearance*2+upperFrameWidth+lowerFrameWidth;
  tempZ=absDisplayZ + backwallClearance + backwallThickness;

  difference()
  {
    union()
    {
      translate([edgeRadius,edgeRadius,0])
      minkowski()
      {
        cube([tempX-edgeRadius*2,tempY-edgeRadius*2,tempZ]);
        cylinder(r=edgeRadius, h=0.00001);
      }
    }

    translate([verticalFrameWidth+sideClearance,lowerFrameWidth+sideClearance, backwallThickness])
    cube([absDisplayX+sideClearance*2,absDisplayY+sideClearance*2,absDisplayZ+backwallClearance+extra]);
  }
}

casingBottom();

module LaptopDisplay(xAbs=360, yAbs=210, zAbs=5, xScreen=350, yScreen=200, zScreen=4.5)
{
  color("grey")
  difference()
  {
    cube([xAbs,yAbs,zAbs]);
    translate([(xAbs-xScreen)/2,(yAbs-yScreen)/2,-extra*2])
    cube([xScreen,yScreen,zAbs+extra*4]);
  }
  color("Black")
  translate([(xAbs-xScreen)/2,(yAbs-yScreen)/2,1])
  cube([xScreen,yScreen,zScreen-1]);

  color("Gold")
  translate([connectorXmove,connectorYmove,0])
  cube([connectorX, connectorY, connectorZ]);
}


translate([verticalFrameWidth+sideClearance*2,lowerFrameWidth+sideClearance*2,backwallThickness+backwallClearance+extra*2])
LaptopDisplay(absDisplayX, absDisplayY, absDisplayZ, screenX, screenY, screenZ);

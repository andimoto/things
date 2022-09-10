/* brandsonVerticalBlowerCableHolder.scad
Author: andimoto@posteo.de
----------------------------
*/

$fn=150;
extra = 0.1;

dBlower = 134; //mm outer diameter
dButtonRing = 118; //mm button plate diameter
hButtonRing = 9; //mm height of button plate diameter

wallThickness = 2; //mm
remoteWidth = 40; //mm
remoteLen = 75; //mm
remoteH = 8; //mm

plugExtra = 10; //mm

difference() {
  union()
  {
    cylinder(r=dBlower/2,h=hButtonRing);
    translate([0,-remoteWidth/2-wallThickness,0]) cube([dBlower/2+remoteH,remoteWidth+wallThickness*2,hButtonRing]);

    translate([dBlower/2,-remoteWidth/2-wallThickness,0]) cube([remoteH+wallThickness*2,remoteWidth+wallThickness*2,remoteLen+plugExtra]);
  }
  /* cutout for panel ring */
  translate([0,0,-extra/2]) cylinder(r=dButtonRing/2,h=hButtonRing+extra);

  /* cutout for remote pocket */
  translate([dBlower/2+wallThickness,-remoteWidth/2,-extra]) cube([remoteH,remoteWidth,remoteLen-wallThickness]);

  /* holes for plug */
  translate([dBlower/2+remoteH/2+wallThickness,0,remoteLen])
  union()
  {
    translate([0,(2+15)/2,0]) cylinder(r=4.5/2,h=plugExtra);
    translate([0,-(2+15)/2,0]) cylinder(r=4.5/2,h=plugExtra);
  }
}

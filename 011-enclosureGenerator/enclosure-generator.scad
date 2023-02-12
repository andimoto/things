/* enclosure-system.scad
Author: andimoto@posteo.de
----------------------------

*/

include <enclosure-modules.scad>

/* [ Enclosure Parameter ] */
// length of enclosure front (x side)
enclosureX = 100;
// length of enclosure side (y side)
enclosureY = 100;
// vertical amount of beams used for enclosure (height will be beamLen * vBeamCount)
vBeamCount = 2;



/* [ Beam Parameters ] */
// length of x side of beam
beamX = 20;
// length of y side of beam
beamY = 20;
// length of beam
beamLen = 60;
// Wallthickness of the beam
beamWallThickness = 3;
// Thickness of the beam mount plates at the ends
beamMountThickness = 5;

// generate beam mount plates only on one side of beam or on both
beamMountCnt=2; // [0,1,2]
// enable mounting holes for panels
panelsMountingX = true;
// enable mounting holes for panels
panelsMountingY = true;

// amount of mounting holes on the beams
panelsMountingHolesCnt = 2;
// distance between mounting holes
mountingHolesDist = 30;

// move panel mounting holes on X side in x direction
panelHolesX_MoveX = 0;
// move panel mounting holes on X side in z direction
panelHolesX_MoveZ = 0;
// move panel mounting holes on Y side in y direction
panelHolesY_MoveY = 0;
// move panel mounting holes on Y side in z direction
panelHolesY_MoveZ = 0;

// Diameter of Nut (use most outer diamenter of the nut), for M3 Nut this is typically ~6mm
MountNutDia = 6;
// Thicknes of the Nut
MountNutThick = 3;

// completely enable or disable marker
panelMarker = true;
// overlapping of panel over beam [no marker => 0,beamX or beamY; 0 ]
panelBeamOverlappingDist = 5;

// if enabled, holes will be placed on both end of beams to fix them together with filament agains rotation
filamentFixingHoles = true;





/* [ Top Frame ] */
// length of top frame corner in x direction
topCornerXLen = 80;
// length of top frame corner in y direction
topCornerYLen = 35;
// width of the top frame elements
topFrameWidth = 25;
// overlapping of top panel over top frame
topFramePanelOverlap = 5;
// enable filament connectors on top fram to connect corners with
enableTopFrameFilamentConnect = true;
// amount of holes for panel mounting on top frame
topFramePanelHolesCnt = 2;
// distance between holes of panel mounting on top frame
topFramePanelHolesDist = 20;
// move panel holes on top frame connectors in Y direction of the connector
topFramePanelHolesMoveY = 0;



/* [ Front Panel Parameters ] */
// Panel Width
PanelFront_X = 100;
// Panel Height
PanelFront_Z = 100;
// Panel Thickness
PanelFront_Thick = 3;


/* [ Back Mounting Panel Parameters ] */
// thickness of back plate
backMountingPlateThickness = 3;
//enable mounting panels inside beams
enableInsideBeamMount = true;
// enable mounting slots in the back plate for mounting devices on it
enableMountingSlots = true;
// enable cable holes (disable if just a back plate is needed)
enableBackPlateCableHoles = true;
/* [ Side Panels ] */
// thicknes of side panels
sidePanelThickness = 2;


/* [ Show Parts ] */
// do a complete enclosure simulation
sim = false;
// show beam with current configuration
showBeam = false;
// show top corner
showTopCorner = false;
// show top connector for corners
showTopConnector = false;
// show corners and connectors completed
showCompleteTop = false;
// show panelClamp
showPanelClamp = false;
// show mounting plate of enclosure back ()
showBackPanel = false;
// show side panels on enclosure
showSidePanels = false;


/* [other Parameters and Constants] */
$fn=70;
extra = 0.01;
// filament thickness
filamentDia = 1.75;
// width of the filament connector (constant)
filaConnectorWidth = 5;


/* other vars */
tempConnectorLenX = enclosureX-topCornerXLen*2;
tempConnectorLenY = enclosureY-topCornerYLen*2;



if(showBeam == true)
{
  corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);

  translate([0,-5,0])
  mirror([0,1,0])
  rotate([0,0,0])
  corner_beam(beamX,beamY,beamLen, beamWallThickness, beamMountThickness);
}



if(showTopCorner == true)
{
  topCorner(xLen=topCornerXLen, yLen=topCornerYLen, width=topFrameWidth,thickness=beamMountThickness,
    filaConnect=enableTopFrameFilamentConnect, conThickness=3);

  translate([0,topCornerYLen*2+5,0])
  mirror([1,0,0])
  rotate([0,0,180])
  topCorner(xLen=topCornerXLen, yLen=topCornerYLen, width=topFrameWidth,thickness=beamMountThickness,
    filaConnect=enableTopFrameFilamentConnect, conThickness=3);
}


if(showTopConnector == true)
{
  echo("X Connector Length -> ",tempConnectorLenX);
  cornerConnector(xLen=tempConnectorLenX, width=topFrameWidth, thickness=5,
    filaConnect=enableTopFrameFilamentConnect, conThickness=3,
    panelHolesCnt=2,panelHolesDist=30,letter="X");

  echo("Y Connector Length -> ",tempConnectorLenY);
  translate([0,topFrameWidth+5,0])
  cornerConnector(xLen=tempConnectorLenY, width=topFrameWidth, thickness=5,
    filaConnect=enableTopFrameFilamentConnect, conThickness=3,
    panelHolesCnt=2,panelHolesDist=30,letter="Y");
}

if(showPanelClamp == true)
{
  translate([0,0,0])
  rotate([0,180,0])
  panelClamp(length=15,width=10,overlapDist=5, panelThickness=3, addClampThickness=1, holeToPanelDist=5);
}

if(showCompleteTop == true)
{
  enclosureTopFrame();
}

/* do simulation of enclosure */
if(sim == true)
{
  enclosureComplete();
}

if(showBackPanel==true)
{
  translate([beamX-topFramePanelOverlap,enclosureY,0])
  backMountingPlate(plateX=enclosureX-beamX*2+topFramePanelOverlap*2,plateH=beamLen,
      plateThick=backMountingPlateThickness,mountingSlots=enableMountingSlots,
      cableHole=enableBackPlateCableHoles);
  if(sim == true)
  {
    translate([beamX-topFramePanelOverlap,enclosureY,beamLen])
    backMountingPlate(plateX=enclosureX-beamX*2+topFramePanelOverlap*2,plateH=beamLen,
        plateThick=backMountingPlateThickness,mountingSlots=enableMountingSlots,
        cableHole=enableBackPlateCableHoles);
  }
}

if(showSidePanels==true)
{
  translate([0,beamY-topFramePanelOverlap,0])
  rotate([0,0,90])
  backMountingPlate(plateX=enclosureY-beamY*2+topFramePanelOverlap*2,plateH=beamLen,
      plateThick=sidePanelThickness,mountingSlots=false,cableHole=false);

  if(sim == true)
  {
    translate([0,beamY-topFramePanelOverlap,beamLen])
    rotate([0,0,90])
    backMountingPlate(plateX=enclosureY-beamY*2+topFramePanelOverlap*2,plateH=beamLen,
        plateThick=sidePanelThickness,mountingSlots=false,cableHole=false);

    translate([enclosureX+sidePanelThickness,beamY-topFramePanelOverlap,0])
    rotate([0,0,90])
    backMountingPlate(plateX=enclosureY-beamY*2+topFramePanelOverlap*2,plateH=beamLen,
        plateThick=sidePanelThickness,mountingSlots=false,cableHole=false);
    translate([enclosureX+sidePanelThickness,beamY-topFramePanelOverlap,beamLen])
    rotate([0,0,90])
    backMountingPlate(plateX=enclosureY-beamY*2+topFramePanelOverlap*2,plateH=beamLen,
        plateThick=sidePanelThickness,mountingSlots=false,cableHole=false);
  }
}

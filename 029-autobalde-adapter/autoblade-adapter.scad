$fn=100;
extra=0.02;

diaBladeTop = 19.6;
wall=3;
height = 20;
diaTemp=diaBladeTop+wall*2;
bladeXmov=2;

mountHoleDia = 15.65;
mountHoleDiaTol = 0.2;
mountHoleHeight = 15;

ScrewInsertM3 = 4.5;

enCarrPlate = true;
enPlateCutout = true;

//MGN9-H holes
mgn9h_b_dist = 15;
mgn9h_c_dist = 16;
carrWall = 4;
carrH = 25;
carrHoles = 3.1;
// translate([-carrWall,-diaTemp/2,0]) 
// carrPlate();
module carrPlate()
{
    difference()
    {
        hull()
        {
            translate([0,0,carrWall])
            cube([0.1,diaTemp,height+carrH-carrWall]);
            translate([carrWall-0.1,0,0]) 
            cube([0.1,diaTemp,height+carrH]);
        }
        if(enPlateCutout)
        {
            translate([0,0,height+carrH-10])
            cube([1,diaTemp,10]);
        }

        translate([0,diaTemp/2-mgn9h_b_dist/2,height+carrH-mgn9h_c_dist-5]) 
        union()
        {
            translate([-extra,0,0]) 
            rotate([0,90,0])
            cylinder(h = carrWall+extra*2, d = carrHoles);
            translate([-extra,0,mgn9h_c_dist]) 
            rotate([0,90,0])
            cylinder(h = carrWall+extra*2, d = carrHoles);
            translate([-extra,mgn9h_b_dist,mgn9h_c_dist]) 
            rotate([0,90,0])
            cylinder(h = carrWall+extra*2, d = carrHoles);
            translate([-extra,mgn9h_b_dist,0]) 
            rotate([0,90,0])
            cylinder(h = carrWall+extra*2, d = carrHoles);
        }
        translate([0,diaTemp/2,height+carrH-3]) 
        translate([-extra,0,0]) 
            rotate([0,90,0])
            cylinder(h = carrWall+extra*2, d = 2.9);
    }
}

// translate([0,diaTemp/2,0]) 
// autoblade_adapter();

module autoblade_adapter()
{
    difference()
    {
        union()
        {
            translate([bladeXmov+diaTemp/2,0,0]) 
            cylinder(d=diaBladeTop+wall*2,h=height);

            translate([0,-diaTemp/2,0]) 
            cube([diaTemp/2+bladeXmov, diaTemp, height]);

            translate([diaTemp,-8/2,0]) 
            hull()
            {
                cube([0.1,8,height]);
                translate([4,0,4]) 
                cube([0.1,8,height-8]);
            }
            if(enCarrPlate)
            {
                translate([-carrWall,-diaTemp/2,0]) 
                carrPlate();
            }
        }
        translate([0,0,mountHoleHeight]) 
        union()
        {
            translate([bladeXmov+diaTemp/2,0,extra]) 
            cylinder(d=diaBladeTop,h=height);

            translate([diaBladeTop/4-1,-diaBladeTop/2,0]) 
            cube([diaBladeTop/2+1, diaBladeTop, height+extra*2]);
        }

        translate([bladeXmov+diaTemp/2,0,-extra]) 
            cylinder(d=mountHoleDia,h=height);

        translate([bladeXmov+diaTemp/2-1-mountHoleDia/2,-4.6/2,-extra]) 
        cube([2,4.6,mountHoleHeight+extra*2]);

        translate([15,0,mountHoleHeight/2]) 
        rotate([0,90,0])
        cylinder(d=ScrewInsertM3,h=30);        
    }
}

baseWidth = 20;
lowerBorder = 5;
upperBorder = 10;
trigThick = 5;
trigWidth = 20;

bladeTopToAdapterBottom = 43;
adBtmToTip = 16; 
adBtmToReset = 12;

longSide = bladeTopToAdapterBottom + adBtmToTip;
shortSide = bladeTopToAdapterBottom + adBtmToReset;

trigHeight = longSide+upperBorder+lowerBorder;

screwHoleLoose = 3.1;

autoTrigger();
module autoTrigger()
{
    difference() 
    {
        cube([baseWidth+trigWidth,trigThick,trigHeight]);
        
        translate([0,-extra,0]) 
        hull()
        {
            translate([-extra,0,trigHeight-longSide-upperBorder]) 
            cube([0.1,trigThick+extra*2,longSide]);

            translate([trigWidth,0,trigHeight-shortSide-upperBorder]) 
            cube([0.1,trigThick+extra*2,shortSide]);
        
        }


        translate([trigWidth,0,0]) 
            autoTriggerScrewLayout();

    }
}


module autoTriggerScrewLayout()
{
    {
        #translate([baseWidth/2,-extra,lowerBorder]) 
        rotate([-90,0,0]) 
        cylinder(d=screwHoleLoose, h=trigThick+extra*2);

        translate([baseWidth/2,-extra,trigHeight/2]) 
        rotate([-90,0,0]) 
        cylinder(d=screwHoleLoose, h=trigThick+extra*2);

        translate([baseWidth/2,-extra,trigHeight-upperBorder]) 
        rotate([-90,0,0]) 
        cylinder(d=screwHoleLoose, h=trigThick+extra*2);


    }
}
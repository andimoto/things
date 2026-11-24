$fn = 80;
extra = 0.01;
case();
module case()
{
    difference() 
    {
        cube([20+4,22+4,14.6+4]);

        translate([2,2,1.6]) 
        cube([20,23,19+4]);

        translate([1+4,2+1.5,-extra]) 
        cube([13,3,4]);
        translate([2,2+1.5,0.6]) 
        cube([20,10,4]);

        translate([1,2+4.5+10.5,1.6]) 
        cube([22,2,19+4]);


        translate([2+6,2+6.5+10.5,1.6+5]) 
        cube([5,6,5]);


        translate([4,24,1.6]) 
        cube([1,2,13-1]);

        translate([19,24,1.6]) 
        cube([1,2,13-1]);

        #translate([4,25,13.6]) 
        cube([16,2,1]);


        translate([-0.15,0,14.6+4-1]) 
        rotate([-90,0,0]) 
        cylinder(h = 23+4, d=1);

        translate([20+4+0.15,0,14.6+4-1]) 
        rotate([-90,0,0]) 
        cylinder(h = 23+4, d=1);
    }

        translate([5,23,0]) 
        cube([1,2,14.6-1]);

        translate([18,23,0]) 
        cube([1,2,14.6-1]);

        // hull()
        // {
        // #translate([5,25-0.5,14.6+4-extra]) 
        // cube([14,0.5,extra]);
        // #translate([5,25-0.4,2-extra]) 
        // cube([14,0.4,extra]);
        // }
}

// translate([0,0,25]) 
// lid();
module lid()
{
    difference() 
    {
       
        translate([-1.25,0,0]) 
        cube([20+4+2+0.5,23+4,3]);

        translate([-0.25,-extra,-extra]) 
        cube([20+4+0.5,22+4,2]);
    }

    translate([-0.4,0,1]) 
    rotate([-90,0,0]) 
    cylinder(h = 23+4, d=1);

    translate([20+4+0.4,0,1]) 
    rotate([-90,0,0]) 
    cylinder(h = 23+4, d=1);
}
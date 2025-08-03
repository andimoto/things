$fn=100; 


difference() { 
    union() { 
        cylinder(d=101+4, h=30); 
        translate([0,0,29.99]) cylinder(d2=90+4,d1=101+4, h=10); 
        translate([0,0,29.98]) cylinder(d=90+4, h=30); 
        } 
        union() { 
            translate([0,0,-0.01]) cylinder(d=101, h=30.015); 
            translate([0,0,30]) cylinder(d2=90,d1=101, h=10.01); 
            translate([0,0,0]) cylinder(d=90, h=81); 
            } 
        } 
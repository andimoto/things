$fn=100; 
extra = 0.01;

// Wandstärke für kompletten Adapter
wallthickness = 2;

// Innerer Durchmesser 1. Ring
dia_Ring1 = 101;
// Höhe 1. Ring
height_Ring1 = 30;

// Höhe mittlerer Ring
height_RingMid=10;
// Innerer Druchmesser 2. Ring
dia_Ring2 = 90;
// Höhe 2. Ring
height_Ring2 = 20;

difference() { 
    union() { 
        cylinder(d=dia_Ring1+wallthickness*2, h=height_Ring1); 
        translate([0,0,height_Ring1-extra]) 
            cylinder(d2=dia_Ring2+wallthickness*2,d1=dia_Ring1+wallthickness*2, h=height_RingMid); 
        translate([0,0,height_Ring1+height_RingMid-extra*2]) 
            cylinder(d=dia_Ring2+wallthickness*2, h=height_Ring2); 
        } 
        union() { 
            translate([0,0,-extra]) cylinder(d=dia_Ring1, h=height_Ring1+extra*2); 
            translate([0,0,height_Ring1]) 
                cylinder(d2=dia_Ring2,d1=dia_Ring1, h=height_RingMid+extra); 
            translate([0,0,height_Ring1+height_RingMid-extra]) 
                cylinder(d=dia_Ring2, h=height_Ring2+extra*2); 
            } 
        } 
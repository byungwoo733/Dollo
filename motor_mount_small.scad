///////// NEED TO REDO THE MATH BECUASE OF THE SNAP ON RAILS, WELL WORTH IT

$fn = 30;
include <globals.scad>;
include <include.scad>;


frame_width = 35.5;
tail_depth = 11;
mount_max = 50+6.25+6.25;


$fn=50;

diamiter = 3.5;

module rounded_cube(width,depth,height){
    hull(){
        translate([width/2-diamiter/2,depth/2-diamiter/2,height/2-diamiter/2]) sphere(d=diamiter);
        translate([width/2-(diamiter/2),depth/2-(diamiter/2),-height/2+(diamiter/2)]) sphere(d=diamiter);
        translate([-width/2+diamiter/2,depth/2-diamiter/2,height/2-diamiter/2]) sphere(d=diamiter);
        translate([-width/2+(diamiter/2),depth/2-(diamiter/2),-height/2+(diamiter/2)]) sphere(d=diamiter);
        
        translate([width/2-diamiter/2,-depth/2+diamiter/2,height/2-diamiter/2]) sphere(d=diamiter);
        translate([width/2-(diamiter/2),-depth/2+(diamiter/2),-height/2+(diamiter/2)]) sphere(d=diamiter);
        translate([-width/2+diamiter/2,-depth/2+diamiter/2,height/2-diamiter/2]) sphere(d=diamiter);
        translate([-width/2+(diamiter/2),-depth/2+(diamiter/2),-height/2+(diamiter/2)]) sphere(d=diamiter);
    }
}    
//rounded_cube(x,y,z,diamiter);


module y_mount_added(){    
    
    translate([0,2.25-2.25,-1]) rounded_cube(depth = 50, width = frame_width+15+1, height=4, center=true);

    
    
	translate([0,frame_width-15.5,2.5]) rounded_cube(height = 5, width = 50, depth = 11, diamiter = 3.5);
//towers
	translate([0-21,-25.75,0]) cube([42,18,15+2.5+4.25]);
	translate([(32-21-4)+18/2,(11-21)+15/2,(17.5+4.25)/2]) rounded_cube(18,15,17.5+4.25);
	translate([(-21-4)+25/2,    (11-21)+15/2,(17.5+4.25)/2]) rounded_cube(25,15,17.5+4.25);
}

module y_mount_taken(){


rotate([0,0,45]) {
	translate([5.65-21,5.65-21,-10]) cylinder(d=3.5, h=70);
	translate([5.65+31-21,5.65-21,-10]) cylinder(d=3.5, h=70);
	translate([5.65-21,5.65+31-21,-10]) cylinder(d=3.5, h=70);
	translate([5.65+31-21,5.65+31-21,-10]) cylinder(d=3.5, h=70);

//counter sink
	#translate([5.65-21,5.65-21,-2]) sphere(d=6.5);
	#translate([5.65+31-21,5.65-21,-2]) sphere(d=6.5);
	#translate([5.65-21,5.65+31-21,-2]) sphere(d=6.5);
	#translate([5.65+31-21,5.65+31-21,3]) cylinder(d=6, h=20);


	translate([-70,-30,-5]) cube([50,50,50]);
	translate([-30,-70,-5]) cube([50,50,50]);

	translate([0,0,-5]) cylinder(d=23, h=20);

	#rotate([90,0,-45]) translate([-8,-3,-55+tail_depth]) male_dovetail(height=30);
	#rotate([90,0,-45]) translate([8,-3,-55+tail_depth]) male_dovetail(height=30);

	#rotate([90,0,-45]) translate([-8,-3,22-tail_depth]) male_dovetail(height=30);
	#rotate([90,0,-45]) translate([8,-3,22-tail_depth]) male_dovetail(height=30);
}

}

module motor_mount(){
	difference(){
		y_mount_added();
		y_mount_taken();
	}
}

module translated_mount(){
translate([(-obj_leg/2)-2.5,0,0]) rotate([0,90,0]) motor_mount();
}

module screw_driver(){
translated_mount();
}

rotate([0,-90,0]) difference(){
	screw_driver();
	translate([-15,0,0]) rotate([0,90,0]) union(){
		translate([5.65,5.65,-1]) cylinder(d=3.5, h=40);
		translate([5.65+31,5.65,-1]) cylinder(d=3.5, h=40);
		translate([5.65,5.65+31,-1]) cylinder(d=9, h=40);
		translate([5.65+31,5.65+31,-1]) cylinder(d=9, h=40);

		translate([-20,20,15]) rotate([90,0,45]) cylinder(h=70, d=22);
		translate([20,20,15]) rotate([90,0,-45]) cylinder(h=70, d=22);
	}
}
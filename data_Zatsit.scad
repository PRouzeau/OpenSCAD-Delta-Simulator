// Data Set for Zatsit Delta printer - 1 October 2015.
// 27 sept 2015 - add alternatives for arm length
Delta_name = "Zatsit by Zatsit.fr";
housing_base=0; // no housing
//housing_opening = 200; // defines height of the opening in the housing

beam_int_radius = 160; // radius on rod axis plane - used as reference radius
hbase = 12; // height of the base structure 
htop  = 12;  // height of top structure
htotal= 624; // total height, including base and top structure

bed_level = 9; 
extrusion = 20; // extrusion depth
$extrusionwd = 40; // extrusion width
rod_space = 0; // set two rods instead of one extrusion

car_hor_offset= 10; 
hcar = 120; 
car_vert_dist = 7.5;
top_clearance = 25; // clearance between top of the carriage and top structure

eff_hor_offset= 36; 
eff_vert_dist = 1; 
arm_space= 60; // space between the arms

delta_angle = 60; 
//arm_length = 300; // supersedes delta_angle  
mini_angle = 20; // 

hotend_vert_dist = 30;
dia_ball= 1;
dia_arm = 10;
Rail_thickness = 0; 
Rail_width =0; 
Rail_base_height=0;
frame_corner_radius=11; 
frame_face_radius= 0;
corner_offset=20;

belt_dist = 3;
spool_diam = 0;  

$bedDia=220; // force the bed diameter

struct_color = "white";
moving_color = "white";
bed_color = "silver";

//camPos=false;
// Camera distance
camVpd = 1500; 
camVpr = [80,0,42];
camVpt = [190,-67,290]; //camera translation  */


// data specific to this printer
thkCmp = 1.2;

//*
$bCar=true; // allow the program to use below module instead of standard carriage
// $ variable does not give warning when not defined
module buildCar(ht=16) { // modify to allow excentrate articulation (lowered) ??
  color ("silver")
    tsl (0,-car_hor_offset+thkCmp/2,-car_vert_dist) {
      hull () {
        cubez (arm_space,thkCmp,20);
        cubez (arm_space-10,thkCmp,-1, 0,0,-60);
      }
      cubez (arm_space-10,thkCmp,-20, 0,0,-60);
    }
} //*/

$bArm = true; // setup own arms
module buildArm (ang_hor,ang_ver){
  myarm (ang_hor,ang_ver);
  tsl (arm_space) 
    myarm (ang_hor,ang_ver,true);
}  

module myarm(ang_hor,ang_ver,right=false) {
wd = 20;  
dp = 12;  
side= (right)?1:-1;
  module pad(side, bottom=1) { // articulation pad
    difference () {
      cyly(-wd*2,thkCmp);  
      cubez (50,50,bottom*50, -side*25,0,-bottom*25);
      cubez (50,50,bottom*50);
    }  
  }
  color ("silver") {
    rotz (ang_ver) 
      pad(side);
    rot(ang_hor,0,ang_ver) {
      difference() { // arm
        cubez (wd, dp,ar_length, side*wd/2, -dp/2); 
        cubez (wd-2*thkCmp, dp,ar_length+2, side*wd/2, -dp/2-thkCmp,-1); 
        rot(20) cubez (50,50,50, 0,-25-thkCmp); 
        tsl (0,0,ar_length)
          rot(-20) cubez (50,50,-50, 0,-25-thkCmp); 
      }  
      tsl (0,0,ar_length)
        rot(-ang_hor)
          pad (side,-1);
    }  
  }    
}

$bEffector=true; // setup own effector
module buildEffector() {
  color ("silver") {
    hull()
      rot120() 
        tsl (0,0,-thkCmp/2)
          cubez(arm_space,thkCmp,thkCmp, 0,eff_hor_offset);
    rot120() 
      cubez(arm_space,thkCmp,-20, 0,eff_hor_offset);
  }  
}

//cylz (272,25,0,0,0,150); // checking enveloping cylinder
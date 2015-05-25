// Data Set for Fisher Delta printer - 25 May 2015
Delta_name = "Fisher Delta by RepRapPro";
housing_base=0; // no housing
housing_opening = 210; // defines height of the opening in the housing

beam_int_radius = 125; // radius on rod axis plane - used as reference radius
hbase = 60; // height of the base structure 
htop  = 25;  // height of top structure
htotal= 500; // total height, including base and top structure

bed_level = 5; 
extrusion = 10; // Rod diameter
rod_space = 45; // set two rods instead of one extrusion

car_hor_offset= 22; 
hcar = 16; 
car_vert_dist = 8;
top_clearance=40; // clearance between top of the carriage and top structure

eff_hor_offset= 22; 
eff_vert_dist = 4; 
arm_space= 45; // space between the arms

delta_angle = 61; 
arm_length = 166; // supersedes delta_angle  
mini_angle = 20; 
hotend_vert_dist = 12;
dia_ball= 6;
dia_arm = 5;
railthk =0; 
railwidth =0; 
rail_base=0;
frame_corner_radius=13; 
frame_face_radius= 0;
corner_offset=-35;

belt_dist= 3;
spool_diam = 0;  
spool_thk = 70;  

$bedDia=175; // force the bed diameter

struct_color = "green";
moving_color = "green";
bed_color = "silver";

$vpd=camPos?1500:$vpd;   // camera distance: work only if set outside a module
$vpr=camPos?[80,0,42]:$vpr;   // camera rotation
$vpt=camPos?[190,-67,290]:$vpt; //camera translation  */


//*
$bCar=true; // allow the program to use below module instead of standard carriage
// $ variable does not give warning when not defined
module buildCar(ht=16) { // modify to allow excentrate articulation (lowered) ??
  dcar = 19+8; // 19 is bearing diam
  tsl (0,0,-car_vert_dist) {
    hull () 
      dmirrorx()
        cylz (-dcar, ht,rod_space/2); // -x to decrease side size
    cubez (rod_space-extrusion,20,-dia_ball*1.5,0,10-car_hor_offset,dia_ball*1.5/2);
    cylx (-dia_ball*1.5,rod_space-extrusion,0,-car_hor_offset); 
  }
} //*/

$bSide = true; // setup the below side panel *in addition* to frame
module buildSide() {
  platethk = 3;
  platewd  = 200;
  platedist = 94; // internal face dist to centre
  diams  = 25;
  openht = htotal-hbase-bed_level-htop-diams-20;
  color ("black")
  //color([0.5,0.5,0.5,0.5]) 
    difference() {
      cubez (platethk, platewd, htotal,-platedist,0); 
      dmirrory()
        tsl (0,0,openht/2+hbase+bed_level+diams/2+10)
          hull() 
            dmirrorz() cylx (-diams,100,-platedist,100,openht/2);
      tsl (0,0,housing_opening/2+hbase+bed_level+diams/2)
        hull() 
          dmirrory() dmirrorz()
            cylx (-diams,100,-platedist,68-diams/2,housing_opening/2);
    }
}

/* - Corner to be developed ??
$bCorner=true;
module buildCorner() {
  ht = 10;
  difference () {
    hull () {
      dmirrorx() {
        cylz (-frame_corner_radius, ht,rod_space/2);
        tsl (rod_space/2) 
          rotz (30) 
            cubez (frame_corner_radius,frame_corner_radius,ht,0,-frame_corner_radius/2,-ht/2);
      } 
    }  
    cubez (14,8,50,0,0,-25); // belt space
    dmirrorx() // rods
    tsl (rod_space/2) {
      cylz (-extrusion,55);
      rotz (30) 
        cubez (10,50,50,15,-25,-25); 
    }
  }
} // */

//cylz (280,25,0,0,0,128); // checking enveloping cylinder
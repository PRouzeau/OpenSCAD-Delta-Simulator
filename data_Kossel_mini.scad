// Data Set for Kossel mini Delta printer - PRZ  april, 6, 2015
Delta_name = "Kossel by JC Rocholl";
housing_base=0; 
housing_opening = 200; // defines height of the opening in the housing
beam_int_radius = 144; // radius inside the columns - used as reference radius
hbase= 45; // height of the base structure (Mini Kossel = 3x extrusion)
htop = 15;  // height of top structure
htotal= 600; // total height, including base and top structure

bed_level = 5; 
extrusion = 15; // 

car_hor_offset= 19.5; 
hcar = 40; 
car_vert_dist = 8;
top_clearance=15; // clearance between top of the carriage and top structure

eff_hor_offset= 20; 
eff_vert_dist = 4; 
arm_space= 44; // space between the arms

delta_angle = 60; 
arm_length = 213.5; // supersedes delta_angle - some arms are set at 215mm
mini_angle = 27.5; // could be lower, set to have defined working diameter at 170mm
// note that reachable diameter could be larger with 20°, however Traxxas end may not be capable of required angles.

hotend_vert_dist = 40;
dia_ball= 3.6;
dia_arm = 6;
railthk =12; 
railwidth =12; 
rail_base=150;
frame_corner_radius=36; 
corner_offset=-14;
frame_face_radius= 0;

belt_dist=25;
spool_diam = 175;  
spool_thk = 60;   

$vpd=camPos?1750:$vpd;   // camera distance: work only if set outside a module
$vpr=camPos?[80,0,42]:$vpr;   // camera rotation
$vpt=camPos?[152,-90,400]:$vpt; //camera translation  */

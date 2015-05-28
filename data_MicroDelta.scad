// Data Set for Micro Delta printer - 25 May 2015
Delta_name = "Micro Delta by e-motion Tech";
housing_base=0; // no housing
housing_opening = 200; // defines height of the opening in the housing

beam_int_radius = 120; // radius of rod axis plane - used as reference radius
hbase = 20; // height of the base structure 
htop  = 60;  // height of top structure
htotal= 450; // total height, including base and top structure

bed_level = 6; 
extrusion = 8; // Rod diameter
rod_space = 45; // set two rods instead of one extrusion

car_hor_offset= 22.5; //Large for a rod type printer, as the belt is within the rods
hcar = 58; 
car_vert_dist = 29;
top_clearance=6; // clearance between top of the carriage and top structure

eff_hor_offset= 32; // Huge for a printer that size, explains low usable diameter. For ref : Kossel: 20mm, Rostock max: 33mm, Fisher Delta : ?
eff_vert_dist = 4; 
arm_space= 45; // space between the arms-value not checked - no effect on usable space 

delta_angle = 63.5;  // Value based on the arm length of 147 (as defined in the software)
arm_length = 147; // supersedes delta_angle - long arms, this is not the reason for low usable diameter - problem with traxxas angles ?   
mini_angle = 31.5; 
hotend_vert_dist = 12;
dia_ball= 5;
dia_arm = 4;
railthk =0; 
railwidth =0; 
rail_base=0;
frame_corner_radius=10; 
frame_face_radius= 0;
corner_offset=-35;

belt_dist= 1;
spool_diam = 0;  
spool_thk = 70;   

$vpd=camPos?1500:$vpd;   // camera distance: work only if set outside a module
$vpr=camPos?[80,0,42]:$vpr;   // camera rotation
$vpt=camPos?[152,-90,300]:$vpt; //camera translation  */

//cylz (265,10,0,0,0,128);
  
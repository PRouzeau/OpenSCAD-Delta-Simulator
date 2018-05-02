// Data Set for a "Tube" micro Delta printer - 7 April 2015
// The mini angle is set at 20°, using the maximum vertical travel and allowing the maximum working diameter, which impose a circular housing to clear the effector
// with 20° minimum, design angle of  62° is the maximum, with arms going vertical while the effector is aside columns
// Due to this vertical arm position, care shall be taken that the arms clear the rail and carriage offset shall be increased accordingly.
Delta_name = "Delta tube micro by PRZ";
housing_base=1; 
housing_opening = 200; // defines height of the opening in the housing
beam_int_radius = 116; // radius inside the columns - used as reference radius
hbase= 2; // height of the base structure
htop = 2;  // height of top structure
htotal= 450; // total height, including base and top structure

bed_level = 5; 
extrusion = 0; // no extrusion

car_hor_offset= 12; 
hcar = 32; 
car_vert_dist = 34;
top_clearance=25; // clearance between top of the carriage and top structure

eff_hor_offset= 14; 
eff_vert_dist = 3; 
arm_space= 30; // space between the arms

delta_angle = 62; 
arm_length = 0;  
mini_angle = 20;

hotend_vert_dist = 10;
dia_ball= 3.6;
dia_arm = 5;
Rail_thickness =8; 
Rail_width =20; 
Rail_base_height =80;
frame_corner_radius=118.5; 
corner_offset=-beam_int_radius;
frame_face_radius= 0;

belt_dist=0;
spool_diam = 175;  
spool_thk = -60;   

camVpd = 1400;  // camera distance
camVpr = [80,0,42]; // Camera rotation vector
camVpt = [152,-90,300]; //camera translation  */

 // camera distance


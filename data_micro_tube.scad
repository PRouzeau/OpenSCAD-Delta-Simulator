// Data Set for a "Tube" micro Delta printer
// The mini angle is set at 20°, using the maximum vertical travel and allowing the maximum working diameter, which impose a circular housing to clear the effector
// with 20° minimum, design angle of  62° is the maximum, with arms going vertical while the effector is aside columns
// Due to this vertical arm position, care shall be taken that the arms clear the rail and carriage offset shall be increased accordingly.

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
railthk =8; 
railwidth =20; 
rail_base=80;
frame_corner_radius=118.5; 
corner_offset=-beam_int_radius;

belt_dist=0;
spool_diam = 175;  
spool_thk = -60;   

$vpd=1400; // camera distance: work only if set outside a module
//$vpr=[67,0,29];   // camera rotation
$vpt=[152,-90,300]; //camera translation  */
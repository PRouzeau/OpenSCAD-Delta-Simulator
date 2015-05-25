// Data Set for Rostock Max Delta printer - get from publicised files
Delta_name = "Rostock Max by SeeMeeCNC"; // PRZ, April, 7, 2015
housing_base=0; 
housing_opening = 200; // defines height of the opening in the housing
beam_int_radius = 187.3; // radius inside the columns - used as reference radius
hbase= 170; // height of the base structure (here set by ATX power supply size)
htop = 55;  // height of top structure
htotal= 940; // total height, including base and top structure

bed_level = 12; 
extrusion = 25; //

car_hor_offset= 24; 
hcar = 86; 
car_vert_dist = 25;
top_clearance=15; // clearance between top of the carriage and top structure

eff_hor_offset= 33; 
eff_vert_dist = 4; 
arm_space= 50; // space between the arms

delta_angle = 60; 
arm_length = 269; // supersedes delta_angle  These arms (standard) are too short to use the advertised working diameter of 280mm without compromising effector stability. Arms of 288mm length will allow full diameter use with more reasonable mini angle (20°). however, that means that arms will go over vertical which may trouble software - to be checked - Any reach exceeding a diameter of 260mm will drive arms over vertical.
mini_angle = 15; // unusually low, to reach publicised area
hotend_vert_dist = 12;
dia_ball= 8;
dia_arm = 6;
railthk =0; 
railwidth =0; 
rail_base=0;
frame_corner_radius=100; 
frame_face_radius= 0;
corner_offset=-65;

belt_dist=0;
spool_diam = 0;  
spool_thk = 0;   

$vpd=camPos?2500:$vpd;   // camera distance: work only if set outside a module
$vpr=camPos?[80,0,42]:$vpr;   // camera rotation
$vpt=camPos?[152,-90,530]:$vpt; //camera translation 

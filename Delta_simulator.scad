// Delta structure simulator, extracted from my Delta printer design.
// This simulator could emulate any delta travels, provided the paramaters are accurate.
// Needs OpenScad 2015.03 or preferably the nightly versions (for animation).

// Play with it! you won't broke anything.

// To run the animation click [View][Animate],a panel open in the bottom right of your screen. Set 10~25 in the FPS fied and 360 in the field 'Steps'. A lower number will make larger steps. You can manipulate the view during animation. 
// OpenScad offcicial version 2015.03 have a lot of flickering during animation. This is corrected in the nightly versions, which we recommended to use.  
// Licence GPL V3.0 - Pierre ROUZEAU aka PRZ - 
// version 0.4.2 - 25 May 2015 - add twin rods in addition of extrusion - display bot name - modifs for micros deltas (Fisher delta and Micro Delta) - allow user part build for effector, corners and carriage.

// comment out below variable if you want to do a closeup view during animation
camPos = true; //if true force camera position according request in dataset
//dimensions in mm.
Delta_name = "Simulator example";
//-- Frame data ----------------------------------------------
beam_int_radius = 175; // radius inside the columns - used as reference radius
 // with rods this is the radius of the rod axis plane. 
hbase=60; // height of the base structure
htop=30;  // height of top structure
htotal=700; // total height, including base and top structure
bed_level=8; // distance between the top of the bottom structure and the top of the bed.
extrusion=20;
rod_space=0; // set two rods instead of one extrusion, diameter based on extrusion
  // if set, reference radius is rod axis plane and not extrusion face  
railthk =0; // rail thickness
railwidth =0; 
rail_base=0;

//-- Carriage data --------------------------------------------------
car_hor_offset=20; //Carriage: horizontal distance between the articulation and the internal of the columns
car_vert_dist=27;  //Carriage: vertical articulation distance/reference plane (at the top of the carriage) 
hcar=75; // carriage height - no effect on travel
dia_ball = 10; 
dia_arm  = 8;

//-- Effector data --------------------------------------
eff_hor_offset=28; //Distance effector center/articulations Kossel mini: 20, Rostock max: 33mm
eff_vert_dist = 12; //Vertical distance between the bottom of effector and the articulations axis

//-- General design data -------------------------------
arm_space=50; // space between the arms
top_clearance=5; // clearance between top of the carriage and top structure
delta_angle = 62; //key travel design: arm angle/horizontal for centered effector.
//Will only define the arm length and travels. Does not modify parts. 57~63°
//62° gives slightly longer arms and a near maximum practical usable space with vertical arms while nearing columns (if the iminimum angle is 20°). For a 3D printer, great care shall be done while installing fans which could easily conflict with columns. fan shall be installed 60° from the column and protrude on flat side.
//Reachable area is a rounded triangular shape, with the ends pointed on columns, hence the real limitation of travel is dictated by the clearance on columns. You have the option to define a rough belt simulation, which will show the conflicts - see below.

arm_length = 0; // Alternatively, you could define the arm length, which will supersedes the design angle - If too long, you will have problem with the animation (reachable area too large drive to overpass vertical for the arms). Set to 0 give priority to the angle. arm length is given axis to axis. 
 
mini_angle = 20; //minimum angle/horizontal. 20° is generally considered as the practical limit. That will not modify the design, only give you an approximate information  about the maximum possible range. The range is not really circular, but will be considered so for practical reasons. You could go below 20°, but there is no real point, because when the other arms are nearing vertical, the effector bang the columns. Also, it drive to dynamic problems (a small effector move need a large carriage move), extra loads and effector loss of stability.

hotend_vert_dist = 20;//vertical distance between hotend nozzle and effector bottom plate. depends from the effector design and hotend type.

//Frame details
frame_corner_radius=1.5*extrusion; //modify corner shape radius.
frame_face_radius=280; // radius of the face. Shall be >> overall radius. 0 is flat
corner_offset = -3; //offset center of the corner sector / beam internal radius
housing_base = 0; // if = 0 no housing shown - usually set to hbase
housing_opening = 300;
belt_dist=0; //distance between the belt and the internal of the column. (belt face at the contact point with effector). if this data is different from 0, rough belt approximation will be shown, for conflict evaluation.
spool_diam = 200; // if spool_diameter > 0, spool shown on top - vertical axis
spool_thk  = 70;

//-- Miscellaneous stuff - no influence on movement ---------------------------------
struct_color = "red";
moving_color = "deepskyblue";
bed_color = [0.5,0.5,0.5,0.5];

$vpd=camPos?2070:undef;      // camera distance: work only if set outside a module
$vpr=camPos?[80,0,42]:undef; // camera rotation
$vpt=camPos?[220,-90,420]:undef; //camera translation  */

//== data set included below will supersedes above data ===============================
//-- Uncomment the data set you want to see, else it defaults on an example -------------------------------------------
//include <data_Kossel_mini.scad> //- Data set for delta 'Kossel mini' by J.Rocholl
//include <data_Rostock_Max.scad> //- Data set for delta 'Rostock Max' by SeemeeCNC
//include <data_Tiko.scad> //-- Data set for micro delta 'Tiko' by Tiko -slow
//housing_opening=0; //uncomment this line to close the Tiko housing
//include <data_micro_tube.scad> //- Micro delta in a circular housing by PRZ -slow
//include <data_FisherDelta.scad> //- Data set for Fisher delta by RepRapPro
//include <data_MicroDelta.scad> //- Data set for Micro delta by e-Motion tech

//=====================================================================================

$fn=24; // smooth the cylinders

//-- imposing effector position (if defined, this will supersedes the animation equation)
// note that structure is rotated 30°, so x and y are rotated accordingly.
/* 
xe=100; // impose hotend x coordinate
ye=50;  // impose hotend y coordinate
ze=0; // impose hotend z coordinate */

//Alternatively, you could impose the position in polar coordinates
/*
e_radius=85;
e_angle=0;
ze=120; 
xe=e_radius*cos(e_angle);
ye=e_radius*sin(e_angle);   //*/

// if you ask for an unreachable point, arms and effector will not be displayed, without warning.

// Displayed angles are those of the arms attached to the back column
// Note that for long arms, the side angles you can see may not be acceptable for rod ends type 'traxxas', 'Igus' or equivalent and are a very limiting factor for the reachable area.

//Last parameters defines camera position at preview- comment these parameters if you want to make an animation with another position.

echo_camera();

//====================================================================
view();  //The animation will run around a cylinder based on the maximum reachable radius at the middle of the columns. If arms are sufficiently long, it will bang on columns, belts, etc.

//--- dimensions calculations --------------------------------------------------
radius_cent = beam_int_radius-eff_hor_offset-car_hor_offset;
ar_length = (arm_length)?arm_length: radius_cent/cos(delta_angle); // center to center
d_angle = acos(radius_cent/ar_length);
ht_cent = radius_cent*tan(d_angle);
working_dia =2*(ar_length*cos(mini_angle)-beam_int_radius+car_hor_offset+eff_hor_offset);  
// calculate the maximum usable height - at center - at sides
// reference plane is the base of the effector
effVtPos = hbase+bed_level+hotend_vert_dist; // height of effector base plane; 
// add the base height
carVtPos =effVtPos +(ht_cent+car_vert_dist+eff_vert_dist); //top of carriage vertical position while the head is at bed level

travel_stop = htotal-htop-top_clearance; //default some clearance for switch hysteresis and stops. This is the max position of top of carriage. - not checked by the software
working_height_cent = travel_stop-carVtPos; // considering the carriage able to go up to the plate  
rdiff = beam_int_radius-car_hor_offset-working_dia/2; // horiz dist between top and bottom articulations while at maximum radius (arms nearing vertical)
ht_side = sqrt (ar_length*ar_length-rdiff*rdiff); //Carriage height while at working radius
working_height_min = travel_stop-(effVtPos +(ht_side+car_vert_dist+eff_vert_dist));
//--- Text display ------------------------------------------
txtsize = beam_int_radius/16;
txtypos = 1.15*beam_int_radius;
txtzpos = 2.2*beam_int_radius;
txtangle= -50;

//====================================================================

module view () {//if no fixed xe,ye,ze, viewing trajectory and other stuff as a function of $t
  // Herebelow the animation sequence (it loops) - 360 steps gives a step every 2° of rotation.
  // 5 sequences: 1:flat peripheral 2:flat curve to center 3:climb up 4: curve from center sligthly down to periphery. 5: Helix down. Note that in sequence 4 carriage bang in the top structure as trajectory is on a cone, but available height is flat on the sides.
  rotz (30) Frame(); 
  if ((xe!=undef)&&(ye!=undef)&&(ze!=undef)) { 
     simul (xe,ye,ze); // arms and effector at the given xe,ye,ze values ze default to 0
     disp_text(-60,0,1.1*beam_int_radius,3*beam_int_radius); // display the data panel
  }  
  else { // arms and effector at the animated position (which depends from $t)
    hwm= working_height_min;
    hws= working_height_cent; 
  
    anim_angle=$t*720-150; // two rotations for $t 0->1 //-150 to start on left column 
    r1= working_dia/2; //$t 0 to 0.15
    r2= (0.2-$t)*20*working_dia/2; //$t 0.15 to 0.2
    r3= 0; // $t 0.2 to 0.35
    r4= ($t-0.35)*6.67*working_dia/2; //$t 0.35 to 0.5
    r5= working_dia/2; //$t 0.5 to 1 helix down
     
    h1= 0;
    h2= 0;
    h3= ($t-0.2)*6.67*hws; // hws is max vertical travel at center
    h4= hws-($t-0.35)*6.67*(hws-hwm);
    h5= (1-$t)*2*hwm;  // hwm is max vertical travel at periphery
    
    a_radius= ($t<0.15)?r1:($t<0.2)?r2:($t<0.35)?r3:($t<0.5)?r4:r5;//select sequence value
    a_height= ($t<0.15)?h1:($t<0.2)?h2:($t<0.35)?h3:($t<0.5)?h4:h5;
    
    simul (a_radius*cos(anim_angle),a_radius*sin(anim_angle),a_height);//simulate position (x,y,z) 
    disp_text(txtangle,0,txtypos,txtzpos); // display printer data on a panel aside the printer 
  } 
}

// other possible equations of movement - just for example
//-- simple helix, from top to bottom -------- 
//simul (r*cos($t*360),r*sin($t*360),max(0,working_height_min*(1-$t))); 

module simul (x, y, z=0) { //display effector and arms at a given position (note: position rotated 30°)
  delta_cal(x,y,z, 0); // first set of arm, with carriage
  delta_cal(x,y,z,120);// second set of arm, with carriage
  delta_cal(x,y,z,240);
  disp_effector(x,y,z); 
}

module delta_cal (x, y, z, rot) { // calculation of arms angles and display
// polar transformation routine
  ang=((x>0) && (y==0))?90:undef; // some fun with OpenSCAD limitations
  ang=((x<0) && (y==0))?270:undef;// create new 'variables' as they
  ang=((x==0) && (y==0))?0:undef; // cannot be reassigned
  ang2 = (ang==undef)? atan(y/x):ang; // no native function for cartesian to polar (matrix ?)
  angt=(x>=0)?ang2:180+ang2;
  rad = sqrt(x*x+y*y);    // radius from center
  xc = rad*cos(angt+rot); //for arm and carriage rotation
  yc = rad*sin(angt+rot);
  drd_plane = sqrt(pow(radius_cent-yc,2)+xc*xc);
  angsign = ((radius_cent-yc)<0)?-1:1;
  z_angle = angsign*asin(xc/drd_plane); // angle around z axis
  h_angle = angsign*asin(drd_plane/ar_length);
  vpos_car = cos(h_angle)*ar_length-ht_cent; 
  rotz (30) 
    disp_armcar(x,y,z,-rot,-h_angle,z_angle,vpos_car);
  if (rot==0) { // display angles
    txta = str("Angles: vertical: ",90-round(h_angle*10)/10, " horizontal: ", round(z_angle*10)/10);
    rot (0,-10,txtangle) 
      tsl (0, txtypos,txtzpos-txtsize*21)
         rot (90,0,90) color("black")
           textz(txta, txtsize*0.85, 2, false);
  }
}

module disp_effector(x, y, z){
  wx= arm_space-dia_ball*1.8;
  rotz (30)
    tsl(x,y,effVtPos+z) {  //addvoffset in effector module   
      color(moving_color) {
        if ($bEffector) buildEffector();   
        else { // simplified effector shape 
        if (eff_vert_dist < 10) // if articulation buried in effector, other shape    
          rot120() 
            tsl (-wx/2)
              cube([wx,eff_hor_offset+dia_ball*0.8,8]); // effector thk 8 (kossel mini)
        else  
          rotz (60) 
            intersection () { // bottom part
              cylz (arm_space +40,12, 0,0,-1,100);
              eqtrianglez (-4*eff_hor_offset-40,10);
            }
        }    
      }      
      color ("grey") {
        cylz (16, -52, 0,0,60-hotend_vert_dist);
        tsl (0,0,-hotend_vert_dist)
          cylinder (d1=4, d2=16, h=8);
      } 
      // rot120() tsl (0,35,3)rot(90) build_fan30(7);
    }   
} //disp_effector

module disp_armcar(x,y,z,i, ang_hor, ang_ver, vpos_car, car_col, arm_col) {// arms and carriage
  clear=dia_ball/5;
  thkcar = max(5+railthk, car_hor_offset-9); // car thickness
  thkarti = car_hor_offset-dia_ball/2-clear;
  zpos= z+eff_vert_dist+effVtPos;
  tsl (x,y) rotz (i) { // arms grow from effector
     // Arm creation and duplication
      tsl (-arm_space/2,eff_hor_offset,zpos){
        duplx(arm_space) {
          color("silver") 
            sphere (d=dia_ball,$fn=64); // ball
          color("grey") rot(ang_hor,0,ang_ver)
            cylz (dia_arm, ar_length-dia_ball,0,0,dia_ball/2);
        }  
        if (eff_vert_dist >=10) // ball supports
          color(moving_color)
            duplx(arm_space)
              cylz (12,-10,0,0,-1);
        else // ball axis
          color("grey") 
            cylx (dia_ball/2,arm_space);
      }
  } //rotate
  rotz (i+90) 
    tsl (beam_int_radius,0,z+carVtPos+vpos_car) 
      rotz (-90) { 
        //z: position of the nozzle
        //carVtPos: position of the carriage while nozzle is at center and z=0
        //vpos_car: carriage position difference with the position while effector centered
        color(moving_color) {
        /*  tsl (0,-clear-(car_hor_offset-3)/2, -car_vert_dist)
            cube ([arm_space+1.6*dia_ball,car_hor_offset-2*clear,1.6*dia_ball],center=true);*/
          if ($bCar) buildCar(); //$ prefixed variables are silent if not existing
          else {
            cubez (arm_space+1.6*dia_ball,thkcar,-hcar,0,-thkcar/2-clear);  
            cubez (arm_space+1.6*dia_ball,thkarti,1.6*dia_ball,0,-thkarti/2-clear,-car_vert_dist-0.8*dia_ball);    
          }  
        }
        if (rod_space) 
          color ("silver") duplx(-rod_space)
            cylz (-extrusion*1.9, extrusion*2.9,rod_space/2,0,-car_vert_dist);
        duplx(arm_space) // balls
          tsl (-arm_space/2,-car_hor_offset,-car_vert_dist)
            color("silver")
              sphere (d=dia_ball, $fn=64); 
        
      }	 
}//disp_armcar	

module Frame() { 
spool_fl = spool_thk/20;  
dec_housing = (beam_int_radius+3+extrusion)/2 + max(extrusion, railwidth)/2; 
  
  color(struct_color) {
    Frame_shape (hbase); // bottom
    Frame_shape (htop, htotal-htop); // top
    if (housing_base) // show an housing
      difference () {
        Frame_shape (htotal-housing_base, housing_base);
        Frame_shape (htotal-housing_base+2, housing_base-1, -2);
        rotz (180) // cut the opening 
          //tsl (0,0,(hbase+housing_opening)/2+10)
          hull() {
           // dmirrorx() dmirrory() 
           //   cylx(-20,1000,0,dec_housing+10,housing_opening/2);
            cylx(-20,1000,0,dec_housing+10,hbase+10);   
            cylx(-20,1000,0,500,hbase+10);   
            cylx(-20,1000,0,dec_housing+10,hbase+housing_opening-10);   
            cylx(-20,1000,0,500,hbase+housing_opening-10);   
          }
      }
  } 
  rot120(-30) { // vertical beams and rails
    // color ("black") cubez (4,200,500,-95,0);
    color("silver")      
      if (railthk) 
        cubez(railthk, railwidth, htotal-rail_base, beam_int_radius-railthk/2,0,rail_base); 
    color("DarkGray") 
      if (extrusion)
        if (rod_space)  
          dmirrory() 
            cylz (extrusion,htotal, beam_int_radius,rod_space/2);
        else  
          cubez(extrusion, extrusion, htotal, beam_int_radius+extrusion/2); 
        
    color("black")
      if (belt_dist) 
        cubez (6,14,htotal, beam_int_radius-belt_dist+3); 
    if ($bSide) buildSide(); // allow specific sides to be built
  }  
  bed_dia = $bedDia?$bedDia:working_dia*1.12;
  color(bed_color) // bed
    if (bed_level) 
      cylz (bed_dia,-3,0,0,hbase+bed_level,80);
      //cylz (180,-3,0,0,hbase+bed_level,80);
  color ("black") 
    if(spool_diam)
      tsl (0,0,htotal) {
        cylz (spool_diam, spool_fl,0,0,spool_fl,50);
        cylz (spool_diam, spool_fl,0,0,spool_thk+spool_fl,50);
        cylz (60, spool_thk,0,0,spool_fl,50);
      }
}

module Frame_shape (height, vpos=0, foffset=0) {
//corner_radius = 1.3*extrusion+frame_corner_roundness;
//int_radius= beam_int_radius-frame_corner_roundness+3;
  
  if (rod_space)
    hexagon (frame_corner_radius+foffset, rod_space, beam_int_radius, height, vpos); 
  else   
    rounded_triangle (frame_corner_radius+foffset, frame_face_radius+foffset, beam_int_radius+corner_offset, height, vpos);
}

module disp_text(angz,xpos,ypos,zpos) { // display printer data on a panel
  vtext = [
    "  Delta Simulator", 
    str("    ",Delta_name),
    "",
    str("Diam inside beams: ",round(beam_int_radius*2)),
    str("Space between arms: ",arm_space," mm"),
    str("Effector offset: ",round(eff_hor_offset*10)/10," mm"),
    str("Arm radius: ",round(radius_cent*10)/10," mm"),
    str("For design angle: ",round(d_angle*10)/10,"°"),
    str("-Arm length: ",round(ar_length*10)/10," mm"),  
    str("and mini angle: ",round(mini_angle*10)/10,"°"),
    str("-Working diam: ",round(working_dia)," mm"),
    str("For bed/ceiling: ",round(travel_stop-hbase-bed_level)," mm"),
    str("-Centre working height: ",round(working_height_cent)," mm"),
    str("-Min. working height:    ",round(working_height_min)," mm"),
    "",
    "",
    "License: GPL V3.0 - Author: PRZ"
  ];
  ltxt = len(vtext);
  rot (0,-10,angz) {
    color ("white") // panel for writing
      tsl (xpos, ypos-txtsize, zpos-(ltxt-0.2)*1.5*txtsize) 
        cube ([1,21*txtsize,(ltxt+1)*1.5*txtsize]); 
    color ("black") { // the writing on the wall
      for (i=[0:ltxt-1]) {
        txs=(i==ltxt-1)?txtsize*0.8:txtsize; // last line is smaller size (license)
        tsl (xpos, ypos, zpos-1.5*txtsize*i)
          rot (90,0,90)
            textz(vtext[i], txs, 2, (i==0));  //(i==0) bold the first line
      }
    } 
  }
} 

//======== LIBRARY (extract from the Z_utility library) =======================
//-- Operators -------------------------------------
//rotation and translations without brackets - 
module rot (x,y=0,z=0) {rotate([x,y,z]) children();}
module rotz (z) {rotate([0,0,z]) children();}
module tsl (x,y=0,z=0) {translate([x,y,z]) children();}

// for a delta, everything is rotated three times at 120°, so an operator for that 
module rot120 (a=0) {
  for(i=[0,120,240]) 
    rotate([0,0,i+a]) children();
}

module duplx (dx) { // duplicate an object at distance x
  children();
  tsl(dx) children();
}

module dmirrorx() { // duplicate and mirror on x axis
  children();
  mirror ([1,0,0]) children();
}

module dmirrory() { // duplicate and mirror on y axis
  children();
  mirror ([0,1,0]) children();
}

module dmirrorz() { // duplicate and mirror on z axis
  children();
  mirror ([0,0,1]) children();
}

//-- Primitives ------------------------------------

module textz(txt,size,h,bold) { // position text normal to z axis
  st=(bold)? "Liberation Sans:style=Bold":"Liberation Sans";
  linear_extrude(height = h) 
    text (str(txt), size, font=st);
}

module cylz (diam,height,x=0,y=0,z=0,div=$fn) { // Cylinder  on Z axis
  mv=(height<0)?height:0; 	// accept negative height	
  center=(diam<0)?true:false;	
  translate([x,y,mv+z]) 
    cylinder (d=(abs(diam)), h=abs(height), $fn=div, center=center);
}

module cylx (diam,length,x=0,y=0,z=0,div=$fn) {//Cylinder on X axis
  mv=(length<0)?length:0;	// not ok if diam AND length are negative. who cares ? 
  center=(diam<0)?true:false;	
  translate([x+mv,y,z])
    rotate([0,90,0])
      cylinder (d=(abs(diam)), h=abs(length), $fn=div, center=center);
}

module cubez(xd,yd,zd,x=0,y=0,z=0) { // centered on x anz y, not centered on z
  mz=(zd<0)?zd:0;
  tsl (x-xd/2,y-yd/2,mz+z)
    cube ([abs(xd),abs(yd),abs(zd)]);
}

module eqtrianglez (dim, length) { // dim positive defines triangle base, negative defines the external circle diameter. Centered.
  mz = (length<0)?-length:0; 
  base = (dim<0)? -dim/cos(30)*3/4: dim;
  tsl (0,0-base*cos(30)/3,mz)
    linear_extrude(height=abs(length))
      polygon(points=[[-base/2,0],[base/2,0],[0,base*cos(30)]]);		
}

module sector (diam, height, half_angle) { // cut a sector
  difference () { 
    cylinder (d=diam,h=height,$fn=120);
    rotz (-half_angle)
      tsl (-diam,0,-1)
        cube ([diam*2,diam*2,height+2]);
    rotz (half_angle)
      tsl (-diam,-diam*2,-1)
        cube ([diam*2,diam*2,height+2]);
  }  
} 

module rounded_triangle (corner_radius, face_radius, int_radius,h,hpos=0) { // triangle with rounded corners and faces. int_radius is relative to corners
fr= face_radius-corner_radius;  
cosint = int_radius*cos(30);  
face_offset = sqrt(fr*fr-cosint*cosint)-int_radius*0.5; 
ang_face = asin (cosint/fr);    
  hull() 
    rot120(-30) 
      cylz(corner_radius*2,h,int_radius,0,hpos,80);
  if (ang_face && face_offset) // just to remove warning
    rot120(-30) // not included in the 'hull()' for performance reasons
      tsl (face_offset,0,hpos) 
        difference() {
          sector (face_radius*2,h,ang_face);
          cubez(face_radius*2,face_radius*2,h+2,face_radius-face_offset,0,-1);
        }  
}

module hexagon (corner_radius, axis_space, axis_face_radius,h,hpos=0) { 
  hull() {
    rot120 (-30)
      dmirrory ()
        cylz (corner_radius*2,h,axis_face_radius,axis_space/2,hpos);
  }
}

//-- Miscellaneous -----------------------------------
module build_fan40(thk=10) { // fan 40x40: axis on z - not used yet
  color ("black")
    difference() {
      hull() 
        dmirrorx() dmirrory() cylz (3,thk,18.5,18.5);
      cylz (-37.5,50);
      dmirrorx() dmirrory() cylz (-3.2,50,16,16);
    }  
}
module build_fan30(thk=10) { // fan 40x40: axis on z - not used yet
  color ("yellow")
    difference() {
      hull() 
        dmirrorx() dmirrory() cylz (3,thk,13.5,13.5);
      cylz (-27.5,50);
      dmirrorx() dmirrory() cylz (-3.2,50,12,12);
    }  
}

//tsl (400) build_fan40();

module echo_camera () { // Echo camera variables on console
  echo ("Camera distance: ",$vpd); 
  echo ("Camera translation vector: ",$vpt);  
  echo ("Camera rotation vector: ",$vpr);
}

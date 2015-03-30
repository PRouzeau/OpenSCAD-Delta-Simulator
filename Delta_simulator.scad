// Delta structure simulator, extracted from my Delta printer design.
// This simulator could emulate any delta travels, provided the paramaters are accurate.
// Needs OpenScad 2015.03

// Play with it! you won't broke anything.

// To run the animation click [View][Animate],a panel open in the bottom right of your screen. Set 10~25 in the FPS fied and 360 in the field 'Steps'. A lower number will make larger steps. You can manipulate the view during animation. 
// Unfortunately OpenScad version 2015.03 have a lot of flickering during animation. See https://github.com/openscad/openscad/issues/1284

// Licence GPL V3.0 - Pierre ROUZEAU aka PRZ

//dimensions in mm.
//-- Frame data ----------------------------------------------
beam_int_radius = 175; // radius inside the columns - used as reference radius
hbase=60; // height of the base structure
htop=30;  // height of top structure
htotal=700; // total height, including base and top structure
bed_level=6; // distance between the top of the bottom structure and the top of the bed.
extrusion=20;

//-- Carriage data --------------------------------------------------
car_hor_offset=20; //Carriage: horizontal distance between the articulation and the internal of the columns
car_vert_dist=27; //Carriage: vertical articulation distance/reference plane (at the top of the carriage) 

//-- Effector data --------------------------------------
eff_hor_offset=28; //Distance effector center/articulations Kossel mini: 20, Rostock max: 33mm
eff_vert_dist =15; //Vertical distance between the bottom of effector and the articulations axis

//-- General design data -------------------------------
arm_space=50; // space between the arms
top_clearance=5; // clearance between top of the carriage and top structure
delta_angle = 62; //key travel design: arm angle/horizontal for centered effector.
//Will only define the arm length and travels. Does not modify parts. 57~62°
//62° gives slightly longer arms and a near maximum practical usable space with vertical arms while nearing columns. For a 3D printer, great care shall be done while installing fans which could easily conflict with columns. fan shall be installed 60° from the column and protrude on delta structure flat side.
// Note that over 62°, the arm may go over vertical, and the simulator is a bit lost with that
//Reachable area is a rounded triangular shape, with the ends pointed on columns, hence the real limitation of travel is dictated by the clearance on columns. You have the option to ask a rough belt simulation, which will show the conflicts - see below.
 
mini_angle = 20; //minimum angle/horizontal. 20° is generally considered as the practical limit. That will not modify the design, only give you an approximate information  about the maximum possible range. The range is not really circular, but will be considered so for practical reasons. You could go further this limit, but there is no real point, because when the other arms are nearing vertical, the effector bang the columns.  

hotend_vert_dist = 20;//vertical distance between hotend nozzle and effector bottom plate. depends from the effector design and hotend type. Influence vertical travel.

//-- Miscellaneous stuff - no influence on movement ---------------------------
dia_ball=10;
hcar=75; // carriage height - no effect on travel
struct_color = "red";
moving_color = "deepskyblue";
$fn=24; // smooth the cylinders surfaces

//belt_dist=25; //distance between the belt and the internal of the column. (at the contact point with effector). if this data is defined, rough belt approximation will be shown, for conflict evaluation.

//arm length is given axis to axis.

//== imposing effector position (if defined, this will supersedes the animation equation)
// note that structure is rotated 30°, so x and y are rotated accordingly.
//xe=100; // impose hotend x coordinate
//ye=50;  // impose hotend y coordinate
//ze=0; // impose hotend z coordinate, ze default to 0 if xe AND ye are defined

//Alternatively, you could impose the position in polar coordinates
/*
e_radius=85;
e_angle=0;
ze=120; 
xe=e_radius*cos(e_angle);
ye=e_radius*sin(e_angle);   //*/

// if you ask for an unreachable point, arms and effector will not be displayed, without warning.

//Next parameters defines camera position at preview- comment these parameters if you want to make an animation with another position.
$vpd=2000; // camera distance: work only if set outside a module
$vpr=[87,0,28];   // camera rotation
$vpt=[73,51,350]; //camera translation 

//====================================================================
view();  //The animation will run around a cylinder based on the maximum reachable radius at the middle of the columns. If arms are sufficiently long, it will bang on columns, belts, etc.

//--- dimensions calculations --------------------------------------------------
radius_cent = beam_int_radius-eff_hor_offset-car_hor_offset;
ht_cent = radius_cent*tan(delta_angle);
arm_length = radius_cent/cos(delta_angle); // center to center
working_dia =2*(arm_length*cos(mini_angle)-beam_int_radius+car_hor_offset+eff_hor_offset);  

// calculate the maximum usable height - at center - at sides
// reference plane is the base of the effector
effVtPos = hbase+bed_level+hotend_vert_dist; // height of effector base plane; 
// add the base height
carVtPos =effVtPos +(ht_cent+car_vert_dist+eff_vert_dist); //top of carriage vertical position while the head is at bed level

travel_stop = htotal-htop-top_clearance; //default some clearance for switch hysteresis and stops. This is the max position of top of carriage. - not checked by the software
working_height_cent = travel_stop-carVtPos; // considering the carriage able to go up to the plate  
rdiff = beam_int_radius-car_hor_offset-working_dia/2; // horiz dist between top and bottom articulations while at maximum radius (arms nearing vertical)
ht_side = sqrt (arm_length*arm_length-rdiff*rdiff); //Carriage height while at working radius
working_height_min = travel_stop-(effVtPos +(ht_side+car_vert_dist+eff_vert_dist));

//====================================================================

module view () {//if no xe,ye,ze, viewing trajectory and other stuff as a function of $t
  // Herebelow the animation sequence (it loops) - 360 steps gives a step every 2° of rotation.
  // 5 sequences: 1:Helix 2:flat peripheral 3:flat curve to center 4:climb up 5: curve from center sligthly down to periphery. Note that in sequence 5 carriage bang in the top structure as trajectory is on a cone, but available height is flat on the sides.
  rot (0,0,30) Frame(); 
  if ((xe!=undef)&&(ye!=undef)) { 
     simul (xe,ye,ze); // arms and effector at the given xe,ye,ze values ze default to 0
     disp_text(-60,0,1.1*beam_int_radius,3*beam_int_radius); // display the data panel
  }  
  else { // arms and effector at the animated position (which depends from $t)
    hwm= working_height_min;
    hws= working_height_cent; 
  
    anim_angle=$t*720-150; // two rotations for $t 0->1 //-150 to start on left column 
    r1= working_dia/2; // $t 0 to 0.5
    r2= working_dia/2; // $t 0.5 to 0.6
    r3= (0.7-$t)*10*working_dia/2; // $t 0.6 to 0.7
    r4= 0; // $t 0.7 to 0.85
    r5= ($t-0.85)*6.67*working_dia/2; // $t 0.85 to 1
    h1= (1-2*$t)*hwm; // hwm is max travel at the periphery
    h2= 0;
    h3= 0;
    h4= ($t-0.7)*6.67*hws; // $t 0.7 to 0.85
    h5= (1-$t)*6.67*(hws-hwm)+hwm; // hws is max travel at center
    a_radius= ($t<0.5)?r1:($t<0.6)?r2:($t<0.7)?r3:($t<0.85)?r4:r5; // select sequence value
    a_height= ($t<0.5)?h1:($t<0.6)?h2:($t<0.7)?h3:($t<0.85)?h4:h5;
    simul (a_radius*cos(anim_angle),a_radius*sin(anim_angle),a_height);//simulate position (x,y,z) 
    disp_text(-60,0,1.1*beam_int_radius,3*beam_int_radius); // to display printer data on a panel aside the printer 
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
// first cartesian to polar conversion as the delta is turned 30°
  ang=((x>0) && (y==0))?90:undef; // some fun with OpenSCAD limitations
  ang=((x<0) && (y==0))?270:undef;// create new 'variables' as they
  ang=((x==0) && (y==0))?0:undef; // cannot be reassigned
  ang2 = (ang==undef)? atan(y/x):ang; 
  angt=(x>=0)?ang2:180+ang2;
  rad = sqrt(x*x+y*y);    // radius from center
  xc = rad*cos(angt+rot); //for arm and carriage rotation
  yc = rad*sin(angt+rot);
  drd_plane = sqrt(pow(radius_cent-yc,2)+xc*xc);
  z_angle = asin(xc/drd_plane);
  h_angle = asin(drd_plane/arm_length);
  echo(h_angle = h_angle); // just for info of what is the angle you reach
  vpos_car = cos(h_angle)*arm_length-ht_cent; 
  rot (0,0,30) 
    disp_armcar(x,y,z,-rot,-h_angle,z_angle,vpos_car);
}

module disp_effector(x, y, z){
  diamext = 4*eff_hor_offset+40;
  diarm = arm_space +40;
  rot (0,0,30)
    tsl(x,y,effVtPos+z) {  //addvoffset in effector module   
      rot (0,0,60) 
        color(moving_color)  
          intersection () { // bottom part
            cylz (diarm,12, 0,0,-1,100);
            eqtrianglez (-diamext,10);
          }
      color ("grey") {
        cylz (16, -52, 0,0,60-hotend_vert_dist);
        tsl (0,0,-hotend_vert_dist)
          cylinder (d1=4, d2=16, h=8);
      }  
    }   
} //disp_effector

module disp_armcar(x,y,z,i, ang_hor, ang_ver, vpos_car, car_col, arm_col) {// arms and carriage
  thkcar = max(5, car_hor_offset-9);
  zpos= z+eff_vert_dist+effVtPos;
  tsl (x,y) rot (0,0,i) { // arms grow from effector
    duplx(arm_space) // Arm creation and duplication
      tsl (-arm_space/2,eff_hor_offset,zpos){
        color("silver") 
          sphere (d=dia_ball,$fn=64); // ball
        color("grey") rot(ang_hor,0,ang_ver)
          cylz (6, arm_length);
        color(moving_color)
          cylz (12,-10,0,0,-1);
      }
  } //rotate
  rot (0,0,i+90) 
    tsl (beam_int_radius,0,z+carVtPos+vpos_car) 
      rot (0,0,-90) { 
        //z: position of the nozzle
        //carVtPos: position of the carriage while nozzle is at center and z=0
        //vpos_car: delta vs position at center
        color(moving_color) {
          cubez (arm_space+15,thkcar,-hcar,0,-thkcar/2-2);  
          tsl (0,-2-(car_hor_offset-3)/2, -car_vert_dist)
            cube ([arm_space+15,car_hor_offset-4,15],center=true);
        }
        // balls
        duplx(arm_space) 
          tsl (-arm_space/2,-car_hor_offset,-car_vert_dist)
            color("silver")
              sphere (d=dia_ball, $fn=64); 
      }	 
}//disp_armcar	

module Frame() { 
diamext = 2*beam_int_radius +3*extrusion;  
  color(struct_color) {
    intersection () { // bottom part
      cylz (diamext,hbase+10, 0,0,-5,200);
      eqtrianglez (-diamext-4*extrusion, hbase);
    }
    intersection () { // top part
      cylz (diamext,htop+10, 0,0,5+htotal-htop,200);
      tsl (0,0,htotal-htop)
        eqtrianglez (-diamext-4*extrusion,htop);
    }
  } 
 // vertical beams
  rot120(-30) {
     color("silver") 
       cubez(extrusion, extrusion, htotal, beam_int_radius+extrusion/2); 
     if (belt_dist) 
        color("black") 
          cubez (6,14,htotal, beam_int_radius-belt_dist+3); 
  }  
  color([0.5,0.5,0.5,0.5]) // bed
    cylz (working_dia*1.12,-3,0,0,hbase+bed_level,80);
}


module disp_text(angz,xpos,ypos,zpos) { // display printer data on a panel
  txtsize = beam_int_radius/17;
  vtext = [
    "  3D Printer Simulator", 
    str("Diam inside beams: ",round(beam_int_radius*2)),
    str("Space between arms: ",arm_space," mm"),
    str("Effector offset: ",round(eff_hoffset())," mm"),
    str("Arm radius: ",round(radius_cent)," mm"),
    str("For design angle: ",delta_angle,"°"),
    str("-Arm length: ",round(arm_length)," mm"),
    str("-Working diam: ",round(working_dia)," mm"),
    str("-Centre working height: ",round(working_height_cent)," mm"),
    str("-Min. working height:    ",round(working_height_min)," mm"),
    "",
    "License: GPL V3.0 Author: PRZ"
  ];
  color ("white") rot (0,0,angz) // panel for writing
    tsl (xpos, ypos-txtsize, zpos-23*txtsize) 
      cube ([1,21*txtsize,26*txtsize]); 
  color ("black") rot (0,0,angz) { // the writing on the wall
    for (i=[0:len(vtext)-1]) {
      toff=(i==0)?3:0;
      tsl (xpos, ypos, zpos-1.5*txtsize*i+toff)
        rot (90,0,90)
          textz(vtext[i], txtsize, 2, (i==0)); 
    }
  } 
} 

//======== LIBRARY (extract from the Z_utility library) =======================
//-- Operators -------------------------------------
//rotation and translations without brackets - 
module rot (x,y=0,z=0) {rotate([x,y,z]) children();}
module tsl (x,y=0,z=0) {translate([x,y,z]) children();}

// for a delta, everything is rotated three times at 120°, so an operator for that 
module rot120 (a=0) {
  for(i=[0,120,240]) rotate([0,0,i+a]) children();
}

module duplx (dx) { // duplicate an object at distance x
  children();
  tsl(dx) children();
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

module cubez(xd,yd,zd,x=0,y=0,z=0) { // centered on x anz y, not centered on z
  mz=(zd<0)?zd:0;
  tsl (x-xd/2,y-yd/2,mz+z)
    cube ([abs(xd),abs(yd),abs(zd)]);
}

module eqtrianglez (dim, length) { // dim positive defines triangle base, negative defines the the external circle diameter. Centered.
  mz = (length<0)?-length:0; 
  base = (dim<0)? -dim/cos(30)*3/4: dim;
  tsl (0,0-base*cos(30)/3,mz)
    linear_extrude(height=abs(length))
      polygon(points=[[-base/2,0],[base/2,0],[0,base*cos(30)]]);		
}

include <PRZutility.scad>; // Delta effector for Chimera hotend - PRZ -June 2015
rotAng2 = 90;
rotAng3 = 180;


arm_space=45;
dia_ball=8;
function eff_hoffset() = 34;

effvoffset = 0; //effector vertical articulation (ball center) offset from bottom effector plane (positive->up) 

ep_duct = 1.6; // duct thickness (not used everywhere)

//adapted for different hotend
//duct_ext=15; //low extension of the duct;

hotsup_attach_rd = 26; // radius of the support bolt - nota: Rostock: 25
// duct parameters

diamNutM3 = 6;
hotend_offset = 6;
hotend_dist = 17;
top_plane =38;

$fn=34;

if (!assemble) { // shall not be executed from assemble.scad
  //color ("deepskyblue")
  //rot (180) 
  chimera_eff ();
  acc();
  echo ("effector offset: ",eff_hoffset());
}

// duct param : width (y), depth (x), offset x, offset y, z pos, radius, angle 
duct_par = [
  [31.5,31.5 ,-5   ,0,30.5 ,15 ,0],
  [37.5,27.25,-4.75,0,14.25,7  ,0], //intermediate couple to decrease locally skin thickness
  [44  ,23   ,-4.5 ,0,-1.5 ,7  ,5],
  [45.5 ,21  ,-4   ,0,-5   ,6.5,9],
  [46.75,18.2,-2.65,0,-8.2 ,5.5,13],
  [47.5,15.5 ,-1   ,0,-11  ,5  ,15],
  [48  ,12.5 , 1.75,0,-14  ,4.5,17],
  [48  ,10   ,5    ,0,-16.25,4 ,23]
]; 

duct_par2 = [
  [31.5,31.5,-5,0,30.5 ,1 ,0],
  [44,23,-4.5  ,0,-1.5 ,7 ,5]
];

module acc() {
   // accessories viewing
    tsl (-15,0,top_plane) // part fan
      build_fan(30,10);
    tsl (19,0,top_plane-15) // hotend fan
      rot(0,90) build_fan(30,10);

    color("silver") {
      tsl (10,0,23)
        rot(90,0,90) import ("Chimera4.STL");
      
      tsl (0,0,0)
        rot120(-30) {
          cylx (-3,arm_space,0,eff_hoffset(), axis_pos);
          dmirrorx() 
             tsl (arm_space/2,eff_hoffset(), axis_pos) {
               sphere(4);
               rot (0,-15) cylz (6,100);
               rot (0,15) cylz (6,100);
             }  
        } 
    }  
    //cubez (20,50,50, -12,5,40); test for centrifugal fan
    *cubez (100,100,1,0,0,-13); // build plate ??
}


module chimera_eff () {
  guspos =14; // side offset of gusset - could be adjusted to cope with different arm space
 
  module gusset(spos=1) {
    rotz(-12.5*spos)
      tsl (spos*2,-21,top_plane-1)
        hull () {  // reinforcment junction
          cubez(43,2.8,1); 
          rotz(spos*3.4)
          cubez(38,2.5,1,spos*-3,-3,-10); 
          cylz(2,1,0,5,0);
          cylz(2,1,0,3,-10);
        }
    tsl (0,eff_hoffset()+1,2) {
      hull() {  //plate between reclined pole
        cubez(2,2,1,spos*2,-6.23,35); 
        cubez(30,2,1); 
      }  
    }
    hull() { // part of 'folded' plate
       cubez(2,2,1,spos*10,10.5,top_plane-1);
       cubez(2.5,1,1,spos*guspos,eff_hoffset()-2,effvoffset-4.5);
       cylx (-1 ,2.5,spos*guspos,eff_hoffset()-20,effvoffset-4.5); 
    }
    hull() { // 2nd part of 'folded' plate
       cylz(3,1,spos*2.2,eff_hoffset()-5.2,37);
       cubez(2,2,1,spos*10,10.5,37);
       cubez (2.5,1,1,spos*guspos,eff_hoffset()+4.5,effvoffset); 
    }
    hull() { // central part of 'folded' plate
       cubez(2,2,1,spos*10,10.5,37);
       cylx (-10,2.5,spos*guspos,eff_hoffset(),effvoffset); 
    }
  }
  
  module gusset2(spos=1) { // fan side gussets
    hull() {
       cylx (-10,2.5,spos*guspos,eff_hoffset(),effvoffset); 
       cylx (-1 ,2.5,spos*guspos,14,effvoffset-6); 
       cylx (-1 ,2.5,spos*guspos,24,36); 
    }
  }
  module gusset3(spos) { // linked gussets
    hull() {
      cylx (-10,2.5,spos*guspos,eff_hoffset(),effvoffset);
      cylz (3,1, spos*-2.3,eff_hoffset()-5.25, 37);
      //cubez (2.5,2,1, spos*-2.3,eff_hoffset()-5.25,-effvoffset+33);
    }
  }
 
  difference() {
    union() {
      cubez(3,45,9.5,29,0,-4.5+effvoffset); // linking bar
      cubez (5,31,30.5,-1.5,0,7.5); // hotend back plate
      tsl (-10,0,8){
        nDuct(duct_par); // Duct
        nDuct(duct_par2); // envelope duct for fan holes and other attach
      }
      //*
      rotz (90)  //duct side gussets
        dmirrorx() gusset2();
      rotz (210) { 
        gusset();
        gusset3(-1);
      }  
      rotz (330) {
        gusset(-1);
        gusset3(1);
      }
      rot120(90) {
        cylx (-7.5,arm_space-14,0,eff_hoffset(),effvoffset);  // articulation axis
        dmirrorx() 
          tsl (guspos,eff_hoffset(),effvoffset) 
            dmirrorx() 
              tsl (1.2) 
                rot(0,90)  
                  cylinder (d2=5, d1=10, h=2.5);
      } // */
    } // now whats removed
    tsl (-10,0,8) 
      nDuct(duct_par, ep_duct); // duct internal
    rot120(90) 
      cylx (-3,55,0,eff_hoffset(),effvoffset); // articulations holes
    cylx (-3,22,0,0,top_plane-20); // hotend fixation
    cylx (8,5,-7.5,0,top_plane-20);
    dmirrory() { 
      cylx (-3,22,0,4.5,top_plane-10); // hotend fixation
      cylx (8,5,-6.5,4.5,top_plane-10); // hotend fixation head space
      cylx (-3,66,-15,8.5,top_plane-19); // height adjust hole - no data on hole height ??
      cylx (-3,66,-15,8.5,top_plane-28); // height adjust hole - no data on hole height ??
    }
    tsl (-15,0,top_plane) // top fan fixation holes
      quadz (12,12)
        cylz (-2.5,9);
  }
}

module nDuct(duct_param, ep=0) {
  //rcubez (radius,length,x,y,z=0)
  lv = len(duct_param);  
  //echo (lv=lv);
  //hull()
  for (i=[0:lv-2]) {
    hull() {
      tsl (duct_param [i][2],duct_param [i][3],duct_param[i][4]-1)
        rot(0,-duct_param[i][6])
          rcubez (duct_param[i][5]-ep,0.5+ep/20,duct_param[i][1]-2*ep,duct_param[i][0]-2*ep);
      tsl (duct_param [i+1][2],duct_param [i+1][3],duct_param[i+1][4]-1-ep/20)
        rot(0,-duct_param[i+1][6])
          rcubez (duct_param[i+1][5]-ep,0.5,duct_param[i+1][1]-2*ep,duct_param[i+1][0]-2*ep);
    }
  }
}


module build_fan(size=40, thk=6) { //~ok for 25,30,40,60,80,120. Not ok for 92
  holesp = size==120?52.5:size==80?35.75:size==60?25:0.4*size;
  color ("black") {
    difference() {
      hull() 
        dmirrorx() dmirrory() cylz (2,thk,size/2-1,size/2-1);
      cylz (-size *0.95,55);
      dmirrorx() dmirrory() cylz (-(size*0.03+2),55,holesp,holesp);
    }
    cylz (12+size/8, thk-1,0,0,0.5);
  }  
}  

module rot120 (a=0) {
  for(i=[0,rotAng2,rotAng3])  // rotation angles could be redefined for 'square' delta
    rotate([0,0,i+a]) children();
}


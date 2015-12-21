// Data Set for Openbuilds Delta-Six, designed by Sage
Delta_name = "Delta-Six by Sage"; // Geodave 810, October, 2015 - adaptation and mods by PRZ noted by !!
// See http://www.openbuilds.com/builds/delta-six.476 for files

$bAllFrame = true; // replace frame by following routine - no need to modify the simulator program
module  buildAllFrame() { DrawFinal();}  //run by the simulator in 'simul' module
*DrawFinal(); // use for development only

//******* -- beam_int_radius = frame_rad - 10; //Main routine complains if not a constant
//beam_int_radius=193.204;     //for 300mm length horizontals
//beam_int_radius=308.674;        //for 500mm length horizontals
beam_int_radius=236.506;        //for 375mm length horizontals
//beam_int_radius = 308.674;
//echo("beam_int_radius = ",beam_int_radius);

//beam_int_radius = 187.3; // radius inside the columns - used as reference radius
//beam_int_radius=236.38;     //for 375mm length horizontals
//beam_int_radius=308.67;     //for 500mm length horizontals
//beam_int_radius =20;
hbase= 46; //!! height of the base structure 
htop = 40;  //!! height of top structure
htotal= 800; //!! total height, including base and top structure. This variable shall be used by the below program to have true vertical travels
housing_base=0; 
bed_level = 10;  // !!

extrusion = 0; //!! Neutralise original extrusion drawing
$bedDia=1; //!! neutralise original bed

car_hor_offset= 15;  //!! from Scad files for Traxxas links - Offset for mag links is higher
hcar = 86; 
car_vert_dist = 25;
top_clearance=15; // clearance between top of the carriage and top structure

eff_hor_offset= 37;  //!! as defined in SCAD file
eff_vert_dist = 4; 
arm_space= 55; //!! space between the arms, as defined in configuration file 
//delta_angle = 60; 
arm_length = 340; // supersedes delta_angle  
mini_angle = 20; // !! Not defined in original description, but comply with bed size as shown
hotend_vert_dist = 12;
dia_ball= 8;
dia_arm = 6;
frame_corner_radius=100; 
frame_face_radius= 0;
corner_offset=-65;

belt_dist=18; //!! added to check conflicts with effector
spool_diam = 0;  
spool_thk = 0;   

$vpd=camPos?2900:$vpd;   //!! camera distance: work only if set outside a module
$vpr=camPos?[80,0,42]:$vpr;   //!! camera rotation
$vpt=camPos?[152,-90,530]:$vpt; //!! camera translation 
//frame_color = [0.7,0.25,0.7,0.98];
//plate_color = [0.7,0.7,1.0,0.5];
//rod_color=[0.1,0.1,0.1,0.88];
//v_slot_color="silver";
//include <DeltaFrame375_1000.scad>
/////////////////////////////////////////////////////////
//*** Pasted DeltaFrame375_1000.scad here ****
/////////////////////////////////////////////////////////
//========================================================
Frame_Ext_Len = 375;    //Length of Horizontal Aluminum extrusions
Frame_Ext_Ht = htotal;  //!! length of extrusions for towers, need cut length
Frame_Ext_Wid = 20;     //Width of extrusions
//Delta_Ang_1st = 30.77;  //Angle to use for Arms for Calculating Initial Arm Length
Frame_Motor_Ht = 41;    //height of motor from vertex (Change to 40 or 41 for 2040, 80 for 2080, etc)
Frame_Top_Ht = 41;      //Height of Top Vertices (Change to 40 or 41 for 2040, 80 for 2080, etc)
Alum_BaseThk = 6;      //Thickness of Base below 1st extrusion (Will Decrease Build Height)

//****These 14 variables are for 1x 2020 Bottom, Top Horizontal & Vertical extrusions
//Alum_BaseHorWid = 20;       //Size of Extrusions to use for Base
//Alum_BaseHor_Z = 10;         //10 for 2020, 30 for 2040, 50 for 2060 & 70 for 2080
//Alum_BaseGap = 0;           //Gap between extrusions
//Alum_BaseQty = 1;           //How many Extrusions on Base
//Alum_TopHorWid = 20;        //Top Size of Extrusions to use for Top
//Alum_TopHor_Z = 10;         //10 for 2020, 30 for 2040, 50 for 2060 & 70 for 2080
//Alum_TopGap = 0;            //Gap between extrusions
//Alum_TopQty = 1;            //How many Extrusions on Base
//Printer_Xadd = 44.34;       //2020 Vertical For Calculating X overall dimension of Printer
//Alum_VertWid = 20;          //use 20, 40, 60 or 80 for Vertical Extrusions
//Alum_VertGap = 0;           //Gap between Top extrusions (only used when Alum_TopQty = 2)
//Alum_VertQty = 1;           //How many vertical Extrusions at each Vertex
//Vertex_X_offset = 20.98;    //X Offset from end of 2020 Alum. Horizontal to Center of Vertical
//Vertex_Y_offset = 16.34;    //Y Offset from end of 2020 Alum. Horizontal to Center of Vertical

//****These 14 variables are for 2x 2020 Bottom, Top Horizontal & 2x Vertical extrusions
//Alum_BaseHorWid = 20;       //Size of Extrusions to use for Base
//Alum_BaseHor_Z = 10;        //10 for 2020, 30 for 2040, 50 for 2060 & 70 for 2080
//Alum_BaseGap = 20;          //Gap between Bottom extrusions (only used when Alum_BaseQty = 2)
//Alum_BaseQty = 2;           //How many Extrusions on Base
//Alum_TopHorWid = 20;        //Top Size of Extrusions to use for Top
//Alum_TopHor_Z = 10;         //10 for 2020, 30 for 2040, 50 for 2060 & 70 for 2080
//Alum_TopGap = 20;           //Gap between Top extrusions (only used when Alum_VertQty = 2)
//Alum_TopQty = 1;            //How many Extrusions at Top
//Printer_Xadd = 44.34;       //2020 Vertical For Calculating X overall dimension of Printer
//Alum_VertWid = 20;          //use 20, 40, 60 or 80 for Vertical Extrusions
//Alum_VertGap = 20;          //Gap between Top extrusions (only used when Alum_TopQty = 2)
//Alum_VertQty = 2;           //How many vertical Extrusions at each Vertex
//Vertex_X_offset = 20.98;    //X Offset from end of 2060 Alum. Horizontal to Center of Vertical
//Vertex_Y_offset = 16.34;    //Y Offset from end of 2060 Alum. Horizontal to Center of Vertical

//****These 14 variables are for 1x 2040 Bottom, Top Horizontal & Vertical extrusionsf
Alum_BaseHorWid = 40;       //Size of Extrusions to use for Base
Alum_BaseHor_Z = 30;        //10 for 2020, 30 for 2040, 50 for 2060 & 70 for 2080
Alum_BaseGap = 0;           //Gap between extrusions
Alum_BaseQty = 1;           //How many Extrusions on Base
Alum_TopHorWid = 40;        //Size of Extrusions to use for Top
Alum_TopHor_Z = 30;         //10 for 2020, 30 for 2040, 50 for 2060 & 70 for 2080
Alum_TopGap = 0;            //Gap between extrusions
Alum_TopQty = 1;            //How many Extrusions at Top
Printer_Xadd = 54.34;       //2040 Vertical For Calculating X overall dimension of Printer
Alum_VertWid = 40;          //use 20, 40, 60 or 80 for Vertical Extrusions
Alum_VertGap = 0;           //Gap between Top extrusions (only used when Alum_TopQty = 2)
Alum_VertQty = 1;           //How many vertical Extrusions at each Vertex
Vertex_X_offset = 25.98;    //X Offset from end of 2040 Alum. Horizontal to Center of Vertical
Vertex_Y_offset = 25.0;     //Y Offset from end of 2040 Alum. Horizontal to Center of Vertical

//****These 14 variables are for 1x 2060 Bottom, Top Horizontal & Vertical extrusions
//Alum_BaseHorWid = 60;       //Size of Extrusions to use for Base
//Alum_BaseHor_Z = 50;         //10 for 2020, 30 for 2040, 50 for 2060 & 70 for 2080
//Alum_BaseGap = 0;           //Gap between extrusions
//Alum_BaseQty = 1;           //How many Extrusions on Base
//Alum_TopHorWid = 60;        //Size of Extrusions to use for Top
//Alum_TopHor_Z = 50;         //10 for 2020, 30 for 2040, 50 for 2060 & 70 for 2080
//Alum_TopGap = 0;            //Gap between extrusions
//Alum_TopQty = 1;            //How many Extrusions at Top
//Printer_Xadd = 64.4;        //2060 Vertical For Calculating X overall dimension of Printer
//Alum_VertWid = 60;          //use 40, 60 or 80 for Vertical Extrusions
//Alum_VertGap = 0;           //Gap between Top extrusions (only used when Alum_TopQty = 2)
//Alum_VertQty = 1;           //How many vertical Extrusions at each Vertex
//Vertex_X_offset = 31.01;    //X Offset from end of 2060 Alum. Horizontal to Center of Vertical
//Vertex_Y_offset = 33.71;    //Y Offset from end of 2060 Alum. Horizontal to Center of Vertical

//****These 14 variables are for 1x 2080 Bottom, Top Horizontal & Vertical extrusions
//Alum_BaseHorWid = 80;       //Size of Extrusions to use for Base
//Alum_BaseHor_Z = 70;        //10 for 2020, 30 for 2040, 50 for 2060 & 70 for 2080
//Alum_BaseGap = 0;           //Gap between extrusions
//Alum_BaseQty = 1;           //How many Extrusions on Base
//Alum_TopHorWid = 80;        //Size of Extrusions to use for Top
//Alum_TopHor_Z = 70;         //10 for 2020, 30 for 2040, 50 for 2060 & 70 for 2080
//Alum_TopGap = 0;            //Gap between extrusions
//Alum_TopQty = 1;            //How many Extrusions at Top
//Printer_Xadd = 74.4;        //2080 Vertical For Calculating X overall dimension of Printer
//Alum_VertWid = 80;          //use 40, 60 or 60 for Vertical Extrusions
//Alum_VertGap = 0;           //Gap between Top extrusions (only used when Alum_TopQty = 2)
//Alum_VertQty = 1;           //How many vertical Extrusions at each Vertex
//Vertex_X_offset = 36.01;    //X Offset from end of Alum. Horizontal to Center of Vertical
//Vertex_Y_offset = 42.37;    //Y Offset from end of Alum. Horizontal to Center of Vertical

//This seems to be center of vertical to corner of where horizontals meet, (not sure I need this)
//vertex_offset = 50.22;    //For 2020 size Vertical
//This seems to be center of vertical to corner of where horizontals meet, (not sure I need this)
//vertex_offset = 50;       //For 2040 size Vertical
//This seems to be center of vertical to corner of where horizontals meet, (not sure I need this)
//vertex_offset = 67.43;    //For 2060 size Vertical (2x 2020 with 20mm gap)
//This seems to be center of vertical to corner of where horizontals meet, (not sure it is needed)
//vertex_offset = 67.43;    //For 2060 size Vertical
//This seems to be center of vertical to corner of where horizontals meet, (not sure I need this)
//vertex_offset = 84.75;    //For 2080 size Vertical
Glass_Z_Offset = 4;     //Offset of Glass above Frame
Glass_Thk = 3;          //Glass Thickness
//========================================================
M5 = 5.5;                     //Hole Diameter
HoleRes = 24;                 //Resolution of small Holes
sin60 = 0.866025;
cos60 = 0.5;

explode = 0.0;   // set > 0.0 to push the parts apart (***Not implemented yet)

//These 2 variables are the same for any of the 2020, 2040, 2060 or 2080 extrusions
//Car_OriginOffset_Y = 12;        //Origin Offset of Carriages from Centerline of Vertical Extrusion
//CarHorOff = 24;      //Offset from Center line of Vertical Aluminums to Centerline of carriage arm connector
//CarVerOff = 76.36 + (Frame_Top_Ht - 40);       //Offset from Top of Frame to Centerline of carriage arm connector
//echo("CarVerOff = ", CarVerOff);
//Ef_Off = 37;            //horizontal distance from center to pivot

//Eff_Half = Eff_Ht / 2;

//Calculate total Width of Verticals so we know which vertex to use
Alum_VertTopWid = Alum_VertWid * Alum_VertQty + Alum_VertGap;
//echo("Alum_VertTopWid = ", Alum_VertTopWid);
//distance from center to center of Vertical extrusion & also origin of Vertex Plastic Part
//This is the Delta Radius
frame_rad = ((Frame_Ext_Len / 2) + Vertex_X_offset) / sin60;
echo("frame_rad = ",frame_rad);

//15.23 is distance from Centerline of Vertical extrusion to outside edge of Plastic Vertex
//Printer_Y = (frame_rad * 2) + (15.23 * 2);
//Printer_X = (Printer_Xadd * 2) + Frame_Ext_Len;       //Overall X Dimension of Printer
//Print_Radius = frame_rad - (Frame_Ext_Wid / 2);
//Arm_HorDist = frame_rad - Ef_Off - CarHorOff;
//echo("****Arm_HorDist = ",Arm_HorDist);
//Arm_Len = Arm_HorDist / sin(Delta_Ang_1st);         //Arm length based on Delta_Ang_1st
//echo("Arm_Len = ",Arm_Len);                //Display calculated length based on orginal Delta_Angle
//I had to use a temporary variable for Angle initially, since openscad does not seem to like me
//redefining that variable after it was used
//This allows user to change either the angle or the length of the arms
//=========================================
//=== Change Arm Length Variable Here =====
//=========================================
//DELTA_DIAGONAL_ROD = Arm_Len;                   //Change this to what length you want
//DELTA_DIAGONAL_ROD = 288;
//DELTA_DIAGONAL_ROD = 250;
//echo("DELTA_DIAGONAL_ROD = ",DELTA_DIAGONAL_ROD);
//Re calculate Delta Angle & Vertical distance in case Arm Length was changed
//Delta_Ang = asin(Arm_HorDist / DELTA_DIAGONAL_ROD);
//echo("Delta_Ang = ",Delta_Ang);
//echo("6x Horizontal Extrusions = ",Frame_Ext_Len,"mm");
//echo("3x Vertical Extrusions = ",Frame_Ext_Ht,"mm");
//Arm_VerDist = Arm_HorDist / tan(Delta_Ang);
//RotRod = -Delta_Ang;
//RotRod_Y = RotRod;
//RotRod_X = RotRod;
//RotRod_Z = RotRod;
//
//Rod_X = 30.5;                     //X offset of diagonal Arms
//Rod_Y = 37;                       //Y offset from Center of effector
//Eff_Top_Offset = Frame_Ext_Ht - (Arm_VerDist + CarVerOff + Eff_Half);
//Hot_End_Z = (Eff_Top_Offset + Eff_Ht) - HotEnd_Ht;
//echo("Frame_Ext_Ht",Frame_Ext_Ht);
//echo("Arm_VerDist",Arm_VerDist);
//echo("CarVerOff",CarVerOff);
//echo("Eff_Half",Eff_Half);
//echo("Eff_Top_Offset",Eff_Top_Offset);
//**Eff_Top_Offset is off


//echo("=========Hot_End_Z = ",Hot_End_Z);
//echo("Frame_Ext_Ht = ",Frame_Ext_Ht);
//echo("Arm_VerDist = ",Arm_VerDist);
//echo("CarVerOff = ",CarVerOff);
//echo("Eff_Half = ",Eff_Half);
//echo("Eff_Top_Offset = ",Eff_Top_Offset);
//echo("asin(.511) = ",asin(0.5115816007));
//echo("*********************************");
Glass_Ht = Frame_Motor_Ht + Alum_BaseThk + Glass_Z_Offset;
//endstop_Ht = 55;                //Height of extrusion should be this number
//carriage_length = 50.7/2;       //half Length of Carriage along the Z axis
//calc_carriage_Ht = Frame_Ext_Ht - (Frame_Top_Ht - 40) - carriage_length - endstop_Ht;
//echo("calc_carriage_Ht = ",calc_carriage_Ht);
//calc_carriage_Ht = 668.65 - 339.7;      //Original Height - build Height
//calc_carriage_Z = calc_carriage_Ht;
//calc_carriage_X = calc_carriage_Ht;
//calc_carriage_Y = calc_carriage_Ht;
//
//Calc_Endstop_z = Frame_Ext_Ht - endstop_Ht;


Frame_half = Frame_Ext_Len / 2;
echo("Frame_half = ", Frame_half);
Len=Frame_half+Vertex_X_offset;
//echo("Len = ",Len);

frame_top = Frame_Ext_Ht - 20 + explode; 

Len=Frame_half+Vertex_X_offset;
frame_r1 = Len / sin60;                 //Distance from Center to Center of Vertical Extrusions
//echo("frame_r1 = ",frame_r1);
Y_Vertex = frame_r1 / 2;                //Y offset from center to insert Vertices
//echo("Y_Vertex = ",Y_Vertex);
Alum_Y = Y_Vertex + Vertex_Y_offset;    //Y offset from center to insert horizontal extrusions
echo("Alum_Y = ",Alum_Y);
BedRad = Alum_Y - 10;
echo("BedRad =",BedRad);
frame_color = [0.7,0.25,0.7,0.98];
plate_color = [0.7,0.7,1.0,0.5];
rod_color=[0.1,0.1,0.1,0.88];
v_slot_color="silver";

module DrawHorizontalAlumFrame()
{
    V_Slot_H();
    rotate([0,0,120])
    V_Slot_H();
    rotate([0,0,-120])
    V_Slot_H();
}
module DrawHorBaseAlumFrame()
{
    V_Slot_H(Alum_BaseHorWid,Alum_BaseHor_Z + Alum_BaseThk);
    rotate([0,0,120])
    V_Slot_H(Alum_BaseHorWid,Alum_BaseHor_Z + Alum_BaseThk);
    rotate([0,0,-120])
    V_Slot_H(Alum_BaseHorWid,Alum_BaseHor_Z + Alum_BaseThk);
}
module DrawHorTopAlumFrame()
{
    V_Slot_H(Alum_TopHorWid,Alum_TopHor_Z);
    rotate([0,0,120])
    V_Slot_H(Alum_TopHorWid,Alum_TopHor_Z);
    rotate([0,0,-120])
    V_Slot_H(Alum_TopHorWid,Alum_TopHor_Z);
}
module V_Slot_H(Htype = Alum_BaseHorWid,Z_Ht = Alum_BaseHor_Z)
{
    if (Htype == 20)
    {
        translate([-Frame_half,-Alum_Y,Z_Ht])
        rotate([0,90,0])
        V_Slot_20x20(Frame_Ext_Len);
    }
    if (Htype == 40)
    {
        translate([-Frame_half,-Alum_Y,Z_Ht])
        rotate([0,90,0])
        V_Slot_20x40(Frame_Ext_Len);
    }
    if (Htype == 60)
    {
        translate([-Frame_half,-Alum_Y,Z_Ht])
        rotate([0,90,0])
        V_Slot_20x60(Frame_Ext_Len);
    }
    if (Htype == 80)
    {
        translate([-Frame_half,-Alum_Y,Z_Ht])
        rotate([0,90,0])
        V_Slot_20x80(Frame_Ext_Len);
    }
}
module Vertex_Motor()
{
    if (Alum_VertTopWid == 20)
    {
        Vertex2020_Motor(Frame_Motor_Ht);        //Draw 1st, 2nd and 3rd bottom Vertex
    }
    if (Alum_VertTopWid == 40)
    {
        Vertex2040_Motor(Frame_Motor_Ht);        //Draw 1st, 2nd and 3rd bottom Vertex
    }
    if (Alum_VertTopWid == 60)
    {
        Vertex2060_Motor(Frame_Motor_Ht);        //Draw 1st, 2nd, and 3rd bottom Vertex
    }
    if (Alum_VertTopWid == 80)
    {
        Vertex2080_Motor(Frame_Motor_Ht);        //Draw 1st, 2nd, and 3rd bottom Vertex
    }
}
module VertexTop(Ht_V=Frame_Top_Ht)
{
    if (Alum_VertTopWid == 20)
    {
        Vtex2020(Ht_V);        //Draw 1st, 2nd and 3rd bottom Vertex
    }
    if (Alum_VertTopWid == 40)
    {
        Vtex2040(Ht_V);        //Draw 1st, 2nd and 3rd bottom Vertex
    }
    if (Alum_VertTopWid == 60)
    {
        Vtex2060(Ht_V);        //Draw 1st, 2nd, and 3rd bottom Vertex
    }
    if (Alum_VertTopWid == 80)
    {
        Vtex2080(Ht_V);        //Draw 1st, 2nd, and 3rd bottom Vertex
    }
}

//Vertex2040_Motor(Frame_Motor_Ht + Alum_BaseThk);
module Vertex2040_Motor(Ht_V=Frame_Motor_Ht)
{
    if (Alum_BaseThk == 0)
    {
        Vtex2040(Ht_V);
    } else {
        difference()
        {
            union()
            {
                Vtex2040(Ht_V);
                translate([0,0,-Alum_BaseThk])
                linear_extrude(height = Alum_BaseThk, center = false, convexity = 10)polygon(points = 
                [[-33.33,-12.73],[-33.05,-13.17],[-32.72,-13.58],[-32.35,-13.95],[-31.94,-14.27],
                [-31.5,-14.56],[-31.03,-14.8],[-30.55,-14.98],[-30.04,-15.12],[-29.52,-15.2],
                [-29,-15.23],[29,-15.23],[29.52,-15.2],[30.04,-15.12],[30.55,-14.98],
                [31.03,-14.8],[31.5,-14.56],[31.94,-14.27],[32.35,-13.95],[32.72,-13.58],
                [33.05,-13.17],[33.33,-12.73],[77.94,65],[54.85,65],[49.07,65],
                [40.99,51],[40.71,50.56],[40.38,50.15],[40.01,49.78],[39.6,49.45],
                [39.16,49.17],[38.7,48.93],[38.21,48.74],[37.7,48.61],[37.18,48.53],
                [36.66,48.5],[-36.66,48.5],[-37.18,48.53],[-37.7,48.61],[-38.21,48.74],
                [-38.7,48.93],[-39.16,49.17],[-39.6,49.45],[-40.01,49.78],[-40.38,50.15],
                [-40.71,50.56],[-40.99,51],[-49.07,65],[-77.94,65],[-33.05,-13.17]]);
            }
            Vtex2040Cuts();             //Make the internal cuts
        }
    }   
}
module Vtex2040Cuts()
{
//Vertical Extrusion opening
    translate([0,0,-50])
    linear_extrude(height = 100, center = false, convexity = 10)polygon(points = 
    [[-20.13,-10.13],[-14.5,-10.13],[-12.7,-8.32],[-7.3,-8.32],[-5.5,-10.13],
    [5.5,-10.13],[7.3,-8.32],[12.7,-8.32],[14.5,-10.13],[20.13,-10.13],
    [20.13,10.13],[-20.13,10.13]]);
//Big Opening
    translate([0,0,-50])
    linear_extrude(height = 100, center = false, convexity = 10)polygon(points = 
    [[-21.65,17.5],[-21.37,17.06],[-21.04,16.65],[-20.67,16.28],[-20.26,15.95],
    [-19.82,15.67],[-19.35,15.43],[-18.87,15.24],[-18.36,15.11],[-17.84,15.03],
    [-17.32,15],[-15.5,15],[-15.5,13.5],[15.5,13.5],[15.5,15],
    [17.32,15],[17.84,15.03],[18.36,15.11],[18.87,15.24],[19.35,15.43],
    [19.82,15.67],[20.26,15.95],[20.67,16.28],[21.04,16.65],[21.37,17.06],
    [21.65,17.5],[30.89,33.5],[31.13,33.97],[31.31,34.45],[31.45,34.96],
    [31.53,35.48],[31.56,36],[31.53,36.52],[31.45,37.04],[31.31,37.55],
    [31.13,38.03],[30.89,38.5],[30.6,38.94],[30.27,39.35],[29.9,39.72],
    [29.5,40.05],[29.06,40.33],[28.59,40.57],[28.1,40.76],[27.6,40.89],
    [27.08,40.97],[26.56,41],[-26.56,41],[-27.08,40.97],[-27.6,40.89],
    [-28.1,40.76],[-28.59,40.57],[-29.06,40.33],[-29.5,40.05],[-29.9,39.72],
    [-30.27,39.35],[-30.6,38.94],[-30.89,38.5],[-31.13,38.03],[-31.31,37.55],
    [-31.45,37.04],[-31.53,36.52],[-31.56,36],[-31.53,35.48],[-31.45,34.96],
    [-31.31,34.45],[-31.13,33.97],[-30.89,33.5]]);
}
module Vtex2040(Ht_V=Frame_Motor_Ht)
{
//This was traced from the profile of vertex_20x40.stl
    difference()
    {
        linear_extrude(height = Ht_V, center = false, convexity = 10)polygon(points = 
        [[-43.3,5],[-43.3,4.54],[-33.33,-12.73],[-33.05,-13.17],[-32.72,-13.58],
        [-32.35,-13.95],[-31.94,-14.27],[-31.5,-14.56],[-31.03,-14.8],[-30.55,-14.98],
        [-30.04,-15.12],[-29.52,-15.2],[-29,-15.23],[29,-15.23],[29.52,-15.2],
        [30.04,-15.12],[30.55,-14.98],[31.03,-14.8],[31.5,-14.56],[31.94,-14.27],
        [32.35,-13.95],[32.72,-13.58],[33.05,-13.17],[33.33,-12.73],[43.3,4.54],
        [43.3,5],[25.98,15],[54.85,65],[49.07,65],[40.99,51],
        [40.71,50.56],[40.38,50.15],[40.01,49.78],[39.6,49.45],[39.16,49.17],
        [38.7,48.93],[38.21,48.74],[37.7,48.61],[37.18,48.53],[36.66,48.5],
        [-36.66,48.5],[-37.18,48.53],[-37.7,48.61],[-38.21,48.74],[-38.7,48.93],
        [-39.16,49.17],[-39.6,49.45],[-40.01,49.78],[-40.38,50.15],[-40.71,50.56],
        [-40.99,51],[-49.07,65],[-54.85,65],[-25.98,15]]);
        Vtex2040Cuts();             //Make the internal cuts
    }  
}
module V_Slot_20x20(Ht_A=Frame_Ext_Len)
{
    color(v_slot_color)
    rotate([0,0,-90])
    difference()
    {
        linear_extrude(height = Ht_A, center = false, convexity = 10)polygon(points = 
        [[-10,-8.5],[-8.5,-10],[-4.64,-10],
        [-2.84,-8.2],[-5.5,-8.2],[-5.5,-6.56],
        [-2.84,-3.9],[2.84,-3.9],[5.5,-6.56],
        [5.5,-8.2],[2.84,-8.2],[4.64,-10],
        [8.5,-10],[10,-8.5],[10,-4.64],
        [8.2,-2.84],[8.2,-5.5],[6.56,-5.5],
        [3.9,-2.84],[3.9,2.84],[6.56,5.5],
        [8.2,5.5],[8.2,2.84],[10,4.64],
        [10,8.5],[8.5,10],[4.64,10],
        [2.84,8.2],[5.5,8.2],[5.5,6.56],
        [2.84,3.9],[-2.84,3.9],[-5.5,6.56],
        [-5.5,8.2],[-2.84,8.2],[-4.64,10],
        [-8.5,10],[-10,8.5],[-10,4.64],
        [-8.2,2.84],[-8.2,5.5],[-6.56,5.5],
        [-3.9,2.84],[-3.9,-2.84],[-6.56,-5.5],
        [-8.2,-5.5],[-8.2,-2.84],[-10,-4.64]]);
        translate([0,0,-1])
        cylinder(d=M5,h=Ht_A+2,$fn=HoleRes);
    }
}
module V_Slot_Vert()
{
    if (Alum_VertTopWid == 20)
    {
        translate([10,0,0])               //Move additional 10mm to left for 2060 size
        V_Slot_20x20(Frame_Ext_Ht);        //Draw 1st Vertical Extrusion
    }
    if (Alum_VertTopWid == 40)
    {
        V_Slot_20x40(Frame_Ext_Ht);        //Draw 1st Vertical Extrusion
    }
    if (Alum_VertTopWid == 60)
    {
        if (Alum_VertWid == 60)
        {
            translate([-10,0,0])               //Move additional 10mm to left for 2060 size
            V_Slot_20x60(Frame_Ext_Ht);        //Draw 1st Vertical Extrusion
        }
        if (Alum_VertWid == 20)
        {
            translate([-10,0,0])               //Move additional 10mm to left for 2060 size
            V_Slot_20x20(Frame_Ext_Ht);        //Draw 1st Vertical Extrusion
            translate([30,0,0])               //Move additional 10mm to left for 2060 size
            V_Slot_20x20(Frame_Ext_Ht);        //Draw 1st Vertical Extrusion
        }
    }
    if (Alum_VertTopWid == 80)
    {
        translate([-20,0,0])               //Move additional 10mm to left for 2060 size
        V_Slot_20x80(Frame_Ext_Ht);        //Draw 1st Vertical Extrusion
    }
}
module V_Slot_20x40(Ht_A=Frame_Ext_Len)
{
//This was traced from the V-Slot 20x40 & taking out the small details
    color(v_slot_color)
    rotate([0,0,-90])
    difference()
    {
        linear_extrude(height = Ht_A, center = false, convexity = 10)polygon(points = 
        [[-3.9,22.84],[-3.9,17.16],[-6.56,14.5],[-8.2,14.5],[-8.2,17.16],
        [-10,15.36],[-10,4.64],[-8.2,2.84],[-8.2,5.5],[-6.56,5.5],
        [-3.9,2.84],[-3.9,-2.84],[-6.56,-5.5],[-8.2,-5.5],[-8.2,-2.84],
        [-10,-4.64],[-10,-8.5],[-8.5,-10],[-4.64,-10],[-2.84,-8.2],
        [-5.5,-8.2],[-5.5,-6.56],[-2.84,-3.9],[2.84,-3.9],[5.5,-6.56],
        [5.5,-8.2],[2.84,-8.2],[4.64,-10],[8.5,-10],[10,-8.5],
        [10,-4.64],[8.2,-2.84],[8.2,-5.5],[6.56,-5.5],[3.9,-2.84],
        [3.9,2.84],[6.56,5.5],[8.2,5.5],[8.2,2.84],[10,4.64],
        [10,15.36],[8.2,17.16],[8.2,14.5],[6.56,14.5],[3.9,17.16],
        [3.9,22.84],[6.56,25.5],[8.2,25.5],[8.2,22.84],[10,24.64],
        [10,28.5],[8.5,30],[4.64,30],[2.84,28.2],[5.5,28.2],
        [5.5,26.56],[2.84,23.9],[-2.84,23.9],[-5.5,26.56],[-5.5,28.2],
        [-2.84,28.2],[-4.64,30],[-8.5,30],[-10,28.5],[-10,24.64],
        [-8.2,22.84],[-8.2,25.5],[-6.56,25.5]]);
//Cut opening between 20x20's
        translate([0,0,-1])
        linear_extrude(height = Ht_A+2, center = false, convexity = 10)polygon(points = 
        [[-8.2,7.3],[-6.24,7.3],[-2.84,3.9],[2.84,3.9],[6.24,7.3],
        [8.2,7.3],[8.2,12.7],[6.24,12.7],[2.84,16.1],[-2.84,16.1],
        [-6.24,12.7],[-8.2,12.7]]);
        translate([0,0,-1])
        cylinder(d=M5,h=Ht_A+2,$fn=HoleRes);      //Drill M5 holes
        translate([0,20,-1])
        cylinder(d=M5,h=Ht_A+2,$fn=HoleRes);
    }
}
module GlassTab()
{
    difference()
    {
        union()
        {
            cylinder(d=25.4,h=3.6,$fn=80);
            translate([-12.7,12.7,0])
            cube([25.4,28.2,3.6]);
        }
        translate([0,0,-1])
        cylinder(d=3.45,h=5.6,$fn=HoleRes);
    }
}
module SpiralBedClamp()
{
    rotate([0,0,180])
    translate([0,0,7.5])
    rotate([180,0,0])
    difference()
    {
        union()
        {
            linear_extrude(height = 4, center = false, convexity = 10)polygon(points = 
            [[-2.1,-4.16],[-2.1,-10.34],[-2.01,-10.77],[-1.74,-11.12],[-1.35,-11.31],
            [-0.91,-11.33],[1.24,-10.72],[3.24,-9.77],[5.02,-8.5],[6.56,-6.96],
            [7.78,-5.2],[8.67,-3.26],[9.2,-1.23],[9.35,0.44],[9.34,1.28],
            [9.04,3.31],[8.54,4.86],[7.61,6.65],[6.38,8.22],[4.83,9.55],
            [3.14,10.51],[1.32,11.11],[-0.93,11.34],[-2.62,11.16],[-4.37,10.61],
            [-5.94,9.72],[-7.27,8.55],[-8.31,7.15],[-9,5.58],[-9.33,3.94],
            [-9.28,2.29],[-8.87,0.77],[-8.13,-0.62],[-7.1,-1.76],[-5.88,-2.58],
            [-4.51,-3.06],[-3.15,-3.17],[-2.72,-3.24],[-2.36,-3.49],[-2.2,-3.74]]);
            translate([0,0,4])
            linear_extrude(height = 3.5, center = false, convexity = 10)polygon(points = 
            [[-2.1,-2.64],[-2.1,-7.27],[-2.01,-7.68],[-1.77,-8.02],[-1.41,-8.22],
            [-0.99,-8.26],[0.44,-7.81],[2.03,-6.99],[3.1,-6.2],[4.04,-5.28],
            [4.95,-4.08],[5.57,-2.94],[6.01,-1.76],[6.2,-0.94],[6.32,-0.11],
            [6.34,0.51],[6.31,1.54],[6.09,2.74],[5.7,3.89],[5.09,5.02],
            [4.32,6.03],[3.54,6.77],[2.46,7.5],[1.17,8.05],[0.11,8.29],
            [-1.16,8.33],[-2.36,8.14],[-3.48,7.71],[-4.34,7.18],[-5.07,6.52],
            [-5.73,5.62],[-6.12,4.74],[-6.33,3.73],[-6.32,2.86],[-6.14,2.03],
            [-5.99,1.65],[-5.78,1.27],[-5.72,1],[-5.53,0.49],[-5.13,-0.22],
            [-4.58,-0.82],[-3.91,-1.29],[-3.16,-1.6],[-2.76,-1.7],[-2.52,-1.83],
            [-2.32,-2.02],[-2.18,-2.25],[-2.1,-2.64]]);
        }
        translate([-2.14,1.98,-1])
        cylinder(d=6,h=5,$fn=HoleRes);
        translate([-2.14,1.98,3])
        cylinder(d=3.5,h=6,$fn=HoleRes);
    }
}
module GlassTabs()
{
    color(frame_color)
    {
        translate([0,-Alum_Y,Frame_Motor_Ht + Alum_BaseThk])
        GlassTab();
        translate([0,-Alum_Y,Frame_Motor_Ht + Alum_BaseThk + 3.6])
        SpiralBedClamp();
    }
}
//======================================================================
//=== This is where Vertices & Aluminum of the Delta is put together ===
//======================================================================
module DrawFrame()
{
//Draw Bottom Vertex corners
    color(frame_color)
    {
        for (z = [-120:120:120])        
        {
            rotate([0,0,z])
            translate([0,frame_rad,Alum_BaseThk])
            rotate([0,0,180])
            Vertex_Motor(Frame_Motor_Ht);
        }
//Draw Top Vertex corners
        for (z = [-120:120:120])        
        {
            rotate([0,0,z])
            translate([0,frame_rad,Frame_Ext_Ht-Frame_Top_Ht])
            rotate([0,0,180])
            VertexTop(Frame_Top_Ht);                 //Draw 1,2,3 top Vertex
        }
    }
//Draw the Bottom Horizontal Aluminum Extrusion(s)
    DrawHorBaseAlumFrame();
    if (Alum_BaseQty == 2)
    {
        translate([0,0,Alum_BaseHorWid  + Alum_BaseGap])
        DrawHorBaseAlumFrame();
    }
//Draw the Top Horizontal Aluminum Extrusion(s)
    translate([0,0,Frame_Ext_Ht - Alum_TopHorWid])
    DrawHorTopAlumFrame();          //Draw Top Aluminum Frame
    if (Alum_TopQty == 2)
    {  
        translate([0,0,Frame_Ext_Ht - Alum_TopHorWid - Alum_TopHorWid - Alum_TopGap])
        DrawHorTopAlumFrame();          //Draw Top Aluminum Frame
    }

//Draw Vertical Aluminum extrusions
    translate([-Len,-Y_Vertex,0])
    rotate([0,0,-60])
    translate([-10,0,0])
    V_Slot_Vert();
    
    translate([Len,-Y_Vertex,0])
    rotate([0,0,60])
    translate([-10,0,0])
    V_Slot_Vert();
    
    translate([0,frame_rad,0])
    rotate([0,0,0])
    translate([-10,0,0])
    V_Slot_Vert();
}
module DrawFinal()
{
    DrawFrame();                            //Draw Alum. Extusions & 6 Vertices

    GlassTabs();
    rotate([0,0,120])
    GlassTabs();
    rotate([0,0,-120])
    GlassTabs();
//Draw Glass Build Plate
    translate([0,0,Glass_Ht])
    color(plate_color)
    cylinder(r=BedRad+5,h=Glass_Thk);             //Draw Build plate cylinder
}


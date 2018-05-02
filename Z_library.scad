//OpenSCAD library modules - written from scratch - 
// (c) Pierre ROUZEAU(aka PRZ)2015-2017 Licence:  LGPL V3 
// Rev. 7 may 2017 : corrected ldupln function, which was making wrong count, so wrong tenons/slots
/*OpenSCAD primitives gives a priority to z axis, which needs a lot of subsequent rotations. So, you quickly find yourself lost between your axis, which have been swapped by the rotations. That drive for complex objects to build them on a X/Y plane, then to rotate the ensemble. It is tedious and unpractical.
  Also, OpenSCAD is using a lot of brackets, which are hard to get on some non-QWERTY keyboards.
  This library is aimed to ease openSCAD programming and improve readability. Also, primitive names are short. This is not the todays trend, but I find it useful, whithout real penalty. 
So in the proposed library:
a) Nearly all primitives could be used for all three axis. This is  simply done by having the axis name being the last letter of the primitive (primx, primy, primz...). 
b) The translation parameters are part of most primitive (not all)
c) You could use negative extrusion and where physically sound, negative dimensions.
d) Setting the main dimension parameter negative will center the extrusion, saving the 'CENTER' parameter - for dimensions which could not be physically negative (a diameter...)
e) No vector use, so no brackets
  With that, you have the primitive and associated movements done in one go. Designed for my own purpose, I find that useful and a wrist saver.
*/
//== PART I  : PRIMITIVES : Cylinders, rounded cubes
//== PART II : DEVELOPPED PRIMITIVES Bolt, extruded profiles, text display, partial tores
//== PART III : OPERATORS Rotation, translation, mirrors, quad multipliers, line multipliers
//== PART IV : MISCELLANEOUS 

/* [Computation] */
// Circle smoothness
$fn=24; // [4:6:8:24:48] 
//  final smoothness - reduced for visualisation
//Below is hole play to take into account manufacturing. Note that this is for diameter, not radius (or for complete sides).
// Play for hole (+ for printing, - for laser cut)
holeplay=0; // [0:0.025:0.25] 

/* [Hidden] */
// Play for routing opening (+)
bithole=0; // [0:0.025:0.25] 

//holeplay = (holeplay)?holeplay:0; //diameter play  for holes- applies for 'cyl' primitives and others hole primitives. This means that the diameter of a solid cylinder will also be affected, as the system cannot distinguish a hole from a solid.
// The play shall be positive for additive manufacturing (FDM). - value 'addplay' shall be defined
// shall be negative for laser cut (~ -0.2) - value 'cutplay' shall be defined.
// This play is also used by the slotting system.
// There are (globally positive) side-effects for primitives using cyl primiives (like 'rcube') 
//!WARNING!: to have the possibility to override this parameter from your configuration file, you shall <include> the utility file, and not <use> it. 

//next defines cube type in mcube module
solidxy = [1,1,0];
solidxz = [1,0,1];
solidyz = [0,1,1];


//== PART I  : PRIMITIVES =========================================================
// cylinder, first parameter is diameter, then extrusion length
// Negative Diameter CENTER extrusion, Negative extrusions are Ok
// usage: cyly (12,-40); -- cyly (12,-40, 8, 10, 9, 6); (hexagon)
module cylx (diam,length,x=0,y=0,z=0,div=$fn, fh=1) {//Cylinder on X axis
  // fh is a coefficient for holeplay - default 1 for cylinders
  if (fh==false) 
    echo ("cyly : change holeplay parameter to numeric");
  mv=(length<0)?length:0;					// not ok if diam AND length are negative. who cares ? 
  center=(diam<0)?true:false;	
  translate([x+mv,y,z])
    rotate([0,90,0])
      cylinder (d=(abs(diam)+fh*holeplay), h=abs(length), $fn=div, center=center);
}

module cyly (diam,length,x=0,y=0,z=0,div=$fn, fh=1) {//Cylinder on Y axis
  // fh is a coefficient for holeplay - default 1 for cylinders
  if (fh==false) 
    echo ("cyly : change holeplay parameter to numeric");
  mv=(length<0)?length:0; // accept negative height		
  center=(diam<0)?true:false;	
  translate([x,y+mv,z]) 
    rotate([-90,0,0])
      cylinder (d=(abs(diam)+fh*holeplay), h=abs(length), $fn=div, center=center);
}

module cylz (diam,height,x=0,y=0,z=0,div=$fn, fh=1) { // Cylinder  on Z axis
  // fh is a coefficient for holeplay - default yes for cylinders
  if (fh==false) 
    echo ("cyly : change holeplay parameter to numeric");
  mv=(height<0)?height:0; 	// accept negative height	
  center=(diam<0)?true:false;	
  translate([x,y,mv+z]) 
    cylinder (d=(abs(diam)+fh*holeplay), h=abs(height), $fn=div, center=center);
}

module mcube (sx,sy,sz,center=false,x=0,y=0,z=0, solid=[-1,-1,-1]) { // accept negative coordinates but only if center==false else result is wrong
  // take into account holeplay according to solid vector (default is a hole)
  cfc=(center)?0:1; // no play movement if centered
  mx=(sx<0)?cfc*(sx+solid[0]*holeplay/2):solid[0]*cfc*holeplay/2; 
  my=(sy<0)?cfc*(sy+solid[1]*holeplay/2):solid[1]*cfc*holeplay/2;
  mz=(sz<0)?cfc*(sz+solid[2]*holeplay/2):+solid[2]*cfc*holeplay/2;
  dx = abs(sx)-solid[0]*holeplay;
  dy = abs(sy)-solid[1]*holeplay;
  dz = abs(sz)-solid[2]*holeplay; 
  tsl(x+mx,y+my,z+mz)
    cube ([dx,dy,dz], center=center);
} //*/

//holeplay=2;
//mcube (20,30,40,false,0,0,0,[1,1,0]);

module cuben (sx,sy,sz,x=0,y=0,z=0, center=false) { // same as mcube, but with center after position, for homogeneity with cuben modules - NO holeplay so NO solid
  cfc=(center)?0:1; // no play movement if centered
  mx=(sx<0)?cfc*sx:0; 
  my=(sy<0)?cfc*sy:0;
  mz=(sz<0)?cfc*sz:0;
  tsl(x+mx,y+my,z+mz)
    cube ([abs(sx),abs(sy),abs(sz)], center=center);
}

module cubex (xd,yd,zd,x=0,y=0,z=0, fh=0) { // centered on y anz z, not centered on x, negative extrusion possible
  // fh is a coefficient for holeplay - default 0 for cubes
  if (fh==true) 
    echo ("cubex : change holeplay parameter to numeric");
  cfh = (xd<0)?-1:1;
  mx=(xd<0)?xd:0;
  tsl(mx+x,y-yd/2-fh*holeplay/2,z-zd/2-fh*holeplay/2)
    cube ([abs(xd),abs(yd)+fh*holeplay,abs(zd)+fh*holeplay]);
}

module cubey (xd,yd,zd,x=0,y=0,z=0, fh=0) { // centered on x anz z, not centered on y
  // fh is a coefficient for holeplay - default 0 for cubes
  if (fh==true) 
    echo ("cubey : change holeplay parameter to numeric");  
  cfh = (yd<0)?-1:1;
  my=(yd<0)?yd:0;
  tsl(x-xd/2-fh*holeplay/2,my+y,z-zd/2-fh*holeplay/2)
    cube ([abs(xd)+fh*holeplay,abs(yd),abs(zd)+fh*holeplay]);
}

module cubez (xd,yd,zd,x=0,y=0,z=0, fh=0) { // centered on x anz y, not centered on z
  // fh is a coefficient for holeplay  - default 0 for cubes
  if (fh==true) 
    echo ("cubez : change holeplay parameter to numeric");
  cfh = (zd<0)?-1:1; // what is done with that ??? 
  mz=(zd<0)?zd:0;
  tsl(x-xd/2-fh*holeplay/2,y-yd/2-fh*holeplay/2,mz+z)
    cube ([abs(xd)+fh*holeplay,abs(yd)+fh*holeplay,abs(zd)]);
}

/*extrusion of rounded rectangular profile (centered), first param radius. p1 & p2 = rectangular side size (not half as above)
  Translation only on main axis, others are the rectangle parameters
  negative radius center around main axis 
//usage: rcubex (5,12,40,60,20)  */

module rcubex (radius,length,x=0,y,z) {
  hull() 
    quadx (x,y/2-abs(radius),z/2-abs(radius)) 
      cylx(2*radius,length);
}

module hrcubex (radius,length,x=0,y,z) { // 'special' - rounded below, flat on top
  hull() {
    tsl(x) 
      cubex (length,y,z/2,0,0,z/4);
    dmirrory() 
      cylx(2*radius,length,x,y/2-abs(radius),-z/2+abs(radius),32);
  }  
}

//hrcubex (7, 5, 40, 40,30);
//rcubex (7, 5, 20, 40,30);

module rcubey (radius,length,x,y=0,z) {
  hull() 
    quady (x/2-abs(radius),y,z/2-abs(radius)) 
      cyly(2*radius,length);
}

module rcubez (radius,length,x,y,z=0) {
  hull() 
    quadz (x/2-abs(radius),y/2-abs(radius), z) 
      cylz(2*radius,length);
}

//tubex (20,2,-100, 50,60,80);

module tubex (diam, thickness, length, x=0,y=0,z=0, div=$fn, fh=1) {
  dt = (length<0)?-1:1;
  dtx = (diam<0)?0:dt;
  cf = (diam<0)?-1:1;
  difference() {
     cylx(cf*abs(diam), length, x,y,z, div, 0); // neutralise the holeplay 
     cylx(cf*(abs(diam)-2*thickness), length+dt+dt, x-dtx,y,z, div, fh);
   }  
}

module tubey (diam, thickness, length, x=0,y=0,z=0,div=$fn, fh=1) {
  dt = (length<0)?-1:1;
  dty = (diam<0)?0:dt;
  cf = (diam<0)?-1:1;
  difference() {
     cyly(cf*abs(diam), length, x,y,z,div, 0);
     cyly(cf*(abs(diam)-2*thickness), length+dt+dt, x,y-dty,z,div, fh);
   }  
}

module tubez (diam, thickness, length, x=0,y=0,z=0, div=$fn, fh=1) {
  dt = (length<0)?-1:1;
  dtz = (diam<0)?0:dt;
  cf = (diam<0)?-1:1;
  difference() {
     cylz(cf*abs(diam), length, x,y,z, div,0);
     cylz(cf*(abs(diam)-2*thickness), length+dt+dt, x,y,z-dtz, div, fh);
   }  
}

//eqtrianglez (-100, 15);  cylz (100, 5);
module eqtrianglez (dim, length, x=0,y=0,z=0) { // dim positive is base, dim negative is external circle diameter. Centered
  mz = (length<0)?-length:0; 
  base = (dim<0)? -dim/cos(30)*3/4: dim;
  tsl(x,y-base*cos(30)/3,z+mz)
    linear_extrude(height=abs(length))
      polygon(points=[[-base/2,0],[base/2,0],[0,base*cos(30)]]);		
}

//=== Tenon and mortise/slots library, for laser/router cut 
// Beware of the axis name. The first axis is the direction of propagation of the slots/tenon
// The second axis name is the second plane axis, slot plate wise. This is done to have the same name for the connecting modules, hence, the slotxy  will be in an horizontal plate, with propagation in x, while the connecting tenonxy will be for a vertical plate, oriented on x
// library is yet limited to xy and zx combos. Use rotations for other axis
// As the slots are holes, the slot module is not only a primive but also an operator, so it COULD be used to MODIFY your plate objects. The location coordinates are the last two parameters (x,y or x,z). Typical use will be slotxy(slotlength, interval, tlength, thktenonplate,x,y) myplate(); Alternatively, if not used as an operator, it just creates the holes.
//You shall define the 'cutplay' and 'bithole' parameters (look configuration file) to take into account the width of the laser cut or diameter of the bit. The global holeplay variable will so be set to a negative value equalling the laset beam cut diameter (approx 0.2mm diameter), while doing the exportation to dxf files. Such play make the slots invisibles in your model (the slots are smaller than the tenons), if you are not defining a protrusion.
// So, during the development of your model, a positive value for holeplay shall be defined (1~2). Note that the visible play is double in length than in width. This is normal, as the plate thickness will not be affected by the cut.
//Neither the slot nor the tenon are centered. Negative thicknesses or negative length could be used, but with caution. 
//As for line primitive, the use of a negative interval will adjust (round) the intervals to fit the allowed space, however in this primitive as the tenon length is known, there will be no part overpassing the length. 

module tenonxy (slotlength, interval, totlength, thkplate, height) { //creates tenons of length slotlength on totlength (does not go over length) - raise in 'z' axis
  sll=abs(slotlength);
   echo (holeplay=holeplay);
  cfl=(totlength<0)?-1:1;
  mvh= (height<0)?height:-0.2;
  mvl= (totlength<0)?-sll+holeplay/2:holeplay/2;
  lduplx (interval, cfl*(abs(totlength)-sll)) 
    tsl(mvl,0,mvh) //-0.2 to avoid merging surface-no play as //cuts will equal height
      cube([sll-holeplay, thkplate, abs(height)+0.2]);
}

module tenonbitxy (slotlength, interval, totlength, thkplate, height) { //cut the bit room aside tenons - parameters shall be identical to tenonxy, and this function shall be set in substraction block
  sll= abs(slotlength);
  cfl= (totlength<0)?-1:1;
  mvh= (height<0)?-0.1*bithole :0.1*bithole;
  mvl= (totlength<0)?-sll:0;
  lduplx (interval, cfl*(abs(totlength)-sll)) 
    tsl(mvl,0,mvh) { 
      cyly(-bithole,66,-0.48*bithole);
      cyly(-bithole,66,sll+0.48*bithole);
    }  
}

module tenonzx (slotlength, interval, totlength, thkplate, height) { //creates slots of length slotlength on totlength (does not go over length) -  raise in 'y' axis
  sll=abs(slotlength);
   echo (holeplay=holeplay);
  cfl=(totlength<0)?-1:1;
  mvh= (height<0)?height:-0.2;
  mvl= (totlength<0)?-sll+holeplay/2:holeplay/2;
  lduplz (interval, cfl*(abs(totlength)-sll)) 
    tsl(0,mvh,mvl)
      cube([thkplate, abs(height)+0.2,sll-holeplay]);
}

// As slots are full through holes, no depth defined 
module slotxy (slotlength, interval, totlength, thkplate,x=0,y=0) {
  sll= abs(slotlength);
  cfl= (totlength<0)?-1:1;
  mvt= (thkplate<0)?thkplate-holeplay/2:-holeplay/2;
  mvl= (totlength<0)?-sll-holeplay/2:-holeplay/2;
  difference () {
    children();
    tsl(x,y)
      lduplx (interval, cfl*(abs(totlength)-sll)) 
        tsl(mvl,mvt,-5) {
          cube([sll+holeplay, abs(thkplate)+holeplay, 100]); 
          if (bithole) 
            tsl(sll/2, thkplate/2) dmirrorx() dmirrory() 
              cylz (-bithole,66,sll/2-bithole*.485,thkplate/2-bithole*0.1); 
        }
  }
}

module slotzx (slotlength, interval, totlength, thkplate,z=0,x=0) {
  //-- not checked --- ???
  sll= abs(slotlength);
  cfl= (totlength<0)?-1:1;
  mvt= (thkplate<0)?thkplate-holeplay/2:-holeplay/2;
  mvl= (totlength<0)?-sll-holeplay/2:-holeplay/2;
  difference () {
    children();
    tsl(x,0,z)
      lduplz (interval, cfl*(abs(totlength)-sll)) 
        tsl(mvt,-5,mvl) {
          cube([abs(thkplate)+holeplay, 100, sll+holeplay]); 
          if (bithole) 
            tsl(thkplate/2,0,sll/2) dmirrorx() dmirrorz() 
              cylz(-bithole,66,thkplate/2-bithole*0.1,0,sll/2-bithole*.485); 
        }  
  }
}

module conex (diam1, diam2, ht, x=0,y=0,z=0,div=$fn, fh=1) {
  mv = (ht<0)?ht:0;
  di1 = (ht<0)?diam2:diam1;
  di2 = (ht<0)?diam1:diam2;
  translate([x+mv,y,z])
  rotate([0,90,0])
    cylinder (d1=di1+fh*holeplay, d2=di2+fh*holeplay, h=abs(ht), $fn=div);  
}

module coney (diam1, diam2, ht, x=0,y=0,z=0,div=$fn, fh=1) {
  mv = (ht<0)?ht:0;
  di1 = (ht<0)?diam2:diam1;
  di2 = (ht<0)?diam1:diam2;
  translate([x,y+mv,z])
  rotate([-90,0])
    cylinder (d1=di1+fh*holeplay, d2=di2+fh*holeplay, h=abs(ht),$fn=div);  
}

module conez (diam1, diam2, ht,  x=0,y=0,z=0,div=$fn, fh=1) {
  mz  = (ht<0)?ht:0;
  di1 = (ht<0)?diam2:diam1;
  di2 = (ht<0)?diam1:diam2;
  translate ([x,y,z+mz])
    cylinder (d1=di1+fh*holeplay, d2=di2+fh*holeplay, h=abs(ht),$fn=div);  
} 

//coney (10, 5, 3);

//cone3n
//diam 1 & diam2 shall be > 0
// if ht1 negative, ref is end of cylinder
// then if ht2 negative, ref is end of cone
// then if ht3 negative, ref is end of 2nd cylinder

module cone3x (diam1, diam2, ht1, ht2, ht3=0, x=0,y=0,z=0,div=$fn, fh=1) {
  mov1 = (ht1<0)?ht1:0;
  mov2 = (ht2<0)?ht2+mov1:mov1;
  mov3 = (ht3<0)?ht3+mov2:mov2;
  tsl(mov3) {
    cylx (diam1, abs(ht1)+0.02, x,y,z,div,fh);
    tsl(abs(ht1)+x,y,z)
      rot(0,90)
        cylinder (d1=diam1+fh*holeplay, d2=diam2+fh*holeplay, h=abs(ht2), $fn=div); 
    cylx (diam2, abs(ht3)+0.02, x+abs(ht1)+abs(ht2)-0.02,y,z,div,fh);
  }  
}

module cone3y (diam1, diam2, ht1, ht2, ht3=0, x=0,y=0,z=0,div=$fn, fh=1) {
  mov1 = (ht1<0)?ht1:0;
  mov2 = (ht2<0)?ht2+mov1:mov1;
  mov3 = (ht3<0)?ht3+mov2:mov2;
  tsl(0,mov3) {
    cyly (diam1, abs(ht1)+0.02, x,y,z,div,fh);
    tsl(x, y+abs(ht1),z)
      rot(-90)
        cylinder (d1=diam1+fh*holeplay, d2=diam2+fh*holeplay, h=abs(ht2), $fn=div); 
    cyly (diam2, abs(ht3)+0.02, x, y+abs(ht1)+abs(ht2)-0.02,z,div,fh);
  }  
}

module cone3z (diam1, diam2, ht1, ht2, ht3=0, x=0,y=0,z=0,div=$fn, fh=1) {
  mov1 = (ht1<0)?ht1:0;
  mov2 = (ht2<0)?ht2+mov1:mov1;
  mov3 = (ht3<0)?ht3+mov2:mov2;
  tsl(0,0,mov3) {
    cylz (diam1, abs(ht1)+0.02, x,y,z, div,fh);
    tsl(x, y,z+abs(ht1))
      cylinder (d1=diam1+fh*holeplay, d2=diam2+fh*holeplay, h=abs(ht2), $fn=div); 
    cylz (diam2, abs(ht3)+0.02, x,y,z+abs(ht1)+abs(ht2)-0.02, div,fh);
  }  
}
/*
holeplay=0.2;
cone3x (2, 4, 4, 2, 6);
cone3x (2, 4, -4, 2, 6, 0,-8);
cone3x (2, 4, -4, -2, 6,0,-16);
cone3x (2, 4, -4, -2, -6,0,-24);
cone3x (4, 2, -4, 2, -6,0,-32);

cone3y (2, 4, 4, 2, 6,  0,0,0, $fn,0);
cone3y (2, 4, -4, 2, 6, -8,0);
cone3y (2, 4, -4, -2, 6,-16,0);
cone3y (2, 4, -4, -2, -6,-24,0);
cone3y (4, 2, -4, 2, -6,-32,0);

cone3z (2, 4,  4, 2,  6,  20);
cone3z (2, 4, -4, 2,  6,  20,-8);
cone3z (2, 4, -4, -2, 6,  20,-16);
cone3z (2, 4, -4, -2, -6, 20,-24);
cone3z (4, 2, -4, 2,  -6, 20,-32);
//*/

// cconen primitives may be deprecated in favor of cone3n primitives - avoid using them
module cconex (diam1, diam2, ht, htcyl=-1, x=0,y=0,z=0,div=$fn, fh=1) {
  // if htcyl negative, go from reference plan
  // if htcyl positive, cone atop cylinder
  mcyl = (htcyl>0) ?(htcyl-0.02)*sign(ht):-0.02*sign(ht);
  tsl(mcyl) conex (diam1, diam2, ht, x,y,z,div, fh);
  cylx (diam1, abs(htcyl)*sign(ht)*sign(htcyl),x,y,z, div, fh);
}

module cconey (diam1, diam2, ht, htcyl=-1, x=0,y=0,z=0,div=$fn, fh=1) {
  // if htcyl negative, go from reference plan
  // if htcyl positive, cone atop cylinder
  mcyl = (htcyl>0) ?(htcyl-0.02)*sign(ht):-0.02*sign(ht);
  tsl(0,mcyl) coney (diam1, diam2, ht, x,y,z,div, fh);
  cyly (diam1, abs(htcyl)*sign(ht)*sign(htcyl),x,y,z, div, fh);
}

module cconez (diam1, diam2, ht, htcyl=-1, x=0,y=0,z=0,div=$fn, fh=1) {
  // if htcyl negative, go from reference plan
  // if htcyl positive, cone atop cylinder
  mcyl = (htcyl>0) ?(htcyl-0.02)*sign(ht):-0.02*sign(ht);
  tsl(0,0,mcyl) conez (diam1, diam2, ht, x,y,z,div, fh);
  cylz (diam1, abs(htcyl)*sign(ht)*sign(htcyl),x,y,z, div, fh);
}

// filleting primitives - the fillet is an independant volume
module filletx (rad, lg, x=0,y=0,z=0) {
  mv = (rad<0)?rad+0.02:0;
  mv2 = (rad<0)?rad:0;
  mlg = (lg<0)?lg:0;  
  translate ([x+mlg, y-0.02+mv, z-0.02])
    difference() {
      cube ([abs(lg), abs(rad),abs(rad)]);
      cylx (abs(rad)*2,abs(lg)+2,  -1,rad-mv2,abs(rad));
    } 
} 

module fillety (rad, lg, x=0,y=0,z=0) {
  mv = (rad<0)?rad+0.02:0;
  mv2 = (rad<0)?rad:0;
  mlg = (lg<0)?lg:0;  
  translate ([x-0.02+mv, y+mlg,z-0.02])
    difference() {
      cube ([abs(rad), abs(lg),abs(rad)]);
      cyly (abs(rad)*2,abs(lg)+2,rad-mv2,-1,abs(rad));
    } 
}

module filletz (rad, lg, x=0,y=0,z=0) {
  mv = (rad<0)?rad+0.02:0;
  mv2 = (rad<0)?rad:0;
  mlg = (lg<0)?lg:0;  
  translate ([x-0.02+mv, y-0.02,z+mlg])
    difference() {
      cube ([abs(rad), abs(rad), abs(lg)]);
      cylz (abs(rad)*2, abs(lg)+2,  rad-mv2, abs(rad),-1);
    } 
}

//cubez (20,20,20,10);
//fillety (-5,-50);

/*
holeplay=0; 
bithole=3.5; // to cut bit room 
slotxy (12,-30,200,10,25,35)  
   mcube (250,120,10,false, 20,20); //*/
/*
holeplay=0; 
bithole=3.5; // to cut bit room 
tsl(25,35) {
  difference() { 
    union() {
      mcube (250,10,-100); 
      tenonxy (12,-30,200,10,10);  
    } 
    tenonbitxy (12,-30,200,10,10);   
  } 
} //*/

//== PART II : DEVELOPPED PRIMITIVES ===================================================

// Rather basic bolt routines // head size is realistic only in metric
// Bolts type are "HEX", "SH" (socket head), "DOME" and "FLAT" - all uppercase-
// dome shown is medium size, default "HEX"
// Washer types are 'S','M','L','LL', corresponding washer size, default none for one below nut. For two '2S', '2M', etc.
// Length is between the head and washer base. bolt total length not defined - this is a weakness
// Negative length are allowed, this reverse the bolt
// Normal reference point is under head
// NEGATIVE diameter center the bolt - reference point is middle of bolt
// Head size as shown is fictive, as in the ISO standard, they are rounded to the nearest plain number and not the direct result of a coefficient.
// usage: boltx(5,12); -- boltz(-5,20,8,0,30,"SH");
// washer not yet implemented...

//boltx(-5, 20, 10,20,50);
module boltx (d,l,x=0,y=0,z=0,type="HEX", washer="") {//bolt on X axis	
  dia=abs(d);
  lg=abs(l);	// accept negative height
  mi= (l<0)?[1,0,0]:[0,0,0];
  mvc=(d<0)?-lg/2:0;//negative diameter CENTER the bolt 
  translate ([x,y,z])
  mirror (mi) 
    translate ([mvc,0,0]) {
      if (abs(lg)>2) { // only show head if lg<2 (decoration) - allow negative for returning the head
        cylx (dia,lg+dia*1.2);
        cylx (dia*1.8,dia*0.8,lg,0,0,6); // nut
      }  
      // bolt head
      if (type=="DOME") { // domed head
        cylx (dia*2,-dia*0.16);
	difference (){
          rot (0,-90,0) 
            dome (dia*2, dia/2,0,0,dia*0.16);
          cylx (dia*0.92,-dia,-dia*0.2,0,0,6);
        }
      }
      else if (type=="SH") //socket head
        difference () {
          cylx ((1/dia+1.5)*dia,-dia);
          cylx (dia*0.92,-dia,-dia*0.2,0,0,6);
        }
        else if (type=="FLAT") difference () {
          cylx (dia*2.4,-dia*0.5);
          cylx (dia*0.92,-dia,-dia*0.2,0,0,6);
        }
        else  // hexagonal
          cylx (dia*1.8,-dia*0.8,0,0,0,6);	
      } //tr
} //boltx

module bolty (d,l,x=0,y=0,z=0,type="HEX", washer) {
  translate([x,y,z])
    rotate([0,0,90])
      boltx(d,l,0,0,0,type, washer); 
}

module boltz (d,l,x=0,y=0,z=0,type="HEX", washer) {
  translate([x,y,z])
    rotate([0,90,0])
      boltx(d,l,0,0,0,type, washer); 
}

//--- Text display --------------------------------------------------------------

module textz (txt,size,h,bold,x=0,y=0,z=0, hal="left", val ="baseline") { // position text normal to z axis
  a =(h<0)?180:0;
  st=(bold)? "Liberation Sans:style=Bold":"Liberation Sans";
  tsl(x,y,z) rot(a,0,0)
      linear_extrude(height = abs(h)) text (str(txt), size, font=st, halign=hal, valign=val);
}

module textx (txt,size,h,bold,x=0,y=0,z=0, hal="left", val ="baseline") { // position text normal to x axis
  a =(h<0)?-90:90;
  tsl(x,y,z) rot (90,0,a)
    textz(txt,size,abs(h),bold,0,0,0,hal,val);
}

//tore (10, 50, 15, 220); 

module tore (dia, ldia, angstart, angend, qual=100) {
  // first diameter is the small diameter, qual defines segment numbers (on 360 °)->$fn
  sectorz(angstart,angend, -ldia*2)
    rotate_extrude($fn=qual)
      tsl(ldia/2)
         circle(dia/2);
}
//tore (10, 50, 220, 290);

module cylsectz (di, height, thickness, angstart,angend) { // cylindrical sector
  sectorz (angstart,angend)
    difference () {
      cylz (di+2*thickness, height,0,0,0,120);
      cylz (di, height+2,0,0,-1,120);
    }  
}

module cylsectx (di, height, thickness, angstart,angend) { // cylindrical sector
  sectorx (angstart,angend)
    difference () {
      cylx (di+2*thickness,height,    0,0,0,120);
      cylx (di,            height+2, -1,0,0,120);
    }  
}
//cylsectz  (100,25,10,100,160);

module sectorz (angstart,angend, radius=-1000,depth=2000 ) { //cut a sector in any shape, z axis  
  // negative radius will equilibrate the depth on z axis
  // angstart could be negative, angend could not
mvz = radius<0?-abs(depth)/2:depth<0?depth:0;  
sectang =  angend-angstart;
cutang = 360-sectang; 
  module cutcube() { 
    tsl(-0.02,-abs(radius),mvz-0.1)  
      cube(size= [abs(radius),abs(radius),abs(depth)], center =false);
  }  
  module cutsect () {
    if (sectang >270) {
      difference () {
        cutcube();
        rotz (-cutang) 
          cutcube();
      }
    }  
    else {
      cutcube();
      rotz (-cutang+90) 
        cutcube();
      if (cutang > 180) 
        rotz(-90) 
          cutcube();
      if (cutang > 270)   
        rotz(-180) 
          cutcube();
    }
  } // cutsect
  difference () {
    children();
    rotz (angstart) 
      cutsect();
  }
}

module sectorx (angstart,angend, radius=-1000,depth=2000 ) { //cut a sector in any shape, z axis  
  // negative radius will equilibrate the depth on z axis
  // angstart could be negative, angend could not
mvx = radius<0?-abs(depth)/2:depth<0?depth:0;  
sectang =  angend-angstart;
cutang = 360-sectang; 
  module cutcube() { 
    tsl(mvx-0.1,-0.02,-abs(radius))  
      cube(size=[abs(depth), abs(radius),abs(radius)], center =false);
  }  
  module cutsect () {
    if (sectang >270) {
      difference () {
        cutcube();
        rot (-cutang) 
          cutcube();
      }
    }  
    else {
      cutcube();
      rot (-cutang+90) 
        cutcube();
      if (cutang > 180) 
        rot(-90) 
          cutcube();
      if (cutang > 270)   
        rot(-180) 
          cutcube();
    }
  } // cutsect
  difference () {
    children();
    rot (angstart) 
      cutsect();
  }
}

//--- Profiles ------------------------------------------------------------------
// profile_angle (30, 30, 2, -80) ;
module profile_angle (legW, legH, thickness, length) { // length could be negative
  mv = (length<0)?length:0;
  tsl(0,0,mv)
    linear_extrude (height=abs(length)) 
      difference () {
        square ([legW,legH]);
        tsl(thickness,thickness) 
          square ([legW,legH]);
      }  
}

//profile_T(20,20,1.5, 100);
module profile_T (width, height, thickness, length) { // length could be negative
  mv = (length<0)?length:0;
  w=width/2;
  tsl(0,0,mv)
    linear_extrude (height=abs(length)) 
      polygon(points=[[-w,0],[w,0],[w,thickness],[thickness/2,thickness],[thickness/2,height],[-thickness/2,height],[-thickness/2,thickness],[-w,thickness]]);
}

//== PART III : OPERATORS ==================================================
//aliases
module u() {union() children();} // union alias
 
module diff () {  // difference alias
  difference() {
    children(0); 
    if ($children>1) for(i=[1:$children-1]) children(i);
  }  
}

//rotation and translations without brackets - 
module rot  (x,y=0,z=0) {rotate([x,y,z]) children();}
module r  (x,y=0,z=0) {rotate([x,y,z]) children();}
module rotz (z) {rotate([0,0,z]) children();}
module tsl (mx,my=0,mz=0) {translate([mx,my,mz]) children();}
module t (mx,my=0,mz=0) {translate([mx,my,mz]) children();}
module tslz (mz) {translate ([0,0,mz]) children();}

// for a delta, everything is rotated three times at 120°, so an operator for that 
module rot120 (a=0) {
  for(i=[0,120,240]) rotate([0,0,i+a]) children();
}

module mirrorx (mi=true) { // parameter helps in conditional mirroring
  mm = (mi)?1:0;
  mirror([mm,0,0]) children();
}
module mirrory (mi=true) {
  mm = (mi)?1:0;
  mirror([0,mm,0]) children();
}
module mirrorz (mi=true) {
  mm = (mi)?1:0;
  mirror([0,0,mm]) children();
}

module dmirrorx (dup=true, x=0) { // duplicate and mirror
  if (dup) tsl(x) children();
  mirror ([1,0,0]) tsl(x) children();  
}
module dmirrory (dup=true, y=0) {
  if (dup) tsl(0,y) children();
  mirror ([0,1,0]) tsl(0,y) children();
}
module dmirrorz (dup=true, z=0) {
  if (dup) tsl(0,0,z) children();
  mirror ([0,0,1]) tsl(0,0,z) children();
}

module duplMirror (x,y,z) {//mirror AND maintain the base- beware, OpenSCAD is not iterative
  children();
  mirror ([x,y,z]) children();
}

module dupl (vct, nb=1) { // duplicate object at vector distance
  for (i=[0:nb])
    translate (vct*i) children();
}

module duplx (dx, nb=1, startx=0) { // duplicate object at distance 'dx', times nb
  for (i=[0:nb])
    tsl(dx*i+startx) children();
}

module duply (dy, nb=1, starty=0) { // duplicate object at distance 'dy',  times nb
  for (i=[0:nb])
    tsl(0,dy*i+starty) children();
}

module duplz (dz, nb=1, startz=0) { // duplicate object at distance 'dz',  times nb
  for (i=[0:nb])
    tsl(0,0,dz*i+startz) children();
}

// Duplicates children on a given length at intervals following axis. Number is calculated
// x,y,z are for translation of the ensemble
// module linex (interval, length, x=0,y=0,z=0) {lduplx (interval, length, x,y,z);}
module lduplx (interval, length, x=0,y=0,z=0) { // if distance negative, optimize space to have a children at the end, else, the interval is respected
  nb = sign(length)*floor(abs(length)/abs(interval));
  sp=(interval<0)?length/nb:interval;
  for (i=[0:nb]) tsl(i*sp+x,y,z) children();
}

module lduply (interval, length, x=0,y=0,z=0) {
  nb = sign(length)*floor(abs(length)/abs(interval));
  sp=(interval<0)?length/nb:interval;
  for (i=[0:nb]) tsl(x,y+i*sp,z) children();
}

module lduplz (interval, length, x=0,y=0,z=0) {
  nb = sign(length)*floor(abs(length)/abs(interval));
  sp=(interval<0)?length/nb:interval;
  for (i=[0:nb]) tsl(x,y,z+i*sp) children();
}

module drotz (angle, nb=1, initial=0) { // polar duplication rotating around Z axis
  for (i=[0:nb])
    rotz (angle*i+initial) children();
}

module droty (angle, nb=1, initial=0) {
  for (i=[0:nb])
    rot (0,angle*i+initial) children();
}

module drotx (angle, nb=1, initial=0) {
  for (i=[0:nb])
    rot (angle*i+initial) children();
}

//segz (2,2, 0,-5,200,-5);
//linez (31, 200) cylz (2,2);

//-- rectangular quad multiplier operator +p1/-p1, +p2/-p2
//Translation only on main axis, others are the rectangle parameters
//usage: quady (20,0,50) cylx(3,5); 
module quadx (x=0,y,z) {
  duplMirror(0,0,1) {
    translate ([x,y,z]) children();
    mirror ([0,1,0])
      translate ([x,y,z]) children();
  }    
}

module quady (x,y=0,z) {
  duplMirror(0,0,1) {
    translate ([x,y,z]) children();
    mirror ([1,0,0])
      translate ([x,y,z]) children();
  }  
}
module quadz (x,y,z=0) { // create four blocs at -x/-x and +y/-y (mirrored)
  duplMirror(0,1,0) {
    translate ([x,y,z]) children();
    mirror ([1,0,0])
      translate ([x,y,z]) children();
  }
}

//== PART IV : MISCELLANEOUS ===================================================

//-- Miscellaneous Modules ---------------
module dome (d,ht,x,y,z){ // origin base of dome - rise in 'z' axis
  mv = (z==undef)?0:z;
  Sph_Rd = (ht*ht + d*d/4) / (2*ht);
  translate([x,y,-Sph_Rd+ht+mv])
    difference() {
      sphere(Sph_Rd, $fn=64);
      translate([0,0,-ht]) // remove the useless sphere portion
        cube([2*Sph_Rd,2*Sph_Rd,2*Sph_Rd],center=true);
    }
}

module echo_camera () { // Echo camera variables on console
  echo ("Camera distance: ",$vpd); 
  echo ("Camera translation vector: ",$vpt);  
  echo ("Camera rotation vector: ",$vpr);
}

module segz (d,depth, x1,y1,x2,y2) { //extrude rounded segment
  linear_extrude(height=depth, center=false)  
    hull () {tsl(x1,y1) circle (d=d); tsl(x2,y2) circle(d=d);}
}

//-- color modules ---------------------------
module black() {color ("black") children();}
module white() {color ("white") children();}
module silver(){color ("silver") children();}
module gray()  {color ("gray") children();}
module red()   {color ("red") children();}
module green() {color ("green") children();}
module blue()  {color ("blue") children();}
module yellow(){color ("yellow") children();}
module orange(){color ("orange") children();}
include <Z_library.scad>
// Miscellaneous part modules, not in Library
// ball bearings, fans, nema17 motors, name plates, glass locks, pen
// Miscellaneous writing and signature routines 
// to use it in your application set 
// include <X_utils.scad> xpart=0; //xpart=0 neutralise demo

// build_fan(size=40, thk=6) // ~ok for 25,30,40,60,80,120
// BB (type="623", orient=1);  // ball bearings
// nema17(lg=40) // Nema17 stepper
// plate(txt=["Bonjour"], clr="white", wd=50, ht=30, thick=1.6, txtsize=3, bordercf=1) // plate with text
// multiline(ttext, txtsize, thktext=0.5) // write text in 'z' axis
// writenum (num, size=10, depth=1) // write a number
// writeCC (size=5,depth=1,nc=true) //Write CC BY-SA licence  (NC optional)
// byz (size, depth, x=0,y=0,z=0) // write 'by' - for signature -
// pen() //standard pen for scale referencing
// glasslock(thkglass=6, extent=10) // side glass/mirror retainer
// Tglasslock(thkglass=6) // glass/mirror retainer 'T' shape

/* [Hidden] */
xpart=90; // show demo parts

thkglass=4;
nbpart=4;

if (xpart==90) {
  build_fan(40,10); // basic fan shape
  tsl (45, -55) rot(90, 0,-90) pen(); // pen (use as size reference)
  tsl(-60) plate(["PRZ Industries", "We are open", "and everything is free"],  "white", 60, 35, 1.6, 5); // plate
  tsl(-60, 30) plate(["YES!"],  "white", 30, 15, -3, 6); // plate holed through
  dmirrorx() tsl (-26,40) glasslock (3); // glass retainers
  tsl (0,54.5) rotz (90) Tglasslock (3); // glass retainers
    color ([0.5,0.5,0.5,0.5]) duply (29)cubez (40,25,4, 0,40);
    
  difference() {  
    cubez (75,25,1, -50,-35);
    tsl (-80,-30)color ("lawngreen") writeCC(5,10); // Routable "CC BY-NC-SA
    tsl (-80,-40)color ("lawngreen") writeCC(6,10,false);
    tsl (-62, -35) byz(-6,10,38,-0.5); // routable "by"
  }  
  tsl (0,-35)  writenum([3,2,1]); // writing numbers
  BBx("F625",1,-90,40); // ball bearing
  tsl (-60,65,40)nema17();
}
else if (xpart==31) duplpartx (nbpart,20,12) rot (90) glasslock (thkglass);
else if (xpart==32) duplpartx (nbpart,20,12) rot (90) Tglasslock (thkglass);

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

//-- Ball bearings ------------------------------------------------

module BBx (type="623", orient=1, x=0,y=0,z=0) { // orient set the flange on one side or the other
  tsl (x,y,z)
    rot (0,90)
      BB(type, orient);
}

// It is important to note that for flanged bearing, the reference plane is the internal flange face, while for plain bearing, it is the bearing face

module BB (type="623", orient=1) {
  module B(De,di,thk,Flthk2=0,DFl=0, orient, flanged=false) {
    Flthk = (flanged)?Flthk2:0;
    echo (refBB=refBB);
    mz = (orient==0)?-thk/2:0; 
    mirr = (orient==-1)?true:false;
    DF = (DFl) ? DFl: De+1.5*Flthk;
    tsl (0,0,mz)
    mirrorz(mirr)
      color ("silver")
        tsl (0,0,-Flthk) 
          difference() {
            union() {
              cylz (De, thk);  
              if (Flthk)
                cylz (DF, Flthk);
            }  
            cylz (di, thk+0.2, 0,0,-0.1);  
          }
  } 
  refBB  = (type[0]=="F")?type:(type[0]=="6")?str("F",type):type; 
  flanged= (type[0]=="F")?true:false;
  
       if (refBB=="F602") B(7,2,2.8,0.7,8.5,orient,flanged);   
  else if (refBB=="F602X")B(8,2.5,2.8,0.7,9.5, orient,flanged);          
  else if (refBB=="F603") B(9,3,3,0.7,10.5, orient,flanged);   
  else if (refBB=="F604") B(12,4,4,1,13.5,  orient,flanged);    
  else if (refBB=="F605") B(14,5,5,1,16,    orient,flanged);  
  else if (refBB=="F606") B(17,6,6,1.2,19,  orient,flanged); 
  else if (refBB=="F607") B(19,7,6,1.5,22,  orient,flanged);   
  else if (refBB=="F608") B(22,8,7,1.5,25,  orient,flanged);  
  
  else if (refBB=="F623") B(10,3,4,1,11.5,orient,flanged);  
  else if (refBB=="F624") B(13,4,5,1,15,  orient,flanged);  
  else if (refBB=="F625") B(16,5,5,1,18,  orient,flanged);
  else if (refBB=="F626") B(19,6,6,1.5,22,orient,flanged);    
  else if (refBB=="F627") B(22,7,7,1.5,25,orient,flanged);        
  
  else if (refBB=="F633") B(13,3,5,1,15,  orient,flanged);
  else if (refBB=="F634") B(16,4,5,1,18,  orient,flanged);  
  else if (refBB=="F635") B(19,5,6,1.5,22,orient,flanged);    
  else if (refBB=="F636") B(22,6,7,1.5,25,orient,flanged);      

  else if (refBB=="F674") B(8,4,2.4,0.7,9.5, orient,flanged);    
  else if (refBB=="F675") B(8,5,2.5,0.7,9.5, orient,flanged);          
  else if (refBB=="F683") B(7,3,3,0.8,8.1,orient,flanged);   
  else if (refBB=="F684") B(9, 4,4,1,10.4,orient,flanged);   
  else if (refBB=="F685") B(11,5,3,1,13,  orient,flanged);     
  else if (refBB=="F686") B(13,6,5,1.1,15,orient,flanged);   
  else if (refBB=="F687") B(14,7,5,1.1,16,orient,flanged);   
  else if (refBB=="F688") B(16,8,5,1.1,18,orient,flanged); 
    
  else if (refBB=="F692") B(6,2,2.3,0.6,7.5,orient,flanged);     
  else if (refBB=="F693") B(8, 3,4,0.9,9.5,orient,flanged);     
  else if (refBB=="F694") B(11,4,4,1,12.5, orient,flanged);       
  else if (refBB=="F695") B(13,5,4,1,15, orient,flanged);    
  else if (refBB=="F696") B(15,6,5,1.2,17, orient,flanged);     
  else if (refBB=="F697") B(17,7,5,1.2,19, orient,flanged); 
    
  else if (refBB=="MR62") B(6,2,2.5,0,0,    orient,flanged);   
  else if (refBB=="MR63") B(6,3,2,0,0,      orient,flanged); 
  else if (refBB=="MF63") B(6,3,2.5,0.6,7.2,orient,true);   
  else if (refBB=="MR73") B(7,3,3,0,0,      orient,flanged); 
  else if (refBB=="MR74") B(7,4,2,0,0,      orient,flanged);   
  else if (refBB=="MR82") B(8,2.5,2.5,0,0,  orient,flanged);  
  else if (refBB=="MR83") B(8,3,2.5,0,0,    orient,flanged);
  else if (refBB=="MR83b")B(8,3,3,0,0,      orient,flanged);    
  else if (refBB=="MR93") B(9,3,4,0,0,      orient,flanged);
  else if (refBB=="MR103")B(10,3,4,0,0,     orient,flanged); // same as 623 
  else if (refBB=="MF74") B(7,4,2.5,0.6,8.2,orient,true);   
  else if (refBB=="MFR4") B(7,4,2.5,0,0,    orient,flanged);     
  else if (refBB=="MR95") B(9,5,3,0,0,      orient,flanged);    
  else if (refBB=="MR105")B(10,5,3,0,0,     orient,flanged);  
  else if (refBB=="MR115")B(11,5,4,0,0,     orient,flanged); 
    
  else if (refBB=="MR106")B(10,6,3,0,0,     orient,flanged);    
  else if (refBB=="MR126")B(12,6,4,0,0,     orient,flanged);      
}

module nema17(lg=40) { // NEMA 17 stepper motor. - replace by STL ??
  color("grey")
    difference() {
      union() {
        intersection() {
          cubez(42.2, 42.2, lg,0,0,-lg);
          cylz(50.1,lg+1,0,0,-lg-0.5,60);
        }
        cylz(22,2,0,0,0,32);
        cylz(5,24,0,0,0,24);
      }
      for (a = [0:90:359]) 
        rotz(a) cylz(-3,10, 15.5,15.5);
    }
}

module plate(txt=["Bonjour"], clr = "white", wd = 50, ht = 30, thick= 1.6, txtsize=3, bordercf=1) {
  diamcorn = 0.1*bordercf;
  dcn = diamcorn *wd;
  dci = dcn*0.5;
  thk = abs(thick);
  difference() {
    union() {
      color ("gold")
        difference() {
          hull() 
            dmirrorx() dmirrory() cylz(dcn,thk,  (wd-dcn)/2,(ht-dcn)/2);     
          hull() 
            dmirrorx() dmirrory() cylz(dci,thk,  (wd-dcn)/2,(ht-dcn)/2,thk/2);  
        /*  if (thick < 0)  // if thickness negative, then hole the plate
            tsl (0,ht/2-2.3*txtsize,-1)
              multiline(txt, txtsize, thk*2);    */
        }
      if (thick>0)   
        if (len(txt)>1)
          color ("black")  
          tsl (0,ht/2-2.3*txtsize,thk/2)
            multiline(txt, txtsize, thk/2); 
        else
          color ("gold")  
            textz(txt[0],txtsize,thk/2+0.1,false,0,0,thk/2-0.1, "center", "center");
        color ("gold")  
        dmirrorx() dmirrory() cylz (dcn,thk, (wd-dcn)/2, (ht-dcn)/2);     
    if (clr)
      color (clr) 
        hull() 
          dmirrorx() dmirrory() cylz (dci,0.2, (wd-dcn)/2, (ht-dcn)/2, thk/2);      
    } //::: Then whats removed :::
    dmirrorx() dmirrory() cylz (-dcn/3,66, (wd-dcn)/2, (ht-dcn)/2);
    if (thick<0)   
        if (len(txt)>1)
          color ("black")  
          tsl (0,ht/2-2.3*txtsize,thk/2)
            multiline(txt, txtsize, thk/2); 
        else
          color ("gold")  
            textz(txt[0],txtsize,2*thk,false,0,0,-1, "center", "center");
     dmirrorx() dmirrory() 
       cone3z (dcn/2.3,dcn/1.2, -1,0.7*thk,2 ,(wd-dcn)/2, (ht-dcn)/2, 0.2*thk);         
  }
 * if (clr)  
    color ("silver") // rivets
      dmirrorx() dmirrory() cylz (dcn/2.3,1.9, (wd-dcn)/2, (ht-dcn)/2);     
}

module multiline(ttext, txtsize, thktext=0.5) { //text in 'z' axis
  ltxt = len(ttext);
  color ("black") { // the writing on the wall
    for (i=[0:ltxt-1]) {
      txs=(i==ltxt-1)?txtsize*0.8:txtsize; // last line is smaller size (license)
      tsl (0, -1.5*txtsize*i)
        textz(ttext[i], txs, thktext, (i==0),0,0,"center","center");  //(i==0) bold the first line
    }
  } 
}

module wrnb (nb, size=10, depth=1, pos=0) { // write a digit
diam = 10/7;
dmoy = (10-diam)/2;
dint = dmoy-diam;
dext = dmoy+diam;
rdext = dext/2;  
dpp =abs(depth);
  tsl (pos) 
    scale ([size/10, size/10, dpp]) {
      if (nb==3 ||nb==8 ) {
        difference () {
          union() {
            cylz(dext,1,0,rdext);
            cylz(dext,1,0,10-rdext);
          }
          cylz (-dint,3,0,rdext);
          cylz (-dint,3,0,10-rdext);
          if (nb==3) 
            cylz (-10, 3,-10/1.8, 5);
        }  
      } 
      else if (nb==0)   {
        difference () {
          hull() {
            cylz(dext,1,0,rdext);
            cylz(dext,1,0,10-rdext);
          }
          hull() {
            cylz (-dint,3,0,rdext);
            cylz (-dint,3,0,10-rdext);
          }  
        }  
      }
      else if (nb==1)   {
        cubez(diam,10,1,1,5);
        tsl(1)
        rotz(35) 
          cubez(3,diam,1,4,7.65);
      }
      if (nb==2) {
        difference () {
          cylz(dext,1,0,10-rdext);
          cylz (-dint,3,0,10-rdext);
          tsl (0,10-dmoy)
            rotz(-38)
              mcube(10,4,4,true,0,-1);
        }  
        mcube (dext-0.2,diam,1, false,-rdext+0.21);
        tsl (-0.12,3.5,0.5)
          rotz(52)
            mcube(6.3,diam,1,true);
      }
      if (nb==4) {
        mcube (dext-0.2,diam,1, false,-rdext+0.21,1.8);
        tsl (-0.18,6.2,0.5)
          rotz(61)
            mcube(7.6,diam,1,true);
        mcube (diam,4,1,false);
      }
      else if (nb==5) {
        difference () {
          cylz (dmoy+diam,1,0,rdext);
          cylz (-dint,3,0,rdext);
          cylz (-10, 3, -10/1.8, 5);
          mcube (dint,dint/2,3,true,-dint/2, rdext+dint/4);
        }
        difference () {
          mcube (dext,dext,1,true,diam*0.65,10-dext*0.55, 0.5);
          mcube (dint,dint*2,3,true,diam*0.65,10-dext*0.55-dint/2);
          mcube (dint,dint,3,true,diam*0.65,10-rdext-diam*1.1);
          rotz(-10) mcube (10,10,3,true,5.7,6);
          mcube (dint,dint/2,3,true,-dint/2, rdext+dint/4);
        }  
      } 
      else if (nb==6 || nb==9) {
        mirr9=(nb==9)?1:0;
        tsl(0,10/2)
          mirror([mirr9,0,0])
            mirror([0,mirr9,0])
              tsl (0,-10/2) {
                difference () {
                  cylz(dext,1,0,rdext);
                  cylz (-dint,3*1,0,rdext);
                }
                difference () {
                  cylz(14+diam,1,7-dmoy/2,rdext,0,60); 
                  cylz(14-diam,3,7-dmoy/2,rdext,-1,60);
                  mcube (30, 10, 3, true, 0,-10/2+rdext);
                  rotz(18) mcube (40,20, 3,true,7-dmoy/2+20,rdext); 
                }  
              }  
      }
      else if (nb==7) tsl (-10/20) {
        difference () {
          rotz(-25) mcube (diam,20,1,true,-diam,5,0.5);
          cubez (20, 10, 3,0,-10/2.1,-1);
          cubez (20, 10, 3,0,14.7,-1);
        }
        cubez(3*diam,diam,1,0,10-diam*0.7);
      }
    }
}

module writenum (num, size=10, depth=1) {
  tsl (size*0.3,0,-depth/2)
    for (i=[0:len(num)-1]) 
      wrnb (num[i],size,depth,0.68*size*i);
}

//writenum ([0,1,2,3,4,5,6,7,8,9],6); 

module writeCC (size=5,depth=1,nc=true) { // Graphism is non standard for CC 
dx = (nc)?69:39;   
dpp =abs(depth);
diam = 10/5.5; 
hl = 10-0.33*diam;
hb = 0.33*diam;
  module letterC () {
    difference () { // "C"
      cylz(10,1,0,5);
      cylz (-10+1.9*diam,3,0,5);
      cylz (-8,3,5,5);
    } 
    tsl (2.6,5)
      dmirrory() 
        cylz (diam, 1, 0,3.17);
  } 
  tsl (0,0,-dpp/2)
    scale ([size/10, size/10, dpp]) {
      duplx (10) letterC ();
      tsl (20) { // "B"  
        tsl (0.5) segz (diam,1,0,hb,0,hl);
        duply (4.4) {
          difference () {
            cylz (3.44*diam, depth,    2*diam, diam*1.54, 0, 50);
            cylz (-1.45*diam, 3*depth, 2*diam, diam*1.54);
            tsl (diam,2*diam) mcube (2*diam,6*diam,3*depth, true);
          }  
          
        }
        duply (4.4,2)
          cylz (diam,depth,2*diam,hb);
      }  
      tsl (30) { // "Y"  
         segz (diam,1,0,hb,5,hl);
         segz (diam,1,-1,hl,2.5,5);
      }  
      if (nc) {   
        tsl (38) segz (diam,1,0,5,5,5); // "-"
        tsl (48) { // "N"
          duplx (7)
            segz (diam,1,0,hb,0,hl);
          segz (diam,1,0,hl,7,hb);
        }  
        tsl(63) letterC(); // "C"
      }
      tsl (dx) segz (diam,1,0,5,5,5); // "-"
      
      tsl (dx+11) { //"S"
        segz (diam,1,-2,hb,2,hb);
        segz (diam,1,0,hl,3,hl);
        segz (diam,1,0,5,2,5);
        
        tsl (-2)
          difference () {
             cylz (3.44*diam, depth,    2*diam, diam*1.54, 0, 50);
             cylz (-1.45*diam, 3*depth, 2*diam, diam*1.54);
             tsl (diam,2*diam) mcube (2*diam,6*diam,3*depth, true);
          }  
        tsl (3.6,4.4)
          mirrorx()
            difference () {
              cylz (3.44*diam, depth,    2*diam, diam*1.54, 0, 50);
              cylz (-1.45*diam, 3*depth, 2*diam, diam*1.54);
              tsl (diam,2*diam) mcube (2*diam,6*diam,3*depth, true);
            }  
      }
      tsl (dx+18) { //"A"
        segz (diam,1,0,hb,3.5,hl);
        segz (diam,1,7,hb,3.5,hl);
        segz (diam,1,1.5,4.2,5,4.2);
        segz (diam,1,3.5,4.2,3.5,hl);
      }
    }
}

module byz (size, depth, x=0,y=0,z=0) { // write 'by' - for signature - 
  mz=(size<0)?-depth/2:0;
  sz = abs(size);  
  diam=sz/5.5;
  tsl (x-sz/10,y,z+mz) {
    segz (diam,depth,0.3*diam,0,0.3*diam,sz);
    difference () {
      cylz (4*diam, depth, 2*diam, diam*1.5);
      cylz (-2*diam, 3*depth, 2*diam, diam*1.5);
      tsl (diam,2*diam) mcube (2*diam,6*diam,3*depth, true);
    } 
    cylz (diam,depth,2*diam,3*diam);
    cylz (diam,depth,2*diam,0);
    segz (diam,depth,5*diam,3*diam,7*diam,0.5*diam);
    segz (diam,depth,8.5*diam,3*diam,5.5*diam,-2*diam);
  }
}  

module framexy (x,y,edgewidth=2.5, height=10) { //build a frame.Prefer just drafting corners ?? for cut plates delimitations
  difference () { // peripheral frame
    mcube (x,y,height);
    mcube (x-2*edgewidth, y-2*edgewidth,55,false,edgewidth,edgewidth,-5);
  }
}

module attachx (x,y, length=10) { //Laser cut create a small link 1.5 mm width 'attach' between parts - in x
  cubez (length,2.5,10,x,y);
}

module attachy (x,y, length=10) { //Attach oriented in y axis
  cubez (2.5,length,10,x,y);
}

module pen() { //standard pen for scale referencing
  // as all transparent objects, it shall be modelled before other objects to have transparency properly working
  color ("gold")cconez (1,6, 10,0.5);
  color ("blue") {
    cylz (3.5, 130, 0,0,10);
   cconez (8,3, 0.6,0.4, 0,0,145, 8);
  }  
  color ([0.5,0.5,0.5,0.5]) cconez (8,6, -10,-125, 0,0,20, 8);
}

module glasslock(thkglass=6, extent=10) {
  h = thkglass/2;
  wd = 16;
  difference() { 
    union() {
      hull() {
        cubex (-extent,wd, 3.5, 6,0,3.5/2);  
        cubez (3,wd,thkglass+2.7, 4.5);  
      }  
      cubez (-7,wd, 3,  1, 0,thkglass-0.3);
      tsl (5.95,0,thkglass-0.15)
        rot (0,45) cubey (h,wd,h, 0,-wd/2);
    }
    duply (wd-8.4)
      cone3z (3.2,6.2,  -4,1.5,11, 1.5,-wd/2+4.2,3.5);
  }  
}

module Tglasslock(thkglass=6) {
  h = thkglass/2.5;
  wd = 16;
  difference() { 
    union() {
      cubez (4,wd,thkglass+2.7);  
      cubez (9+thkglass,wd, 3,  0, 0,thkglass-0.15);
      dmirrorx() 
        tsl (1.95,0,thkglass-0.15)
          rot (0,45) cubey (h,wd,h, 0,-wd/2);
    }
    duply (wd-8.4)
      cone3z (3.2,6.2,  -10,1.5,11, 0,-wd/2+4.2,thkglass+1);
  }  
}


//== utilities functions =========================

module segz (d,depth, x1,y1,x2,y2) { // extruded rounded segment
  linear_extrude(height=depth, center=false)  
    hull () {
      tsl(x1,y1) circle (d=d); 
      tsl(x2,y2) circle (d=d);
  }
}

// Duplicate parts in singe/double rows/columns

module duplpartx (nbpart=1, x=0, y=0) {
  xnum1 = (y==0)?nbpart-1: ceil(nbpart/2) -1;  
  xnum2 = (y==0)?nbpart-1: floor(nbpart/2) -1;    
  duplx (x, xnum1) children();
  tsl (0,y)
    duplx (x, xnum2) children();
}

module duplparty (nbpart=1, x=0, y=0) {
  ynum1 = (x==0)?nbpart-1: ceil(nbpart/2) -1;  
  ynum2 = (x==0)?nbpart-1: floor(nbpart/2) -1;    
  duply (y, ynum1) children();
  tsl (x) duply (y, ynum2) children();
}


//tsl (0,100) duplparty (7,20,20) Tglasslock();
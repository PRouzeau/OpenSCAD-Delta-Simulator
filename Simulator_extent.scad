//Specific modules for extending delta simulation
//This is new for use of customizer, as customizer cannot load specific files, so all extensions shall be loaded every time.
//By example, you could use these modules to load stl files
// PRZ Jan 2017, Licence: see Delta_simulator.scad

// Display carriage
module buildCar(ht=16) { // modify to allow excentrate articulation (lowered) ??
  if (Delta_name == "Fisher Delta by RepRapPro") {
    dcar = 15+8; // 19 is bearing diam
    tsl (0,0,-car_vert_dist) {
      hull () 
        dmirrorx()
          cylz (-dcar, ht,rod_space/2); // -x to decrease side size
      cubez (rod_space-extrusion,20,-dia_ball*1.5,0,10-car_hor_offset,dia_ball*1.5/2);
      cylx (-dia_ball*1.5,rod_space-extrusion,0,-car_hor_offset); 
    }
  }
}


// Display printer sides
module buildSides() {
  if (Delta_name == "Fisher Delta by RepRapPro") {
    platethk = 3;
    platewd  = 190;
    platedist = 89; // internal face dist to centre
    diams  = 26;
    openht = htotal-hbase-htop-diams;
    
    color ("black")
    //color([0.5,0.5,0.5,0.5]) 
    rot120 (-30)
      difference() {
        cubez (platethk, platewd, htotal,-platedist-platethk/2); 
        dmirrory()
          tsl (0,0,openht/2+hbase+diams/2)
            hull() 
              dmirrorz() cylx (-diams,100, -platedist,100,openht/2);
        tsl (0,0,Housing_opening_height/2+hbase+bed_level+diams/2-0.1)
          hull() 
            dmirrory() dmirrorz()
              cylx (-diams,100, -platedist,70-diams/2,Housing_opening_height/2);
      }
  }    
}

// Display effector
module buildEffector() {

}

// Display hotend
module buildHotend() {
  
}

// Display arm
module buildArm (ang_hor,ang_ver) {
  
}

// Display complete printer frame
module buildAllFrame() {

}
   
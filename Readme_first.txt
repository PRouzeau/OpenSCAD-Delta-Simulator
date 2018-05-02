To run the simulator you need:
*The last version of OpenScad (development Snapshot) - don't use 2015.03 version:
  http://www.openscad.org/downloads.html#snapshots
*The file 'Delta_simulator_new.scad' (in whatever directory you want)
*The file 'Delta_simulator_new.json' (in same directory as above)
*The file 'Simulator_extent.scad' (in same directory as above)

Run this file in OpenScad and run simulation by pressing 'F5' key - first run may be long

To see what are the modifications linked to any parameter, modify the parameter and press 'F5'
In customizer any modification will rerun automatically the simulator.

Needs AT LEAST OpenScad 2018.04.06 snapshot (snapshot with customizer, nearly all bugs removed, better presentation)
Note that there is a nasty bug (#1892) https://github.com/openscad/openscad/issues/1892 which may drive to update the font cache at every start-up. If it occurs on Windows Delete directories  C:\Users[User]\AppData\Local\fontconfig (GUI) and C:\Windows\System32\config\systemprofile\AppData\Local\fontconfig (CLI) to get rid of this bug (font cache will update once after the delete).
Customizer is required in this new simulator revision (Snapshot of April 2018)
Customizer is experimental feature, so you need to select:
Menu [Edit][Preferences][Features], tick [Customizer]
Menu [View] Untick [Hide customizer]
Customizer interface is nicer if you select 'description only' at top of customizer panel (after hitting 'F5' key)

There is a bunch of preset data which when selected in Customizer simulates known and prospective 3D printers geometries.
You need to run [F5] BEFORE selecting a dataset
Note that a dataset only modify recorded data, so a dataset if not incorporating all datas (which shall be done by editing the json file) can be used as a modifier only and not necessarily a complete set. 

// Play with it! you won't broke anything.
// To run the animation click [View][Animate],a panel open in the bottom right of your screen. Set 10~25 in the FPS field and 360 in the field 'Steps'. A lower number will make larger steps. You can manipulate the view during animation. You need to stop the animation to change a parameter (including animation movement). For that set 0 in 'Steps' field.

//Making a closeup during animation needs deactivation of imposing camera view variable (group 'Camera view' in customizer else see below)


To understand properly the delta geometry angles, you may first have a thorough look on the page:
http://reprap.org/wiki/Delta_geometry

If you want to simulate details of your printer, it may be wise to base your simulation on one
of the example dataset. If you modify a value in one dataset, it is only taken into account if
the dataset file is saved. For easy development, you may copy these data in 'Delta_simulator.scad'
after the default values and comment again any line calling a dataset.
*The Kossel mini dataset is a good base for an aluminium extrusion based printer. 
*The Fisher dataset is a good base for a Rostock whith bearings on rods. 

To make an animation, have a look on the file 'Do_animation.txt' 

For a enclosed delta, you may have a look here:
  https://github.com/PRouzeau/HXM-delta-printer






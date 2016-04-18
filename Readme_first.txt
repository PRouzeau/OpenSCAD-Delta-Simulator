To run the simulator you need:
*The last version of OpenScad (development Snapshot) - don't use 2015.03 version:
  http://www.openscad.org/downloads.html#snapshots
*The file 'Delta_simulator.scad' (in whatever directory you want)

Load this file in OpenScad and run simulation by pressing 'F5' key - first run may be long

To see what are the modifications linked to any parameter, modify the parameter and press 'F5'

If you want to simulate one of the given examples (line 102 to 112 of the simulator), 
first the example file shall be loaded in the same directory as 'Delta_simulator.scad',
then you shall uncomment the dataset line (remove the first '//' characters) and press 'F5'.

The data in the datasets being defined after default data, they supersedes them.

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






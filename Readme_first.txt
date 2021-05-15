To run the simulator you need:
*The last version of OpenScad (development Snapshot) - don't use 2015.03 version:
  http://www.openscad.org/downloads.html#snapshots
*The file 'Delta_simulator.scad' (in whatever directory you want)
*The file 'Delta_simulator.json' (in same directory as above)
*The file 'Simulator_extent.scad' (in same directory as above)

Run this file in OpenScad and run simulation by pressing 'F5' key - first run may be long

To see what are the modifications linked to any parameter, modify the parameter and press 'F5'
In customizer any modification will rerun automatically the simulator.

Needs AT LEAST OpenScad 2018.04.06 snapshot (snapshot with customizer, nearly all bugs removed, better presentation)
Note that there is a nasty bug (#1892) https://github.com/openscad/openscad/issues/1892 which may drive to update the font cache at every start-up. If it occurs on Windows Delete directories  C:\Users[User]\AppData\Local\fontconfig (GUI) and C:\Windows\System32\config\systemprofile\AppData\Local\fontconfig (CLI) to get rid of this bug (font cache will update once after the delete).
Customizer is required in this simulator revision

*The complete path of the directory where you install this application
 (Protected crossing or any other) shall only use ASCII characters,
 without spaces, accented letters, any diacritic, umlaut or other
 character set.
Since OpenScad version 2019.05 Customizer is validated by default:
*In [View] menu, you shall now have an option [Hide customizer],
 than you shall untick
*In same [View] menu, you may want to hide the programming editor
 with ticking [Hide editor].
*Interface use local language (as configured on your machine) by default.
 To deactivate: menu [Edit][Preferences] tab [Advanced], untick the
 option (in the bottom) [Enable user interface localization (requires
 restart of openSCAD)]. 
*After program loading, Customizer is not activated, you need first to do a
 preview, either with [F5] key or by clicking the first icon below the view.
*In Customizer screen, on first line, select [Description only], which will
 give a much cleaner interface. Unfortunately, this set is not saved and
 shall be selected at every OpenSCAD startup

There is a bunch of preset data which when selected in Customizer simulates known and prospective 3D printers geometries.
You need to run [F5] BEFORE selecting a dataset
Note that a dataset only modify recorded data, so a dataset if not incorporating all datas (which shall be done by editing the json file) can be used as a modifier only and not necessarily a complete set. 

When happy with a design, customizer can record it in a dataset, use the
 button [+] to create a new dataset then [save preset] to save further
 modifications, which can be recalled by selecting a dataset in the
 dropdown menu. 
 
NOTHING is saved automatically.
If you don't see the examples in the dataset pull-down menu, come back
 to the above note about the directory character sets.

// Play with it! you won't broke anything.
// To run the animation click [View][Animate],a panel open in the bottom right of your screen. Set 10~25 in the FPS field and 360 in the field 'Steps'. A lower number will make larger steps. You can manipulate the view during animation. You need to stop the animation to change a parameter (including animation movement). For that set 0 in 'Steps' field. You have animation options in the tab [].

//Making a closeup during animation needs deactivation of imposing camera view variable (group 'Camera view' in customizer else see below)


To understand properly the delta geometry angles, you may first have a thorough look on the page:
http://reprap.org/wiki/Delta_geometry

If you want to simulate details of your printer, it may be wise to base your simulation on one
of the example dataset. See how to use Customizer here:

*The Kossel mini dataset is a good base for an aluminium extrusion based printer. 
*The Fisher dataset is a good base for a Rostock whith bearings on rods. 

To make an animation, have a look on the file 'Do_animation.txt' 

For an enclosed delta, you may have a look here:
  https://github.com/PRouzeau/Lily-F-delta-printer  The Lily is my second Delta build, running for more than five years now (march 2021) with the parts salvaged from the Fisher. The first (D-Box) is still also in operation.





/* Build your own delta - by PRZ - Oct 2015
This simulator propose a very schematic delta frame, on purpose of fast animation.
However, you can adapt it with more details to looks more realistic.
There is two ways for that : 
 - build your own angles/vertexes, effector, carriage with OpenScad, but this
   may drive to animation performance issue on low powered computer (mine !)
 - include stl files. That is faster, but you shall handle multiple files in 
   the main directory, which is a bit messy and the possibilities of adaptations are reduced.

How to :
You shall create (in dataset file) variables which allow modules in your dataset
to take over the simulator display modules

$bAllFrame = true;  // will runs module buildAllFrame() that you have to create.
That is the main frame, however, if you want to stop extrusion display, you may want to set: extrusion=0;  and also cancel from dataset the following variables to left them to their default value of 0: railthk, rod_space.

$bEffector=true;  //will run buildEffector(); to include/build the effector
$bCar=true;    //will run buildCar(); to include/build carriage
$bHotend=true; // will run buildHotend(); to include/build hotend, ducts and fans  

One important point for conflict analysis is to position the part cooling fan(s)
as they are key in limitation of the working diameter.
For this purpose, you have the simple module build_fan(size=40, thk=6) in the
simulator, for most current dimensions (diameters available:25,30,40,60,80,120).

*/
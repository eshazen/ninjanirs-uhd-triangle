# ninjanirs-uhd-triangle

### 2026-03-18

Starting production print (some R&D first).
<br>Printing UHD_Assembly_Ver1 as is using 0.4mm nozzle
and profile "0.08mm Extra Fine".  Quoted time 42m.
<br>_If this doesn't work we'll change to 0.2mm nozzle._

Seems OK.  Printing Grommets with same settings.
Also seems ok with some cleanup.

Printing springtop both ways up, same settings.  Broke both but
right-side up seems best if we can manage to get it off the support.
<br>Trying again right-side up.  OK with care

Printing caps with same settings (right-side up).
<br>Caps don't quite fit in springtop.


#### Re-printing all with 0.2mm nozzle

* Printing grommets using "0.06mm High Quality".  Time est 38min
<br>Fails with non-adhered parts

Make some changes as AI suggests:

* Change first layer height to 0.16mm.
* Change bed temp from 55 to 60 for both first and subsequent layers
* Change initial layer speed to 20mm/s
  <br>(in Filament profile)

Did not (yet) try to scrub the plate with dish soap!

Print the grommets again, much better.

Now the optodes, same settings.  Est 1:07.  Ok.

And the caps.  45min.  OK

Springtop:  enlarge hole to 3.75 and drill through the arms.  26m
<br>Print failed (bad adhesion).  Cleaned plate and tried again.  Fail
<br>Change to "0.12mm Standard" and added one layer of raft.  Fail.

Probably need to print these with 0.5mm nozzle?  Or somehow create a raft?
<br>Or possibly it's the white filament?

### 2025-11-23

Re-starting project.  Opened UHD_Assembly_Ver1 on Onshape.
The groove depth 0.75 was missing, add it somewhat arbitrarily.

<pre>
   1.9
+--------+
|        |
|        |
|        |
|     .75|
|    +---+ 
|    |     0.57
|    +---+ 
|        | 0.5
+--------+
</pre>

Attempting to print with 0.2mm nozzle, preset
<br>0.06mm High Quality @BBL X1C 0.2 nozzle
<br>Rotate so attach peg is up on build plate
<br>This is a 37m print for one, with support

Fix the slot, print again with "Tree Slim" support,
right-side up this time.

<pre>
   1.9
+--------+
|        |
|        |
|        |
|     .3 |
|    +---+ 
|    |     1
|    +---+ 
|        | 0.5
+--------+
</pre>

This seems better.  Also printed a copy of `test_pegs` and a set of optodes.


## 2025-06-10

Working on attachment to ninjaCap.  Trying some small retaining rings
from McMaster:

| Item | P/N       | OD    | Groove wid | Groove dia |
|------|-----------|-------|------------|------------|
| 1    | 98410A111 | 1/8"  | .012"      | .117"      |
| 2    | 98410A815 | 5/32" | .012"      | .146"      |
| 3    | 98410A110 | 3/16" | .018"      | .175"      |

Printing a test peg for number 3 (A110)

* Peg dia = 0.177
* groove wid = 0.018
* grove dia = 0.168

Using 0.2mm nozzle
<br>Profile "0.06mm High Quality @BBL X1C 0.2 nozzle"

Fits nicely, but clip probably not wide enough to secure to flexible
cap.  Maybe a plastic or metal washer under the clip?


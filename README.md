# Kinematics-and-EMG
For use with motion capture c3d files.

Staticpelvismarkers - Records reference positions of markers for the anterior and superior iliac spines during a static trial in the global coordinate frame and transforms them into the local body segment coordinate frame.

Dynamicpelvismarkers - Calculates the positions any pelvis markers that are obscured during a dynamic trial with reference to their static positions in the local frame. Transforms the marker locations to the global lab frame and then fills the gaps in the marker trajectory.

Staticpelvisangles - Creates a local body segment coordinate frame for the pelvis for a static reference trial.

Dynamicpelvisangles - Calculates pelvic tilt, obliquity and rotation for a dynamic trial with reference to the static position of the pelvis.

Statictrunkangles - Creates a local body segment coordinate frame for the trunk for a static reference trial.

Dynamictrunkangles - Calulates trunk motion in the saggital plane assuming two-dimensional motion.

emg_filtering - Filters and normalises raw EMG data 



SDK=ViconNexus();

subject = 'Fullbody';

%% Import Marker Trajectories from Reference Trial
[startframe, endframe] = SDK.GetTrialRegionOfInterest;                     
ROIframes = double(startframe:endframe)';                                  
framecount1 = length(ROIframes);

[XRP1, YRP1, ZRP1] = SDK.GetTrajectory( subject, 'RPSIS' );
[XRP2, YRP2, ZRP2] = SDK.GetTrajectory( subject, 'RASIS' );
[XRP3, YRP3, ZRP3] = SDK.GetTrajectory( subject, 'LASIS' );
[XRPSIS, YRPSIS, ZRPSIS] = SDK.GetTrajectory( subject, 'MA' ); % MISSING MARKER
[XLPSIS, YLPSIS, ZLPSIS] = SDK.GetTrajectory( subject, 'LPSIS' ); % MISSING MARKER

%% 

% Define local origin

origin=[XRP1(1)+XRP3(1), YRP1(1)+YRP3(1), ZRP1(1)+ZRP3(1)]/2;
 
% Define local coordinate frame
vecZ=[(XRP1(1)-origin(1)) (YRP1(1)-origin(2)) (ZRP1(1)-origin(3))]; 
axisZ=vecZ/ norm(vecZ);

vecY= [(XRP2(1)-origin(1)) (YRP2(1)-origin(2)) (ZRP2(1)-origin(3))];
firstaxisY=vecY/norm(vecY);

vecX=cross(axisZ, firstaxisY);
axisX=vecX/norm(vecX);

axisY=cross(axisZ, axisX);

%Local to Global transformation matrix]
local2global=[axisX(1) axisY(1) axisZ(1) origin(1)
              axisX(2) axisY(2) axisZ(2) origin(2)
              axisX(3) axisY(3) axisZ(3) origin(3)
              0          0        0        1];
          
%% 

%%Calculate marker positions in local pelvis frame
%RPSIS 
static_RPSIS=[XRPSIS(1) YRPSIS(1) ZRPSIS(1) 1];

%Transformation Matrix RPSIS

static_RPSIS_L2G =local2global\(static_RPSIS');

% %LPSIS
static_LPSIS=[XLPSIS(1) YLPSIS(1) ZLPSIS(1) 1];

%Transformation Matrix LPSIS

static_LPSIS_L2G =local2global\(static_LPSIS');







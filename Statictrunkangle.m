SDK=ViconNexus();

subject = 'Fullbody';

%% Import Marker Trajectories from Reference Trial
[startframe, endframe] = SDK.GetTrialRegionOfInterest;                     
ROIframes = double(startframe:endframe)';                                  
framecount1 = length(ROIframes);

[XMAS, YMAS, ZMAS] = SDK.GetTrajectory( subject, 'MA' );
[XRAS, YRAS, ZRAS] = SDK.GetTrajectory( subject, 'RASIS' );

%%
%Define static angle

static_angle=atand((YMAS(1)-YRAS(1))/(ZMAS(1)-ZRAS(1)));



SDK=ViconNexus();

subject = 'Fullbody';

%% Import Marker Trajectories from Reference Trial
[startframe, endframe] = SDK.GetTrialRegionOfInterest;                     
ROIframes = double(startframe:endframe)';                                  
framecount1 = length(ROIframes);

[XRPS, YRPS, ZRPS] = SDK.GetTrajectory( subject, 'RPSIS' );
[XLAS, YLAS, ZLAS] = SDK.GetTrajectory( subject, 'LASIS' );
[XRAS, YRAS, ZRAS] = SDK.GetTrajectory( subject, 'RASIS' );

%%
%Define static cordinate frame
vector_X=[XLAS(1)-XRAS(1) YLAS(1)-YRAS(1) ZLAS(1)-ZRAS(1)];
static_X=vector_X/norm(vector_X);

vector_Y=[XRPS(1)-XRAS(1) YRPS(1)-YRAS(1) ZRPS(1)-ZRAS(1)];
axis_Y=vector_Y/norm(vector_Y);

vector_Z=cross(static_X, axis_Y);
static_Z=vector_Z/norm(vector_Z);

static_Y=cross(static_Z, static_X);

%rotation matrix
static_rotation_matrix=[static_X(1) static_X(2) static_X(3)
                        static_Y(1) static_Y(2) static_Y(3)
                        static_Z(1) static_Z(2) static_Z(3)];
                    
                    


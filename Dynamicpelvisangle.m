SDK=ViconNexus();

subject = 'Fullbody';
%% Import Marker Trajectories from Dynamic Trial

[startframe, endframe] = SDK.GetTrialRegionOfInterest;                     
ROIframes = double(startframe:endframe)';                                  
framecount1 = length(ROIframes);
start_frame=double(startframe);
end_frame=double(endframe);
[events] = SDK.GetEvents('Fullbody', 'Right', 'Foot Strike');


[XRPS, YRPS, ZRPS] = SDK.GetTrajectory( subject, 'RPSIS' );
[XRAS, YRAS, ZRAS] = SDK.GetTrajectory( subject, 'RASIS' );
[XLAS, YLAS, ZLAS] = SDK.GetTrajectory( subject, 'LASIS' );

%%
%Define dynamic angle
x_angle=zeros(1,end_frame);
y_angle=zeros(1,end_frame);
z_angle=zeros(1,end_frame);
pelvis_angle=zeros((events(2)-events(1)+1),3);

for i=1:endframe
     % define dynamic axis for each frame
vec_X=[XLAS(i)-XRAS(i) YLAS(i)-YRAS(i) ZLAS(i)-ZRAS(i)];
dynamic_X=vec_X/norm(vec_X);

vec_Y=[XRPS(i)-XRAS(i) YRPS(i)-YRAS(i) ZRPS(i)-ZRAS(i)];
axis_dynamic_Y=vec_Y/norm(vec_Y);

vec_Z=cross(dynamic_X, axis_dynamic_Y);
dynamic_Z=vec_Z/norm(vec_Z);

dynamic_Y=cross(dynamic_Z, dynamic_X); 

%rotation matrix
dynamic_rotation_matrix=[dynamic_X(1) dynamic_X(2) dynamic_X(3)
                         dynamic_Y(1) dynamic_Y(2) dynamic_Y(3)
                         dynamic_Z(1) dynamic_Z(2) dynamic_Z(3)];

 % static to dynamic
 static2dynamic=static_rotation_matrix\dynamic_rotation_matrix;
 
%calculate angle between static and dynamic axes  
eul(i,:)=rotm2eul(static2dynamic);

end    
  eul_angles=eul*180/pi; 

    
 pelvis_angle=eul_angles((events(1):events(2)),:);

 
%%
% normalise to gait cycle
filename='...';

heel_strike=1;
    
        xx = 0:1:100;

        
        frames = size(pelvis_angle,1);

        force_event = pelvis_angle(heel_strike:frames,:);

        tt = linspace(0,100,size(force_event,1));


        for ii = 1:size(force_event,2)
            pelvis_normalised(:,ii)= spline(tt,force_event (:,ii), xx);
        end
        
        
              xlswrite(filename,pelvis_normalised,3);

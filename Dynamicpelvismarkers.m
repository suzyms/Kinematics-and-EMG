SDK=ViconNexus();

subject = 'Fullbody';
%% Import Marker Trajectories from Dynamic Trial

[startframe, endframe] = SDK.GetTrialRegionOfInterest;                     
ROIframes = double(startframe:endframe)';                                  
framecount1 = length(ROIframes);
start_frame=double(startframe);
end_frame=double(endframe);
[XRP11, YRP11, ZRP11] = SDK.GetTrajectory( subject, 'RPSIS' );
[XRP22, YRP22, ZRP22] = SDK.GetTrajectory( subject, 'RASIS' );
[XRP33, YRP33, ZRP33] = SDK.GetTrajectory( subject, 'LASIS' );


%% 
 
    
origin=zeros(end_frame,3);
RPSIS=zeros(end_frame,4);
LPSIS=zeros(end_frame,4);

for i=1:endframe
    
% Define local origin 
    origin(i,:)=[XRP11(1,i)+XRP33(1,i), YRP11(1,i)+YRP33(1,i), ZRP11(1,i)+ZRP33(1,i)]/2;
    

% Define local coordinate frame
vecZ=[(XRP11(1,i)-origin(i,1)) (YRP11(1,i)-origin(i,2)) (ZRP11(1,i)-origin(i,3))]; 
axisZ=vecZ/ norm(vecZ);

vecY= [(XRP22(1,i)-origin(i,1)) (YRP22(1,i)-origin(i,2)) (ZRP22(1,i)-origin(i,3))];


vecX=cross(axisZ, vecY);
axisX=vecX/norm(vecX);

axisY=cross(axisZ, axisX);

%Local to Global transformation matrix
dynamic_local2global=[axisX(1) axisY(1) axisZ(1) origin(i,1)
                     axisX(2) axisY(2) axisZ(2) origin(i,2)
                     axisX(3) axisY(3) axisZ(3) origin(i,3)
                         0          0        0        1];
                     


%Marker locations in time frame

RPSIS(i,:)=(dynamic_local2global*static_RPSIS_L2G)'; 

 
LPSIS(i,:)=(dynamic_local2global*static_LPSIS_L2G)'; 
 
end

%Set coordinates to variable so Nexus recognises them
RX=RPSIS(:,1)';
RY=RPSIS(:,2)';
RZ=RPSIS(:,3)';
LX=LPSIS(:,1)';
LY=LPSIS(:,2)';
LZ=LPSIS(:,3)';

%Set logicals so Nexus knows if marker is present in that frame

f=zeros(1,start_frame);
F=false(size(f));
t=ones(1,end_frame-start_frame);
T=true(size(t));
E=[F T];

% Export trajectories to Nexus

 %  SDK.SetTrajectory(subject,'RPSIS',RX,RY,RZ,E);
 
    SDK.SetTrajectory(subject,'LPSIS',LX,LY,LZ,E);
 
 
          
   


        
          
          
          
          
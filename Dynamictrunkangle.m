SDK=ViconNexus();

subject = 'Fullbody';
%% Import Marker Trajectories from Dynamic Trial

[startframe, endframe] = SDK.GetTrialRegionOfInterest;                     
ROIframes = double(startframe:endframe)';                                  
framecount1 = length(ROIframes);
start_frame=double(startframe);
end_frame=double(endframe);
[events] = SDK.GetEvents('Fullbody', 'Right', 'Foot Strike');


[XMA, YMA, ZMA] = SDK.GetTrajectory( subject, 'MA' );
[XRA, YRA, ZRA] = SDK.GetTrajectory( subject, 'RASIS' );

%%
%Define dynamic angle

for i=1:endframe
       
    dynamic_angle(i)=atand((YMA(i)-YRA(i))/(ZMA(i)-ZRA(i)));
    
    MA_angle(i)=dynamic_angle(i)-static_angle;
    
end    
   
   MA_cropped=MA_angle';   
   
trunk_angle=MA_cropped((events(1):events(2)),:);
%%
%normalise to gait cycle
filename='...';

heel_strike=1;
    
        xx = 0:1:100;

        
        frames = size(trunk_angle,1);

        force_event = trunk_angle(heel_strike:frames,:);

        tt = linspace(0,100,size(force_event,1));


        for ii = 1:size(force_event,2)
            trunk_normalised(:,ii)= spline(tt,force_event (:,ii), xx);
        end
        
        
             xlswrite(filename,trunk_normalised,3);
         
       


 

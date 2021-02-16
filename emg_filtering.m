
input_folder = '...';
input_trial = '...';
filename= '...'
output_folder ='...';

btk_load = [input_folder,'\',input_trial,'.c3d'];

acq = btkReadAcquisition(btk_load);
sample_freq = btkGetPointFrequency(acq)
analog_freq = btkGetAnalogFrequency(acq)
start = btkGetFirstFrame(acq);      % These use relative frame numbering. So if you want Nexus frame # 200, you need to go "200 - start + 1"
finish = btkGetLastFrame(acq);
[events] = btkGetEvents(acq);

foot_strike1 = round(events.Right_Foot_Strike(1)*sample_freq);
foot_strike2 = round(events.Right_Foot_Strike(2)*sample_freq);
foot_off = round(events.Right_Foot_Off(1)*sample_freq);

start_frame = ((foot_strike1-2)-start+1)*17;
stance_end = (foot_off+2)-start+1;
gait_end = ((foot_strike2)-start)*17;

stance = start_frame:stance_end;
gait = start_frame:gait_end;
    
raw_data=btkGetAnalogsValues(acq);
names=btkGetAnalogs(acq);
raw_emg=[names.Sensor_1_EMG1 names.Sensor_2_EMG2 names.Sensor_3_EMG3 names.Sensor_4_EMG4];
raw_emg=raw_emg(gait,:);
%% 
%save each step of processing as new variable to allow for inspection 
emg_abs=[];
emg_lowpass=[];
emg_normalised=[];
emg_integrated=[];
emg_gait=[];

for ii=1:4 
    
            
         emg_abs(:,ii)=abs(raw_emg(:,ii));
         [B_butter,A_butter]=butter(4,4*2/120,'low');
         emg_lowpass(:,ii)=filtfilt(B_butter,A_butter, emg_abs(:,ii));

%        max_0kg(ii)=max(emg_normalised(:,ii));
         
        
        emg_lowpass(:,ii)=abs(emg_lowpass(:,ii));
        emg_integrated(:,ii)=trapz(emg_lowpass(:,ii));
        emg_normalised(:,ii)=emg_normalised(:,ii)/max_0kg(ii);
          
end

       
       xx = 0:1:100;
       
        tt = linspace(0,100,size(emg_normalised,1));


        for ii = 1:4
            emg_gait(:,ii)= spline(tt,emg_normalised (:,ii), xx);
        end
        
                    xlswrite(filename,emg_gait,3);





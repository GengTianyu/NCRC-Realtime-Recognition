clear all;clc;
global params;
load STSF_params; %���ʱ��ƽ������ģ��
%% Feature parameter
ispool1 = 1;
ispool2 = 1;
poolsize1 = 2;
poolsize2 = 2;
imsize0 = [29 29];  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��Ҫ��1��nminist34*34 gesture128*128��
imsize1 = ceil(imsize0/poolsize1);
imsize2 = ceil(imsize1/poolsize2);

isdenoise = 0;

%% parameter
nOutputs = 10;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��Ҫ��2����������
%%
data_directory = 'D:/study/holiday2020/AER_DATA/Final_DVS_Cat/ExperienceData/MNIST_DVS/MNIST_DVS_full';%%%%%%%%%%%%%%%%��Ҫ��3�����ݼ���
working_directory = 'D:/study/holiday2020/AER_DATA/Final_DVS_Cat/MY_OutPut/HOTS_TEMPTRON_MNISTDVSfull(RealTime)';%%%%%%%%%%%%%%%%%%%%��Ҫ��4�����ɵĽ����



%%
reRunAll         = 1;
reSimRealTime    = 1;
reGenPtnCell     = 1;
reGetFeature     = 1;


%%
%if reSimRealTime %��ģ��ʵʱ

    fprintf('Start GetAPtn ...');
for k = 1:20 %ʵʱ��ʾ20��
    if reGenPtnCell 
        classes = dir(data_directory);
        classes(1:2) = [];
        a = randperm(length(classes),1);
        files = dir([data_directory, '/', classes(a).name]);
        files(1:2) = [];
        b = randperm(length(files),1);
        load([data_directory, '/', classes(a).name, '/', files(b).name]);
        ptn = D_pre_process(TD,isdenoise);
        clear TD
    end

% else
%     %TD�ǻ�õ�һ��������
%     ptn = D_pre_process(TD,isdenoise); %������ʵDVS��ʾ��TD�ǻ�õ�������
%     ptn.p = ptn.p+1;
%     %��ʵ�ߴ������ѵ����ģ����������ߴ粻һ�� ���ܻ���Ҫ����һ��
%     clear TD
%end
%% Get Feature
if reRunAll || reSimRealTime
    ptn  = Sim_timesurface(ptn,1,ispool1,poolsize1,5e3);
    ptn  = Sim_timesurface(ptn,2,ispool2,poolsize2,5e3);
end
% 
% %%
load PtnCell_raw %������ݵ����ʱ���

AllVec = zeros(length(ptn.ts), 1);
AllAddr = zeros(length(ptn.ts), 1);
for i = 1:length(ptn.ts)
    x = ptn.x(i); y = ptn.y(i); t = ptn.ts(i); p = ptn.p(i);
    AllVec(i) = t;
    AllAddr(i) = (p-1)*imsize2(1)*imsize2(2)+(x-1)*imsize2(2)+y;
end
TD.AllVec  = AllVec/1e3;
TD.AllAddr = AllAddr;
TD.Time_Chnl_Lbl = a-1;

TD.AllVec(:) = ceil(255/maxT * TD.AllVec(:));

%% realtime test
load TrainedWt;
if reRunAll || reSimRealTime
    timedLog('Start RealTime Simulation ..');
    Sim_EventDrivenTempotron(TrainedWt, TD);
end
end
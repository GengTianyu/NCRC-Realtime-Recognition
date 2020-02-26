function [ ] = MyNormSpkPtn(datafolder)
fprintf('\nNormolize spk Start (PtnCell_raw --> PtnCell_spk) ...\n');

if ~exist('datafolder','var')
    datafolder = pwd;
end
load ([datafolder,'/','PtnCell_raw'], 'PtnCellTrn', 'PtnCellTst', 'indTrn', 'indTst','maxT')

numTrn = length(PtnCellTrn);%ѵ����������
numTst = length(PtnCellTst);%������������

for i = 1:numTrn
 
    %ֵԽ�󷢷�ʱ��Լ��1~256
    %PtnCellTrn{i}.AllVec(:,j) = round( 256- 255/maxResp * PtnCellTrn{i}.AllVec(:,j)  );
    %�������ʱ����Ϣ�Ļ�
    PtnCellTrn{i}.AllVec(:) = ceil(255/maxT * PtnCellTrn{i}.AllVec(:));
    
end

for i = 1:numTst
    PtnCellTst{i}.AllVec(:) = ceil(255/maxT * PtnCellTst{i}.AllVec(:));
end
save ([datafolder,'/','PtnCell_spk'], 'PtnCellTrn', 'PtnCellTst', 'indTrn', 'indTst')
end

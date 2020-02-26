function [PtnCellTrn, PtnCellTst, indTrn, indTst,maxT] = RandSplit(PtnCell,ratio_Trn,nGroup)

fprintf('\nRandomly splitting the dataset-->PtnCell_raw... ...\n');
N = length(PtnCell);%������������
Labels = zeros(1,N);%�������ı�ǩ
maxT = -inf;
for i = 1:N %�������������������б�ǩ�浽Labels��
    B = PtnCell{i}.Time_Chnl_Lbl;
    Labels(i) = B;
    AllVec = PtnCell{i}.AllVec;%����ȡ��ÿ���������������ʱ��
    maxT = max(maxT,max(AllVec(:)));

end

indTrn = zeros(1, round(N*ratio_Trn)); %ѵ����������������������
indTst = zeros(1, N-round(N*ratio_Trn)); %������������������������
count1 = 0;
count2 = 0;
for i = 1:nGroup
    ind = find(Labels==(i-1));%�������� �����������е�����
    n0 = length(ind); %ÿ��������

    n1 = round(n0*ratio_Trn);%ÿ���е�ѵ��������
    n2 = n0-n1;%ÿ���еĲ���������
    
    ind2 = randperm(n0);
    indTrn(count1+1:count1+n1) = ind(ind2(1:n1));%����ȫ��ѵ�����������������е�������
    indTst(count2+1:count2+n2) = ind(ind2(n1+1:n0));%����ȫ�����Լ��������������е�������
    count1 = count1+n1;
    count2 = count2+n2;
end

indTrn = indTrn(1:count1);
indTst = indTst(1:count2);

numTrn = length(indTrn);
numTst = length(indTst);

indTrn = indTrn(randperm(numTrn));
indTst = indTst(randperm(numTst));

PtnCellTrn = PtnCell(indTrn);%һ��cell
PtnCellTst = PtnCell(indTst);%һ��cell

end
    
    
    



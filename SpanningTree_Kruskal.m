edge = textread('net1.txt'); %#ok<DTXTRD>
% net1.txt������ı�Ȩ�ļ���ÿ��Ϊһ���ߣ���1��2�зֱ�Ϊ�ߵ�
% ���˶����ţ���������ΪȰ����Ȩ��С��������
NodeNum = max(max(edge(:,1:2)));  % ���綥����
e1 = length(edge(:,1));  % �������

p = 1;  % p�ǵ�ǰ��ͨ�����ı��
TreeNode = [edge(1,1) p edge(1,2) p];  % ��ǰ�����Ķ��㼯
TreeEdge = edge(1,:);  %��ǰ�����ı߼�

for i = 2:e1
    if length(TreeEdge(:,1))<NodeNum-1  % ���Խ���ǰ�߼����������Ƿ���γ�Ȧ
        k1 = 0;
        k2 = 0;
        for j = 1:length(TreeNode(:,1))
            if edge(i,1) == TreeNode(j,1)
                k1 = 1;
                p1 = TreeNode(j,2);            
            end
        end
        for j = 1:length(TreeNode(:,1))
            if edge(i,2) == TreeNode(j,1)
                k2 = 1;
                p2 = TreeNode(j,2);
            end
        end        
        % ��ǰ�ߵ�2�����㶼�������γɵ�������
        if k1 + k2 == 0
            TreeEdge = [TreeEdge edge(i,:)];
            p = max(TreeNode(:,2))+1;
            TreeNode = [TreeNode edge(i,1) p edge(i,2) p];
        end       
        % ��ǰ�ߵ�һ�����㲻�����γɵ�������
        if k1 + k2 == 1
            TreeEdge = [TreeEdge edge(i,:)];
            if k1 == 1
                p = p1;
                TreeNode = [TreeNode edge(i,2) p];
            else
                p = p2;
                TreeNode = [TreeNode edge(i,1) p];
            end
        end
        %��ǰ�ߵ�2������ֱ��������γɵĲ�ͬ����ͨ������
        if k1 + k2 == 2 && p1 ~= p2
            TreeEdge = [TreeEdge edge(i,:)];
            if p1<p2
                t = find(TreeNode(:,2));
                TreeNode(t,2) = p1;
            else
                t = find(TreeNode(:,2)==p1);
                TreeNode(t,2) = p2;
            end
        end
    end
end
dlmwrite('Net1_Tree1.txt',TreeEdge,'\t')
edge = textread('net1.txt'); %#ok<DTXTRD>
% net1.txt是网络的边权文件，每行为一条边，第1、2列分别为边的
% 两端顶点编号，第三条边为劝，边权由小到大排列
NodeNum = max(max(edge(:,1:2)));  % 网络顶点数
e1 = length(edge(:,1));  % 网络边数

p = 1;  % p是当前连通子树的编号
TreeNode = [edge(1,1) p edge(1,2) p];  % 当前子树的顶点集
TreeEdge = edge(1,:);  %当前子树的边集

for i = 2:e1
    if length(TreeEdge(:,1))<NodeNum-1  % 测试将当前边加入子树，是否会形成圈
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
        % 当前边的2个顶点都不在已形成的子树中
        if k1 + k2 == 0
            TreeEdge = [TreeEdge edge(i,:)];
            p = max(TreeNode(:,2))+1;
            TreeNode = [TreeNode edge(i,1) p edge(i,2) p];
        end       
        % 当前边的一个顶点不在已形成的子树中
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
        %当前边的2个顶点分别属于已形成的不同的连通子树中
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
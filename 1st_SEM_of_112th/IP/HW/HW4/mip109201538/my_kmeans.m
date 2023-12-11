% Input: 
%   X:         d x n matrix, each row is a dimension and each column is a data point
%   k:         number of clusters
%   num_trial: number of runs with different initial centers
% 輸入：
%   X:         d x n矩陣，每一列為一個維度，每一行為一個資料點（向量）
%   k:         想要分成的群數
%   num_trial: 要試幾次不同的初始中心 
%
% Output:
%   idx:     1 x n vector, each element is the index of cluster that the
%   corresponding data vector belongs to
%   centers: d x k matrix representing k cluster centers
%   varr:     the intra-cluster variance achieved by the cluster centers
% 輸出：
%   idx:     1 x n向量，每一個元素表示相對應的資料點被分到哪一群
%   centers: d x k矩陣，表示k個d維度的中心點
%   varr:     所有intra-cluster距離平方總和，也就是intra-cluster variance
function [idx, centers, varr] = my_kmeans(X, k, num_trial)

rng shuffle

assert (k > 0);
assert (length(size(X)) == 2);

% TODO: 賦予d和n正確的值
sizes = size(X);
d = sizes(1); % dimension
n = sizes(2); % number of data point

% TODO: 初始化varr，令它為Inf，因為之後如果算出更小的intra-cluster variance我們就要
% 更新這個varr
varr = inf;

% TODO:
% 這裡創建一個外層迴圈，每跑一次表示以某一組初始中心為起點的run，總共跑num_trial次
for i = 1:num_trial

    % TODO:
    % 初始化k個中心點，可以從X中隨機選擇k個點，記錄在cur_centers，其格式與centers相同
    cur_centers = X(:,randi(n,1,k));

    % TODO:
    % 計算每一個資料點距離哪一個cur_centers中的中心最近，記錄在cur_idx中，其格式與idx
    % 相同
    cur_idx = zeros(1,n);
    for j = 1:n
        tmp_distance = zeros(1,k);
        for l = 1:k
            tmp_distance(l) = norm(X(:,j)-cur_centers(:,l));
        end
        [~,cur_idx(1,j)] = min(tmp_distance);
    end

    % TODO: 這裡創建一個內層迴圈
    cond = false;
    while ~cond


        % TODO:
        % 把cur_centers更新為每個群其所有資料點的向量的平均值
        for j = 1:k
            tmp_cur_idx = find(cur_idx == j);
            cur_centers(:,j) = sum(X(:,tmp_cur_idx),2)./length(tmp_cur_idx);
        end

        % TODO:
        % 計算每一個資料點距離哪一個cur_centers中的中心最近，記錄在new_idx中，其格式
        % 與idx相同
        % 同時計算新的intra-cluster variance，令為cur_varr
        
        cur_varr = 0;
        new_idx = zeros(1,n);
        for j = 1:n
            tmp_distance = zeros(1,k);
            for l = 1:k
                tmp_distance(l) = norm(X(:,j)-cur_centers(:,l));
            end
            [min_distance,new_idx(1,j)] = min(tmp_distance);
            cur_varr = cur_varr + min_distance;
        end
        
        % TODO: 如果每個資料點都沒有離開原來的群，那就跳出這個內層回圈
        % 否則的話，在重跑一次內層回圈之前，該做什麼事？ 
        % willy:邏輯判斷、更新？
        cond = cur_idx == new_idx;
        cur_idx = new_idx;
    end
    

    % TODO:
    % 這裡是內層回圈的外面，但還沒離開外層回圈，也就是對於某一組初始中心，所有該做的事情
    % 已經做完了
    % 除了幾件事，是什麼？ 
    % willy:輸出？
    if cur_varr < varr
        idx = new_idx;
        centers = cur_centers;
        varr = cur_varr;
    end

% 這裡已經離開外層回圈，沒事做了。
end
return;

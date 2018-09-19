% function to run KNN classification


function pred_label = cse408_knn(test_feat, train_label_set, train_feat_set, k, DstType)

[rows, columns] = size(train_feat_set)

dist = [];
if DstType == 1 %SSD
    %PUT YOUR CODE HERE
    for i = 1:columns
       %[s,r] = sumsqr({test_feat, train_feat_set(:,i)});
        X = test_feat - train_feat_set(:,i);
        ssd = sum(X(:).^2);
       dist = [dist, ssd];
    end
    
elseif DstType == 2 %Angle Between Vectors
    %PUT YOUR CODE HERE 
    for i = 1:columns
        cosTheta = dot(test_feat,train_feat_set(:, i))/(norm(test_feat)*norm(train_feat_set(:, i)));
        dist = [dist, cosTheta]
    end
elseif DstType == 3 %Number of words in common
    %PUT YOUR CODE HERE
    for i = 1:columns
        count = 0;
        for j = 1:length(test_feat)
            if test_feat(j) > 0
                if train_feat_set(j, i) > 0
                    count = count + 1;
                end
            end
        end
        dist = [dist, count]
    end
    dist = -dist; % Minus so you want most matches to appear first
end

%Find the top k nearest neighbors, and do the voting. 
[B,I] = sort(dist);

posCt=0;
negCt=0;
for ii = 1:k
    if train_label_set(I(ii)) == 1
        posCt = posCt + 1;
    elseif train_label_set(I(ii)) == 0
        negCt = negCt + 1;
    end    
end

if posCt >= negCt
    pred_label = 1;
else
    pred_label = 0;
end

% 1 is for positive
% 0 is for negative
disp(posCt)
disp(negCt)
disp(pred_label)
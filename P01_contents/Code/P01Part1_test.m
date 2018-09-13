clear all
% paths to the folders with reviews
% make sure you are in the right dir, or use full path to make sure it reads content
% correctly
posFolder = '../Data/kNN/training/pos';

negFolder = '../Data/kNN/training/neg';


% build lexicon first for positive files and then add the lexicon for
% negative reviews
voc = {}; %vocabulary is cell array of character vectors.
voc = buildVoc(posFolder,voc);
voc = buildVoc(negFolder,voc);
display( voc );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute BOW feature vectors for training files

train_feat_set = [];
train_label_set = [];

% get the file list for positive reviews folder
files = dir(fullfile(posFolder,'*.txt'));

% compute BOW feature vector for each file
for file = files'
    train_label_set = [train_label_set,1];
    feat_vec = cse408_bow(fullfile(posFolder,file.name), voc);
    train_feat_set = [train_feat_set,feat_vec'];
end

% get files for negative reviews
files = dir(fullfile(negFolder,'*.txt'));

% compute BOW feature vector for each file
for file = files'
    train_label_set = [train_label_set,0];
    feat_vec = cse408_bow(fullfile(negFolder,file.name), voc);
    train_feat_set = [train_feat_set,feat_vec'];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute BOW feature vectors for test files

posFolder = '..\Data\kNN\testing\pos';
negFolder = '..\Data\kNN\testing\neg';

test_feat_set = [];
test_label_set = []; % this is the set of ground truth labels for the test set

% get files for positive reviews
files = dir(fullfile(posFolder,'*.txt'));

% compute BOW feature vector for each file
for file = files'
    test_label_set = [test_label_set,1];
    feat_vec = cse408_bow(fullfile(posFolder,file.name), voc);
    test_feat_set = [test_feat_set,feat_vec'];
end

% get files for negative reviews
files = dir(fullfile(negFolder,'*.txt'));

% compute BOW feature vector for each file
for file = files'
    test_label_set = [test_label_set,0];
    feat_vec = cse408_bow(fullfile(negFolder,file.name), voc);
    test_feat_set = [test_feat_set,feat_vec'];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
correct_ct = 0; % counter for correct classifications
DistType = 3; % test different distance type
K = 3; % test different K.

% Now we go over each test file to compute its label and check for
% correctness
for i = 1:size(test_feat_set,2)

    pred_label = cse408_knn(test_feat_set(:,i),train_label_set,train_feat_set,K, DistType);
    if pred_label == test_label_set(i)
        correct_ct = correct_ct + 1;
    end
    disp(['Document ', int2str(i), ' groundtruth ', int2str(test_label_set(i)), ' predicted as ', int2str(pred_label)]);
end
accuracy = correct_ct / size(test_label_set,2);
disp(accuracy);

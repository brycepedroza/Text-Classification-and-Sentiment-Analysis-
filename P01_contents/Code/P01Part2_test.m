clear all

% make sure you are in the right directory or use full path
posFolder = '../Data/pos';
negFolder = '../Data/neg';



files = dir(fullfile(posFolder,'*.txt'));

feat = [];
label = [];
for file = files'
    sent_score = sentimentAnalysis(fullfile(posFolder,file.name));
    display(file.name);
    display(['Groundtruth: Positive, sentiment score: ', num2str(sent_score)]);
end

files = dir(fullfile(negFolder,'*.txt'));

for file = files'
    sent_score = sentimentAnalysis(fullfile(negFolder,file.name));
    display(file.name);
    display(['Groundtruth: Negtive, sentiment score: ', num2str(sent_score)]);
end
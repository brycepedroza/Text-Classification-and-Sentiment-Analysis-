% function sentimentAnalysis
% Input: a path to the target text file
% Output: a sentiment score of the text

function sent_score = sentimentAnalysis(filename)

% make sure you are in the right directory or use full path
lexicon = '..\Data\SA\wordwithStrength.txt';

[fid, msg] = fopen(lexicon, 'rt');
error(msg);
line = fgets(fid); % Get the first line from
 % the file.
%Initialize a Map structure to store the lexicon
cM = containers.Map();
while line ~= -1

    %fprintf('%s', line); % Print the line on
    ii = 1;
    token={};
    while any(line)
        [token{ii}, line] = strtok(line);
        % Repeatedly apply the
        ii = ii + 1; % strtok function.
    end
    cM(token{1}) = str2double(token{2});
    
    line = fgets(fid); % Get the next line
    % from the file.
end
fclose(fid);


[fid, msg] = fopen(filename, 'rt');
error(msg);
line = fgets(fid); % Get the first line from
 % the file.
test_token={};
ii = 1;
while line ~= -1
     %Store each word in the test_token array
     %PUT YOUR IMPLEMENTATION HERE
end
fclose(fid);

sent_score = 0;
for k=1:length(test_token)
    %PUT YOUR IMPLEMENTATION HERE
end 

% feel free to format output as you see fit
if sent_score > 0
    if sent_score > 0.7
        fprintf('File %s \n Sentiment Score: %8.2f Highly Positive Sentiment\n',filename,sent_score);
    else
        fprintf('File %s \n Sentiment Score: %8.2f Positive Sentiment\n',filename,sent_score);
    end
end
if sent_score < 0
    if sent_score < -0.7
        fprintf('File %s \n Sentiment Score: %8.2f Highly Negative Sentiment\n',filename,sent_score);
    else
        fprintf('File %s \n Sentiment Score: %8.2f Negative Sentiment\n',filename,sent_score);
    end
end
if sent_score == 0
    fprintf('File %s \n Sentiment Score: %8.2f Neutral Sentiment\n',filename,sent_score);
end
end
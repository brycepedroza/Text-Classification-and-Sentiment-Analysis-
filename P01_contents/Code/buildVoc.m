% function to create a vocabulary from multiple text files under folders

function voc = buildVoc(folder, voc)

stopword = {'ourselves', 'hers', 'between', 'yourself', 'but', 'again', 'there', ...
    'about', 'once', 'during', 'out', 'very', 'having', 'with', 'they', 'own', ...
    'an', 'be', 'some', 'for', 'do', 'its', 'yours', 'such', 'into', ...
    'of', 'most', 'itself', 'other', 'off', 'is', 's', 'am', 'or', ...
    'who', 'as', 'from', 'him', 'each', 'the', 'themselves', 'until', ...
    'below', 'are', 'we', 'these', 'your', 'his', 'through', 'don', 'nor', ...
    'me', 'were', 'her', 'more', 'himself', 'this', 'down', 'should', 'our', ...
    'their', 'while', 'above', 'both', 'up', 'to', 'ours', 'had', 'she', 'all', ...
    'no', 'when', 'at', 'any', 'before', 'them', 'same', 'and', 'been', 'have', ...
    'in', 'will', 'on', 'does', 'yourselves', 'then', 'that', 'because', ...
    'what', 'over', 'why', 'so', 'can', 'did', 'not', 'now', 'under', 'he', ...
    'you', 'herself', 'has', 'just', 'where', 'too', 'only', 'myself', ...
    'which', 'those', 'i', 'after', 'few', 'whom', 't', 'being', 'if', ...
    'theirs', 'my', 'against', 'a', 'by', 'doing', 'it', 'how', ...
    'further', 'was', 'here', 'than', ''}; % define English stop words, from NLTK

%% Grab all non stopwords and unique words
words = [];

files = dir(fullfile(folder,'*.txt'));
for file = files'
    [fid, msg] = fopen(fullfile(folder,file.name), 'rt');
    error(msg);
    line = fgets(fid); % Get the first line from
     % the file.
    while line ~= -1
        %PUT YOUR IMPLEMENTATION HERE
        
        % THIS LINE REQUIRES TEXT ANALYTICS TOOLBOX
        line = erasePunctuation(line); 
        line = strsplit(line);
        for i = 1:length(line)
            % if word not in stopword
            if ~any(strcmp(stopword,line(i)))
                words = [words, line(i)];
            end

        end
        line = fgets(fid);
    end
    fclose(fid);
end

% Getting unique words
unique_words = unique(words);


%% Populating Map for Word Freq.
word_freq = zeros(1,length(unique_words),'int8');
% Mapping Zeros to unique words
word_map = containers.Map(unique_words,word_freq);
for i = 1:length(words)
    word_map(words{1,i}) = word_map(words{1,i}) + 1;
end

%% Saving Words that appear as least an many times as the threshold to voc
% Change this how we see fit
threshold = 2;
k = keys(word_map);
v = values(word_map);
j = 1;
for i=1:length(word_map)
    % If word is present more than one time
    if v{i} >= threshold
       %fprintf('#%d. \t%s %d\n',j, k{i}, v{i}) 
       %j = j+1;
       % Add the word to the voc
       voc{end+1} = k{i};
    end
end

end

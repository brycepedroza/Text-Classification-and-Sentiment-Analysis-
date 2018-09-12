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

words = []

files = dir(fullfile(folder,'*.txt'));
for file = files'
    [fid, msg] = fopen(fullfile(folder,file.name), 'rt');
    error(msg);
    line = fgets(fid); % Get the first line from
     % the file.
    while line ~= -1
        %PUT YOUR IMPLEMENTATION HERE
        
        % REQUIRES TEXT ANALYTICS TOOLBOX
        line = erasePunctuation(line); 
        line = strsplit(line);
        preProLine = [];        
        for i = 1:length(line)
            % if word not in stopword
            if ~any(strcmp(stopword,line(i)))
                % if word is also not already a part of the voc
                if ~any(strcmp(words,line(i)))
                    words = [words, line(i)]
%                 preProLine{end+1} = line(i);
                end
            end  
        end
%         voc{end+1} = preProLine;
        line = fgets(fid);
    end
    fclose(fid);
end
disp(words);

end

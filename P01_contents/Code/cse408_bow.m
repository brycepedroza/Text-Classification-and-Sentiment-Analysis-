% function to create a vocabulary from multiple text files under folders

function feat_vec = cse408_bow(filepath, voc)

[fid, msg] = fopen(filepath, 'rt');
error(msg);
line = fgets(fid); % Get the first line from
 % the file.
feat_vec = zeros(size(voc)); %Initialize the feature vector'

while line ~= -1
    %PUT YOUR IMPLEMENTATION HERE
    line = erasePunctuation(line); 
    line = strsplit(line);
     for i = 1:length(line)
        % if word in voc
        if any(strcmp(voc,line(i)))
            % Gets the index for the word in voc, 
            % then increments that index
            feat_vec(find(strcmp(voc, line(i)))) = feat_vec(find(strcmp(voc, line(i)))) + 1;
        end
     end
     line = fgets(fid);

end
fclose(fid);
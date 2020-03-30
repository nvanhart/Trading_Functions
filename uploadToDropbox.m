function output = uploadToDropbox(dataFile,filePath)
%
% Ex: uploadToDropbox('testFile.csv','TestUploads/ExampleFolder')
%
% 
% 
% To generate a Dropbox access token
%* Go to www.dropbox.com/developers/apps in a web browser
%* Click on "Create app"
%* Select "Dropbox API" and "App folder" for options (1) and (2)
%* Specify the name of the folder you want your files to show up in
%* Click on the "Generate Access Token" on the page and note down the access token

% Define Access Token - MAKE SURE THIS IS UPDATED

dropboxAccessToken = 'fdasfdsfdfdsfds'; %defines custome dropbox access token

% Read file contents
try
    fid = fopen(dataFile, 'r');
    data = char(fread(fid)');
    fclose(fid);
catch someException
    throw(addCause(MException('uploadToDropbox:unableToReadFile','Unable to read input file.'),someException));
end

% Generate the custom header
[~,remoteFName, remoteExt] = fileparts(dataFile);
headerFields = {'Authorization', ['Bearer ', dropboxAccessToken]};
headerFields{2,1} = 'Dropbox-API-Arg';
% set file path below, dropbox is NOT case sensitive
headerFields{2,2} = sprintf('{"path": "/%s/%s%s", "mode": "add", "autorename": true, "mute": false}',filePath,remoteFName, remoteExt);
headerFields{3,1} = 'Content-Type';
headerFields{3,2} = 'application/octet-stream';
headerFields = string(headerFields);

% Set the options for WEBWRITE
opt = weboptions;
opt.MediaType = 'application/octet-stream';
opt.CharacterEncoding = 'ISO-8859-1';
opt.RequestMethod = 'post';
opt.HeaderFields = headerFields;

% Upload the file
try
    tempOutput = webwrite('https://content.dropboxapi.com/2/files/upload', data, opt);
catch someException
    throw(addCause(MException('uploadToDropbox:unableToUploadFile','Unable to upload file.'),someException));
end

% If user requested output, pass along WEBWRITE output
if isequal(nargout,1)
    output = tempOutput;
end;
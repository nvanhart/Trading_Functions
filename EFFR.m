function rate = EFFR()
%% Effective Federal Funds Rate
%  A script to get the most recent federal funds overnight rate from the
%  New York Federal Reserve Bank.
%% Section 1: Get Rate
url = 'https://apps.newyorkfed.org/markets/autorates/fed%20funds'; 
r1 = datetime('now','Format','MM/dd')-1; %last updated rate

if weekday(r1) == 2 %if today is monday
    r0 = char(r1-3); %previous day is friday
    r1 = char(r1);
else
    r0 = char(r1-1); 
    r1 = char(r1);
end
filt = '%s<sup class="paraNotes-markets"></sup>.*%s<sup class="paraNotes-markets"></sup>';
filt = sprintf(filt,r1,r0);
raw0 = webread(url);
raw1 = char(regexp(raw0,filt,'match'));
raw2 = raw1(350:400); %extracts current rate region to account for white spaces
raw3 = regexp(raw2,'\d*','match'); %extracts numerics
rate = str2double(string([char(raw3(1)),'.',char(raw3(2))])); %combines char strings, converts to double
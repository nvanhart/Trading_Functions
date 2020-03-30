function sendTextsList(list,message)
%% Description  
%    sendTextsList(LIST(number,carrier),MESSAGE) sends a text message
%    to mobile devices in USA. NUMBER is your 10-digit cell phone number,
%    formatted with no dashes or country code (6169391001) CARRIER is your
%    cell phone service provider, which can be one of the following:
%    'Alltel', 'AT&T', 'Boost', 'Cingular', 'Cingular2', 'Nextel', 'Sprint', 
%    'T-Mobile', 'Verizon', or 'Virgin'. SUBJECT is the subject of the
%    message, and MESSAGE is the content of the message to send. LIST must be
%    in .csv format, with column 1 = NUMBER and column 2 = CARRIER, in 'quotes'
% 
%    Example:
%      sendTextsList('subscription.csv',"hello")
%         'Calculation Done','Don't forget to retrieve your result file'
%
% =========================================================================
mail = 'xxxxxxx@gmail.com';  
password = 'xxxxxxx';       
% =========================================================================
%% Runs list loop

list = readtable(list); %reads file
number = list.Number; %vector of numbers
carrier = list.Carrier; %vector of carriers

for i = 1:size(list)
    
% Information found from
% http://www.sms411.net/2006/07/how-to-send-email-to-phone.html
switch strrep(strrep(lower(char(carrier(i))),'-',''),'&','')
    case 'alltel';      emailto = strcat(string(number(i)),'@message.alltel.com');
    case 'att';         emailto = strcat(string(number(i)),'@mmode.com');
    case 'boost';       emailto = strcat(string(number(i)),'@myboostmobile.com');
    case 'cingular';    emailto = strcat(string(number(i)),'@cingularme.com');
    case 'cingular2';   emailto = strcat(string(number(i)),'@mobile.mycingular.com');
    case 'nextel';      emailto = strcat(string(number(i)),'@messaging.nextel.com');
    case 'sprint';      emailto = strcat(string(number(i)),'@messaging.sprintpcs.com');
    case 'tmobile';     emailto = strcat(string(number(i)),'@tmomail.net');
    case 'verizon';     emailto = strcat(string(number(i)),'@vtext.com');
    case 'virgin';      emailto = strcat(string(number(i)),'@vmobl.com');
    case '@vzwpix.com'; emailto = strcat(string(number(i)),'@vtext.com');
end

%% Set up Gmail SMTP service.
% If you have your own SMTP server, replace it with yours.

% Then this code will set up the preferences properly:
mail = 'research.vhventures@gmail.com';    %Your gmail email address
password = 'eGGplant13'; 

setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);

% The following five lines are necessary only if you are using GMail as
% your SMTP server. Delete these lines if you are using your own SMTP
% server.
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.starttls.enable','true'); 
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

%% Send the message
subject = '';
sendmail(emailto,subject,message)

end
end
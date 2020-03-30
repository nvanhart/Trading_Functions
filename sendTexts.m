function sendTexts(number,carrier,subject,message)
%% Description  
%    sendTexts(NUMBER,CARRIER,SUBJECT,MESSAGE) sends a text message
%    to mobile devices in USA. NUMBER is your 10-digit cell phone number.
%    CARRIER is your cell phone service provider, which can be one of the
%    following: 'Alltel', 'AT&T', 'Boost', 'Cingular', 'Cingular2',
%    'Nextel', 'Sprint', 'T-Mobile', 'Verizon', or 'Virgin'. SUBJECT is the
%    subject of the message, and MESSAGE is the content of the message to
%    send.
% 
%    Example:
%      send_text_message('234-567-8910','Cingular', ...
%         'Calculation Done','Don't forget to retrieve your result file')
%      send_text_message('234-567-8910','Cingular', ...
%         'This is a text message without subject')
%
% You must modify the first two lines of the code (code inside the double 
% lines) before using.
% =========================================================================
% YOU NEED TO TYPE IN YOUR OWN EMAIL AND PASSWORDS:
mail = 'xxxxxx@gmail.com'; 
password = 'xxxxxx';       
% =========================================================================

if nargin == 3
    message = subject;
    subject = '';
end

% Format the phone number to 10 digit without dashes
number = strrep(number, '-', '');
if length(number) == 11 && number(1) == '1';
    number = number(2:11);
end

% Information found from
% http://www.sms411.net/2006/07/how-to-send-email-to-phone.html
switch strrep(strrep(lower(carrier),'-',''),'&','')
    case 'alltel';       emailto = strcat(number,'@message.alltel.com');
    case 'att';          emailto = strcat(number,'@mmode.com');
    case 'boost';        emailto = strcat(number,'@myboostmobile.com');
    case 'nextel';       emailto = strcat(number,'@messaging.nextel.com');
    case 'sprint';       emailto = strcat(number,'@messaging.sprintpcs.com');
    case 'tmobile';      emailto = strcat(number,'@tmomail.net');
    case 'verizon';      emailto = strcat(number,'@vtext.com');
    case 'virgin';       emailto = strcat(number,'@vmobl.com');
    case '@vzwpix.com';  emailto = strcat(number,'@vtext.com');
end

%% Set up Gmail SMTP service.
% If you have your own SMTP server, replace it with yours.

% Then this code will set up the preferences properly:
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

%% Send the email
sendmail(emailto,subject,message)

end
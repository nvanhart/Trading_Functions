%% READMAIL
% A simple script highlighting how you can connect to Outlook and
% import emails, including their subjects, bodies & attachements
%
% David Willingham, November 9 2011, MathWorks Australia
%% Connecting to Outlook
outlook = actxserver('Outlook.Application');
mapi = outlook.GetNamespace('mapi');
inbox = mapi.GetDefaultFolder(6);
%% Retrieving last email
count = inbox.Items.Count; %index of the most recent email.
newmail = inbox.Items.Item(count); %imports the most recent email
% secondmail=INBOX.Items.Item(count-1); %imports the 2nd most recent email
subject = newmail.get('Subject');
body = newmail.get('Body');
%% Saving attachments to current directory
%attachments = newmail.get('Attachments');
%if attachments.Count >=1
%    fname = attachments.Item(1).Filename;
%    dir = pwd;
%    full = [pwd,'\',fname];
%    attachments.Item(1).SaveAsFile(full)
%end
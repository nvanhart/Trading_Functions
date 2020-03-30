function [check] = IsNetAvl
[~,b] = dos('ping -n 1 www.google.com');
n = strfind(b,'Lost');
n1 = b(n+7);
if(n1 == '0')
    check = "yes";
else
    check = "no";
end
end

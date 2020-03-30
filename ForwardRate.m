function [output] = ForwardRate(pair,tenor)
%% Forward Rates Calculator
%  A function to calculate the forward rate for a given currency.
%  Supported pairs: USD_MXN, USD_CHF, EUR_JPY, USD_JPY, GBP_USD, EUR_GBP,
%                   EUR_CHF, GBP_CHF, GBP_JPY, CHF_JPY, EUR_USD
%  Suppored tenors: (1-4)W; (1-6,9,12)M; (1-3)Y
%  Ex: ForwardRate('USD_MXN','1M') one month forward rate for USD_MXN
%  Ex: ForwardRate('USD_CHF','2W') two week forward rate for USD_MXN
%  
%  QUICK REF OVERNIGHT RATES - https://www.global-rates.com/interest-rates/central-banks/central-banks.aspx
%
%% Section 1: Convert tenor to days
switch upper(tenor)
    case '1W'; days = 7;
    case '2W'; days = 14;
    case '3W'; days = 21;
    case '4W'; days = 28;
    case '1M'; days = 30;
    case '2M'; days = 60;
    case '3M'; days = 90;
    case '4M'; days = 120;
    case '5M'; days = 150;
    case '6M'; days = 180;
    case '9M'; days = 270;
    case '12M'; days = 365;
    case '1Y'; days = 365;
    case '2Y'; days = 365*2;
    case '3Y'; days = 365*3;
end

%% Section 2: Get exchange and interest rates
spotRateRaw = GetCurrentPrice(pair); %gets current price 
spotRate = str2double(spotRateRaw.closeAsk); %ask rate due to long biased - adjust when adding other currencies

switch upper(pair)
    case 'USD_MXN'
        baseRate = ORFR('USA');
        baseName = 'USD_ORFR';
        quoteRate = ORFR('Mexico');
        quoteName = 'MXN_ORFR';
    case 'USD_CHF'
        baseRate = ORFR('USA');
        baseName = 'USD_ORFR';
        quoteRate = ORFR('Switzerland');
        quoteName = 'CHF_ORFR';
    case 'EUR_JPY'
        baseRate = ORFR('Europe');
        baseName = 'EUR_ORFR';
        quoteRate = ORFR('Japan');
        quoteName = 'JPY_ORFR';
    case 'USD_JPY'
        baseRate = ORFR('USA');
        baseName = 'USA_ORFR';
        quoteRate = ORFR('Japan');
        quoteName = 'JPY_ORFR';
    case 'GBP_USD'
        baseRate = ORFR('England');
        baseName = 'GBP_ORFR';
        quoteRate = ORFR('USA');
        quoteName = 'USD_ORFR';
    case 'EUR_GBP'
        baseRate = ORFR('Europe');
        baseName = 'EUR_ORFR';
        quoteRate = ORFR('England');
        quoteName = 'GBP_ORFR';
    case 'EUR_CHF'
        baseRate = ORFR('Europe');
        baseName = 'EUR_ORFR';
        quoteRate = ORFR('Switzerland');
        quoteName = 'CHF_ORFR';
    case 'GBP_CHF'
        baseRate = ORFR('England');
        baseName = 'GBP_ORFR';
        quoteRate = ORFR('Switzerland');
        quoteName = 'CHF_ORFR';
    case 'GBP_JPY'
        baseRate = ORFR('England');
        baseName = 'GBP_ORFR';
        quoteRate = ORFR('Japan');
        quoteName = 'JPY_ORFR';
    case 'CHF_JPY'
        baseRate = ORFR('Switzerland');
        baseName = 'CHF_ORFR';
        quoteRate = ORFR('Japan');
        quoteName = 'JPY_ORFR';
    case 'EUR_USD'
        baseRate = ORFR('Europe');
        baseName = 'EUR_ORFR';
        quoteRate = ORFR('USA');
        quoteName = 'USD_ORFR';
    case 'aud_jpy'
        baseRate = ORFR('Australia');
        baseName = 'AUD_ORFR';
        quoteRate = ORFR('Japan');
        quoteName = 'JPY_ORFR';
end

%% Section 3: Calculate forward rate
%baseRate = baseRate - .5
%quoteRate = quoteRate - 1.5
spot_rate = spotRate;
forward_rate = (1 + (quoteRate/100*days/365)) / (1 + (baseRate/100*days/365)) * spot_rate;
var_names = {'Spot_Rate'; char('Forward_Rate_' + string(upper(tenor))); 'Premium_Discount'; baseName; quoteName};
%spot_rate = 19.5; %fake price

premium_discount = (forward_rate-spot_rate)/spot_rate;

output = table(spot_rate,forward_rate,premium_discount,baseRate,quoteRate,'VariableNames',var_names);
end


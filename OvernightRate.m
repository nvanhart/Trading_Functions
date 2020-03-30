function rate = OvernightRate(country)
%% Returns most recent overnight risk-free rate from desired country.
%  Currently supports the following countries/currencies:
%  USA/Dollar
%  Mexico/Peso
%  Europe/Euro
%  Japan/Yen
%
%  Ex: rate = OvernightRates('USA') or OvernightRate('Dollar')
%
%% Section 1: Manipulate input
country = lower(country); %lowercase
if country == "dollar"
    country = 'usa';
elseif country == "peso"
    country = 'mexico'
elseif country == "euro"
    country = 'europe';
elseif country == "yen"
    country = 'japan';
end

%% Section 2: Locate rates
switch country
    case 'usa'
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
        
    case 'mexico'
        raw = webread('https://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?sector=22&accion=consultarCuadro&idCuadro=CF107&locale=en');
        sort = char(regexp(string(regexp(raw,'<tr id="nodo_1_0_2".*<tr id="nodo_1_1"','match')),'Interest rate 3.*<span class="visibilityh">000</span>','match'));
        rate = str2double(string(sort(end-39:end-36))); %extracts rate
        
    case 'europe'
        raw0 = webread('https://www.ecb.europa.eu/stats/financial_markets_and_interest_rates/step/html/index.en.html');
        raw1 = char(regexp(raw0,'<th>EONIA</th>.*<th>EURIBOR 1 week</th>','match'));
        raw2 = raw1(1:250); %extracts current rate region to account for white spaces
        raw3 = regexp(raw2,'\d*','match'); %extracts numerics
        rate = str2double(string([char(raw3(1)),'.',char(raw3(2))]));
        
    case 'japan'
        date = char(datetime('now','Format','yyMMdd'));
        url = 'http://www3.boj.or.jp/market/en/stat/mp%s.htm';
        url = sprintf(url,date); %formats url to include date
        raw0 = webread(url);
        raw1 = char(regexp(raw0,'projection call.*</SPAN></li>','match'));
        rate = str2double(string(raw1(end-18:end-13)));
end

%% Section 3: Output
rate = rate;
end

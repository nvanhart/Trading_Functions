function rate = ORFR(country)
%% Returns most recent overnight risk-free rate from desired country.
%  Currently supports the following countries/currencies:
%  USA/Dollar
%  Mexico/Peso
%  Europe/Euro
%  Japan/Yen
%  England/Sterling
%  Switzerland/Franc
%  Australia/Australian Dollar
%
%  Ex: rate = OvernightRates('USA') or OvernightRate('Dollar')
%      rate = OvernightRates('Australia')
%
%% Section 1: Manipulate input
country = lower(country); %lowercase
if country == "dollar"
    country = 'usa';
elseif country == "peso"
    country = 'mexico';
elseif country == "euro"
    country = 'europe';
elseif country == "yen"
    country = 'japan';
elseif country == "sterling"
    country = 'england';
elseif country == "franc"
    country = 'switzerland';
elseif country == "aussie"
    country = 'australia';
end

%% Section 2: Locate rates
switch lower(country)
    case 'usa'
        raw = webread('https://fred.stlouisfed.org/data/DFF.txt'); %webread get base rate
        rate = str2double(string(raw(end-5:end-2))); %extracts rate
       
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
        if weekday(datetime('now')) == 7 %saturday
            date = char(datetime('now','Format','yyMMdd')-1);
        elseif weekday(datetime('now')) == 1 %sunday
            date = char(datetime('now','Format','yyMMdd')-2);
        end
        url = 'http://www3.boj.or.jp/market/en/stat/mp%s.htm';
        url = sprintf(url,date); %formats url to include date
        raw0 = webread(url);
        raw1 = char(regexp(raw0,'projection call.*</SPAN></li>','match'));
        rate = str2double(string(raw1(end-18:end-13)));
    case 'england'
        date = char(datetime('now','Format','dd-MM-yyyy')-1);
        month = char(datetime('now','Format','MMM'));
        year = char(datetime('now','Format','yyyy'));
        day = char(datetime('now','Format','dd'));
        if weekday(datetime('now')) == 7 %saturday
            date = char(datetime('now','Format','dd-MM-yyyy')-3);
            month = char(datetime('now','Format','MMM')-1);
            year = char(datetime('now','Format','yyyy')-1);
            day = char(datetime('now','Format','dd')-1);
        elseif weekday(datetime('now')) == 1 %sunday
            date = char(datetime('now','Format','dd-MM-yyyy')-4);
            month = char(datetime('now','Format','MMM')-2);
            year = char(datetime('now','Format','yyyy')-2);
            day = char(datetime('now','Format','dd')-2);
        end
        url_1 = 'https://www.bankofengland.co.uk/boeapps/database/fromshowcolumns.asp?Travel=NIxSUx&FromSeries=1&ToSeries=50&DAT=RNG&FD=1&';
        url_2 = '%sFM=%s&FY=%s&TD=%s&TM=%s&TY=%s&FNY=&CSVF=TT&html.x=73&html.y=48&C=5JK&Filter=N';
        url_3 = sprintf(url_2,url_1,month,year,day,month,year);
        raw0 = webread(url_3);
        query = sprintf('"Date": "%s",',date)
        raw1 = regexp(raw0,char(query))+40;
        raw2 = regexp(raw0,char(query))+45;
        rate = str2double(string(raw0(raw1:raw2)));
        
    case 'switzerland'
        raw1 = webread('https://www.snb.ch/selector/en/mmr/intfeed/rss'); %risk-free swiss confederation bonds
        raw2 = raw1(end-7500:end-5500); %condenses to last SCB quote
        raw3 = char(regexp(raw2,'<title>CH: .*Swiss Confederation bonds</title>','match')); %extracts char
        rate = str2double(string(raw3(12:17)));
        
    case 'australia'
        raw1 = webread();
end

%% Section 3: Output
rate = rate;
end

%% A script for manually updating data
% ManualForexPrices

his = GetPriceHistory('EUR_JPY',190,'H4'); %Instrument, lookback(days), granularity
timeStamp = cellstr(his.time);
bidClose = (his.closeBid); %converts string to double
askClose = (his.closeAsk);
t = table(timeStamp,bidClose,askClose);
filePath = "C:\\Users\\Noah2\\Documents\\Trading\\AlgoTrading\\Forex\\EUR_JPY\data.xlsx";
writetable(t,filePath,'FileType','spreadsheet'); 
% Multipath Channels > Model a Multipath Channel

% Add a multipath channel to the simulation. It will be static for simplicity. 

% The multipath channel precedes the AWGN because the multipath is encountered in the air, before the signal reaches the receiver that adds the AWGN.


% This code sets up a 16-QAM link with filtering.

numBits = 20000;
modOrder = 16;  % for 16-QAM
bitsPerSymbol = log2(modOrder);  % modOrder = 2^bitsPerSymbol
txFilt = comm.RaisedCosineTransmitFilter;
rxFilt = comm.RaisedCosineReceiveFilter;

srcBits = randi([0,1],numBits,1);
modOut = qammod(srcBits,modOrder,"InputType","bit","UnitAveragePower",true);
txFiltOut = txFilt(modOut);

% Create a column vector named mpChan with 17 elements. Set the values of the 1st, 9th, and 17th elements to 0.8, -0.5, and 0.34, respectively. All other elements should be 0.

spacing = zeros(7,1);
mpChan = [0.8; spacing; -0.5; spacing; 0.34]

% Create a stem plot of the impulse response of the multipath channel mpChan.

stem(mpChan)

% Apply the multipath channel mpChan to the transmitted signal txFiltOut. Name the output signal mpChanOut.

mpChanOut = filter(mpChan,1,txFiltOut)
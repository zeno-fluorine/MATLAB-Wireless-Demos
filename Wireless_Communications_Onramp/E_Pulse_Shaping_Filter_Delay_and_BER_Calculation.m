% Pulse-Shaping Filters > Filter Delay and BER Calculation

numBits = 20000;
modOrder = 16;  % for 16-QAM
bitsPerSymbol = log2(modOrder)  % modOrder = 2^bitsPerSymbol
txFilt = comm.RaisedCosineTransmitFilter;
rxFilt = comm.RaisedCosineReceiveFilter;

srcBits = randi([0,1],numBits,1);
modOut = qammod(srcBits,modOrder,"InputType","bit","UnitAveragePower",true);
txFiltOut = txFilt(modOut);

SNR = 7;  % dB
chanOut = awgn(txFiltOut,SNR,"measured");

rxFiltOut = rxFilt(chanOut);
demodOut = qamdemod(rxFiltOut,modOrder,"OutputType","bit","UnitAveragePower",true);

% Calculate the total delay (in symbols) by summing the transmit filter delay and receive filter delay. Name the result delayInSymbols.
% For each filter, the delay is half the filter length, in symbols. 
% The total delay is the sum of the transmit and receive filter delays.

delayInSymbols = txFilt.FilterSpanInSymbols/2 + rxFilt.FilterSpanInSymbols/2

% Calculate the delay in bits by converting delayInSymbols to bits. Name the result delayInBits.
% To convert the delay from symbols to bits, multiply the delay in symbols by bitsPerSymbol.

delayInBits = delayInSymbols * bitsPerSymbol

% Now that you know the delay, you are ready to compare bits. To do so you need to align matching bits from the sorce bit sequence and the recieved but sequence.

% First, get the aligned bits from the source bit sequence by extracting all but the last delayInBits bits. 
% Extract the aligned source bits from srcBits, and store them in the variable srcAligned.

srcAligned = srcBits(1:(end-delayInBits))

% Next, get the aligned bits from the received bit sequence by extracting all but the first delayInBits bits.
% Extract the aligned received bits from demodOut, and store them in the variable demodAligned.
 
 demodAligned = demodOut((delayInBits+1):end)

% Count the number of bit errors between srcAligned and demodAligned. Store the result in the variable numBitErrors.

numBitErrors = nnz(srcAligned ~= demodAligned)

% Calculate the bit error rate, and store it in the variable BER.

BER = numBitErrors / length(srcAligned)
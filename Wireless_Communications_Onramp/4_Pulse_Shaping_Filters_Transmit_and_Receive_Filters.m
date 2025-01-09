% Pulse-Shaping Filters > Transmitt and Recieve Filters 

% Add square-root raised cosine filters to the transmitter and reciever
% Trasmitt filter -> input: 16-QAM output: sent over the chanel
% Recieve filter -> input: Channel output output: passed to the QAM demodulator

% This code sets up a 16-QAM link.

% Simulation parameters 
numBits = 20000;
modOrder = 16;

% Create source bit sequence and modulate using 16-QAM.
srcBits = randi([0,1],numBits,1);
modOut = qammod(srcBits,modOrder,"InputType","bit","UnitAveragePower",true);

% Create square-root raised cosine transmit and receive filters. Name the transmit filter txFilt and the receive filter rxFilt.

% To display the filter properties, you can leave off the semicolons at the end of the commands.

txFilt = comm.RaisedCosineTransmitFilter;

rxFilt = comm.RaisedCosineReceiveFilter;

% Apply the transmit filter txFilt to the modulated 16-QAM signal modOut. Name the output signal txFiltOut.

txFiltOut = txFilt(modOut);

% Apply AWGN to the filtered signal txFiltOut. Use a signal-to-noise ratio of 7 dB. Name the output chanOut.

chanOut = awgn(txFiltOut,7,"measured");

% Apply the receive filter rxFilt to the channel output chanOut. Name the output rxFiltOut.

rxFiltOut = rxFilt(chanOut);
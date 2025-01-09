% OFDM > Frequency Domain Equalization

% Implementing additional OFDM characteristics using ddmod
% Guard bands and null DC specification


% Set the simulation parameters

modOrder = 16;  % for 16-QAM
bitsPerSymbol = log2(modOrder)  % modOrder = 2^bitsPerSymbol

mpChan = [0.8; zeros(7,1); -0.5; zeros(7,1); 0.34];  % multipath channel
SNR = 15   % dB, signal-to-noise ratio of AWGN

numCarr = 8192;  % number of subcarriers
cycPrefLen = 32;  % cyclic prefix length

% Define the guard band size as numCarr/16 and store it in the variable numGBCarr.

numGBCarr = numCarr/16

% Define the left and right guard band indices and store them in the variables gbLeft and gbRight, respectively.

gbLeft = 1:numGBCarr % Left

gbRight = (numCarr - numGBCarr+1):numCarr % Right

% Define the DC null index and store it in the variable dcIdx.

dcIdx = numCarr/2 +1

% Create a column vector containing the null subcarrier indices and name it nullIdx.

nullIdx = [gbLeft dcIdx gbRight]'

% Calculate the number of data subcarriers and store it in the variable numDataCarr. 

numDataCarr = numCarr - length(nullIdx)

% Then calculate the number of source bits to generate and store it in the variable numBits.

numBits = numDataCarr * bitsPerSymbol

% Create the source bit sequence and modulate using 16-QAM.
if exist("numBits","var")  % code runs after you complete Task 3
    srcBits = randi([0,1],numBits,1);
    qamModOut = qammod(srcBits,modOrder,"InputType","bit","UnitAveragePower",true);
end

% Perform OFDM modulation on the signal qamModOut. Specify the number of subcarriers numCarr, the cyclic prefix length cycPrefLen, and the null subcarrier indices nullIdx.
% Name the output singal ofdmModOut

ofdmModOut = ofdmmod(qamModOut, numCarr, cycPrefLen, nullIdx)

% Perform OFDM demodulation on the received signal chanOut. Specify the number of subcarriers numCarr, the cyclic prefix length cycPrefLen, and the null subcarrier indices nullIdx. For the symbol sampling offset, use the cyclic prefix length cycPrefLen.
% Name the output signal ofdmDemodOut

ofdmDemodOut = ofdmdemod(chanOut, numCarr, cycPrefLen, cycPrefLen, nullIdx)

% Transform the multipath channel impulse response mpChan to the frequency domain and shift the zero-frequency component to the center of the spectrum. Name the result mpChanFreq.

mpChanFreq = fftshift(fft(mpChan,numCarr))

% Remove the elements of mpChanFreq that correspond to the null subcarrier indices.

mpChanFreq(nullIdx) = [];

% Equalize the signal ofdmDemodOut by dividing by mpChanFreq. Name the equalized signal eqOut.

eqOut = ofdmDemodOut ./ mpChanFreq

% Create a scatter plot of the equalized signal.

scatterplot(eqOut)
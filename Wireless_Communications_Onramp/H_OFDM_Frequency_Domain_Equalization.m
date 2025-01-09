% OFDM > Frequency Domain Equalization

% This code sets the simulation parameters.
modOrder = 16;  % for 16-QAM
bitsPerSymbol = log2(modOrder)  % modOrder = 2^bitsPerSymbol

mpChan = [0.8; zeros(7,1); -0.5; zeros(7,1); 0.34];  % multipath channel
SNR = 15   % dB, signal-to-noise ratio of AWGN

% Define the number of subcarriers to be 8192 and store it in the variable numCarr. Then calculate the number of source bits to generate and store it in the variable numBits.

numCarr = 8192

numBits = numCarr * bitsPerSymbol

%{
The next step is to perform OFDM modulation, including a cyclic prefix.

The ofdmmod and ofdmdemod functions manage the cyclic prefix for you. All you have to do is specify the length of the cyclic prefix.

The cyclic prefix must be at least as long as the impulse response of the channel. But, it should also be reasonably short because it contains duplicate data that will be discarded. In this simulation, the multipath channel impulse response length is 17, so use a value slightly larger than that for the cyclic prefix length.
%}

% Define the cyclic prefix length to be 32 and store it in the variable cycPrefLen.


cycPrefLen = 32

% Perform OFDM modulation on the signal qamModOut. Specify the number of subcarriers as numCarr and the cyclic prefix length as cycPrefLen.
% Name the output signal ofdmModOut.

ofdmModOut = ofdmmod(qamModOut, numCarr, cycPrefLen)

% Channel: multipath channel and AWGN
if exist("ofdmModOut","var")  % code runs after you complete Task 3
    mpChanOut = filter(mpChan,1,ofdmModOut);
    chanOut = awgn(mpChanOut,SNR,"measured");
end

% Perform OFDM demodulation on the signal chanOut. Specify the number of subcarriers as numCarr and the cyclic prefix length as cycPrefLen.

% Name the output signal ofdmDemodOut.

% Create a scatter plot of the OFDM demodulator output.

ofdmDemodOut = ofdmdemod(chanOut, numCarr, cycPrefLen)

scatterplot(ofdmDemodOut)

% Transform the multipath channel impulse response mpChan to the frequency domain, with the zero-frequency component in the center of the frequency range. Name the result mpChanFreq.

mpChanFreq = fftshift(fft(mpChan,numCarr))

% Equalize the signal ofdmDemodOut by dividing by mpChanFreq. Name the equalized signal eqOut.

% Create a scatter plot of the equalized signal.

eqOut = ofdmDemodOut ./ mpChanFreq

scatterplot(eqOut)
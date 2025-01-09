% OFDM > OFDM Modulation with the Inverse FFT (Basic link)

% Create a simple OFDM system, with an IFFT as the OFDM modulator and an FFT as the OFDM demodulator.

% This code sets up a 16-QAM link.

numBits = 32768;  % power of 2, to optimize performance of fft/ifft
modOrder = 16;  % for 16-QAM

srcBits = randi([0,1],numBits,1);
qamModOut = qammod(srcBits,modOrder,"InputType","bit","UnitAveragePower",true);
scatterplot(qamModOut)
title("16-QAM Signal")

% Compute the IFFT of the 16-QAM signal qamModOut. Name the result ofdmModOut.

ofdmModOut = ifft(qamModOut)

Apply AWGN.
if exist("ofdmModOut","var")  % code runs after you complete Task 1
    SNR = 15;  % dB
    chanOut = awgn(ofdmModOut,SNR,"measured");
end

% Compute the FFT of the received signal chanOut. Name the result ofdmDemodOut.

ofdmDemodOut = fft(chanOut)

% Create a scatter plot of the OFDM demodulator output ofdmDemodOut.

scatterplot(ofdmDemodOut)
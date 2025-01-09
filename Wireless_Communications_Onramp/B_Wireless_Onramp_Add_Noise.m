% Simulate a basic digital Communication Link > Add Noise
% Add noise to the 16-QAM link simulation and note its effects

% This code sets up the simulation.
% Simulation parameters
numBits = 20000
modOrder = 16  % for 16-QAM

% Create source bit sequence
srcBits = randi([0,1],numBits,1);

% Create a 16-QAM signal from the bit sequence srcBits. Specify the output signal to have unit average power. Name the output signal modOut.

modOut = qammod(srcBits,modOrder,"InputType","bit","UnitAveragePower",true)

Define a variable named SNR with the value 15.

Apply AWGN to the modulated signal modOut with signal-to-noise ratio SNR. Name the output signal chanOut.

% Define a variable named SNR with the value 15.

% Apply AWGN to the modulated signal modOut with signal-to-noise ratio SNR. Name the output signal chanOut.

SNR = 15

chanOut = awgn(modOut,SNR)

% Create a scatter plot of the channel output chanOut.

scatterplot(chanOut)

% Demodulate the signal chanOut, and name the output demodOut. Specify the signal has unit average power.

% Check if the source bits srcBits and received bits demodOut are identical using the isequal function. Name the result check.

% To view the result, leave off the semicolon at the end of the command.

demodOut = qamdemod(chanOut,modOrder,"OutputType","bit", "UnitAveragePower", true)

check = isequal(srcBits, demodOut);

% This time, the source bits and received bits do not match.

% You can do a quick check to see if your link is operating correctly without noise by increasing SNR to a large number, like 100. This effectively removes the noisy channel.
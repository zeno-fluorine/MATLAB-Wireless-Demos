%{ 
Simulate a simple back-to-back communications link that uses QAM.
Simulate a basic digital Communication Link > Modulation and Demodulation

* Generate a source signal of random bits
* Modulate the source bits using QAM
* Demodulate the QAM symbols back into bits
* Compate demodulate bits to the source bits 
%}

% Create a column vector named srcBits containing 20,000 randomly-generated bits.
srcBits = randi([0,1],20000,1)

% Create a variable named modOrder and set its value to 16.
modOrder = 16

% Create a 16-QAM signal from the bit sequence srcBits. Name the modulated signal modOut.
modOut = qammod(srcBits,modOrder,"InputType","bit")

% Create a scatter plot of the modulated signal modOut.
scatterplot(modOut)

% "What you see in the scatter plot is the ideal 16-QAM constellation—16 complex-valued symbols arranged in a square, with each symbol equally spaced from its neighbors. The greater the separation between points, the better the error rate performance. Later, when you add noise to the simulation, you'll see the received observations depart from this ideal configuration."

% Create a variable named chanOut and set it equal to the modulated 16-QAM signal modOut.

chanOut = modOut

% Demodulate the received signal chanOut. Name the output demodOut.

demodOut = qamdemod(chanOut,modOrder,"OutputType","bit")

% Check if the source bits srcBits and received bits demodOut are identical. Name the output check.

% To view the result, leave off the semicolon at the end of the command.
check = isequal(srcBits, demodOut);
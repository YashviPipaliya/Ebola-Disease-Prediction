close all;
clear all;
clc;

%ANALYTICAL PLOT
 Eb_N0_dB =[-3:35]; %DEFINE SNR RANGE
 EbN0lin =  10.^(Eb_N0_dB/10) ; %CONVERT IT TO LINEAR
 theoryBer=0.5.*(1-sqrt(EbN0lin./(EbN0lin+1))) ; %BER EXPRESSION
 
% semilogy(Eb_N0_dB,theoryBer);
% axis([-3 35 10^-5 0.5]);
 
%SIMULATED
N = 10^6;

%TRANSMITTER
ip = rand(1,N)>0.5;
s = 2*ip - 1;

for ii = 1:length(Eb_N0_dB)
    n = 1/sqrt(2)*[randn(1,N)+j*randn(1,N)];   %wgn
    h = 1/sqrt(2)*[randn(1,N)+j*randn(1,N)];   %Rayleigh channel
    
    y = h.*s+10^(-Eb_N0_dB(ii)/20)*n; %hx+n
    yHat = y./h;
    
    ipHat = real(yHat)>0;
    
    nErr(ii) = size(find([ip-ipHat]),2);
end

simBer = nErr/N;

close all
figure
semilogy(Eb_N0_dB,theoryBer,'k.-','Linewidth',2);
hold on
semilogy(Eb_N0_dB,simBer,'mx-','Linewidth',2);
axis([-3 35 10^-5 0.5])
grid on
legend('Theory','Simulation');
xlabel('Eb/No , dB');
ylabel('Bit Error Rate');
title('Bit error probability curve for BPSK modulation in Rayleigh channel')
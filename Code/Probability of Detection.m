% Performance analysis of Spectrum Sensing (energy detection technique) for Cognitive Radio Network
% Analytical and Simulated Plot of Pd v/s SNR; Sample size (L)=1000;
% Pf=0.01

close all;
clear all;
clc;

L=100; % sample size or time bandwidth product
u=100;
Pf=0.01; % Probability of false alarm (given)
lam=(qfuncinv(Pf)./sqrt(L))+1;

SNR_dB=[-20:5]; %SNR Values in decibels

SNR_lin=10.^(SNR_dB/10); % Linear values of SNR (also gamma)

for i=1:length(SNR_dB)
    detect = 0;
    
    for k=1:10000
        n = randn(1,L);
        x=sqrt(SNR_lin(i)).*randn(1,L);
        y=x+n;
        energy=abs(y).^2;
        test_statistic=sum(energy)/L;
        
        if(test_statistic>=lam)
            detect=detect+1;
        end
    end
    Pd_sim(i)=detect/k;
end

pd = qfunc((u.*(lam-(SNR_lin+1)))./(sqrt(2.*u.*((SNR_lin+1)).^2)));

% Plots
close all;
plot(SNR_dB,pd,'b-')
hold on
plot(SNR_dB,Pd_sim,'*')
axis([-20 5 0 1])
set(gca,'ytick',0:0.1:1)
xlabel('Signal to Noise Ratio (dB)');
ylabel('Probability of Detection');
title('Pd v/s SNR for Pf=0.01');
legend('Analytical','Simulation','Location','northwest')
grid on
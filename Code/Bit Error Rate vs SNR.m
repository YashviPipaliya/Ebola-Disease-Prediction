clc;
close all;
clear all;

N = 10^4;
SNR_db = -2:20;
SNR_lin = 10.^(SNR_db/10);
rho = 0.9;
%x                               
ip = rand(1, N)>0.5;
%signal
s = 2*ip-1;

%noise                      
n1 = 1/(sqrt(2))*[randn(1, N) + 1i*randn(1, N)];
n2 = 1/(sqrt(2))*[randn(1, N) + 1i*randn(1, N)];

% channels
h1 = 1/(sqrt(2))*abs((randn(1, N)) + 1i*randn(1, N));
h2 = 1/(sqrt(2))*abs((randn(1, N)) + 1i*randn(1, N));
h1_ICSI = rho*h1+sqrt(1 - (rho^2))*(1/sqrt(2))*[randn(1, N) + 1i*randn(1, N)];
h2_ICSI = rho*h2+sqrt(1 - (rho^2))*(1/sqrt(2))*[randn(1, N) + 1i*randn(1, N)];

%Analytical
mu = sqrt(SNR_lin./(1+SNR_lin));
Pe_ICSI = 1/4.*(2 - 3.*rho.*mu + (rho.^3).*(mu.^3));
Pe      = 1/4.*(2 - 3.*mu + mu.^3 );

%Simulation
for i = 1:length(SNR_db)
  %recieved signals
  y1 = s.*h1+10^(-SNR_db(i)/20)*n1;
  y2 = s.*h2+10^(-SNR_db(i)/20)*n2;
  
  y1_ICSI = s.*h1_ICSI+10^(-SNR_db(i)/20)*n1;
  y2_ICSI = s.*h2_ICSI+10^(-SNR_db(i)/20)*n2;
  
  
  for k = 1:N
    d_1x2(k) = conj(h1(k)).*y1(k) + conj(h2(k)).*y2(k);
    d_1x2_ICSI(k) = conj(h1(k)).*y1_ICSI(k) + conj(h2(k)).*y2_ICSI(k);
    
    %detection 1x2
    if(real(d_1x2(k))>=0)
      detect1x2(k) = 1;
    else
      detect1x2(k) = 0;
    endif
    
    if(real(d_1x2_ICSI(k))>=0)
      detect1x2_ICSI(k) = 1;
    else
      detect1x2_ICSI(k) = 0;
    endif
  
  endfor
    
  % err count and BER
  nErr_1x2 = xor(ip,detect1x2);
  BER(i) = sum(nErr_1x2)/N;
  
  nErr_1x2_ICSI = xor(ip,detect1x2_ICSI);
  BER_ICSI(i) = sum(nErr_1x2_ICSI)/N;
endfor

figure;
semilogy(SNR_db,Pe_ICSI,'b-', SNR_db,BER_ICSI,'m*', SNR_db,Pe,'g-',  SNR_db,BER,'r^');
axis([-2 20 10^-5 0.5]);
xlabel("SNR(dB)");
ylabel("BER");
grid on;
legend('Analytical ICSI SIMO(L=2) \rho=0.9', 'Simulation ICSI SIMO(L=2) \rho=0.9', 'Theoretical SIMO(L=2) \rho=1','Simulation ICSI SIMO(L=2) \rho=1');
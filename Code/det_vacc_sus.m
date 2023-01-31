function det_vacc_sus
% Simulation of a deterministic SIR model using a differential
% equation solver.

params.a = 0.00005; % host birth rate
params.bi = 0.5; % infection rate
params.bd = 0.6; % deceased contact rate
params.bh = 0.00016; % hospitalized contact rate
params.c = 0.1; % latency rate
params.u = 0.12; % pathogen-induced mortality rate
params.r = 0.07; % rate of recovery
params.T = 0.2; %mean rate to hospitalization
params.y = 0.33; % 1/burial time
params.z = 0.10; % recovery rate (hospitalized)
params.v1 = 0.0; %vaccination rate
params.v2 = 0.01; %vaccination rate
params.v3 = 0.05; %vaccination rate

initial.S1 = 100; % number of susceptible individuals
initial.S2 = 100; % number of susceptible individuals
initial.S3 = 100; % number of susceptible individuals

initial.E1 = 9; % number of Exposed individuals
initial.E2 = 9; % number of Exposed individuals
initial.E3 = 9; % number of Exposed individuals

initial.I1 = 6; % number of infected individuals
initial.I2 = 6; % number of infected individuals
initial.I3 = 6; % number of infected individuals

initial.D1 = 2; % number of deceased individuals
initial.D2 = 2; % number of deceased individuals
initial.D3 = 2; % number of deceased individuals

initial.H1 = 3; % number of hospitalized individuals
initial.H2 = 3; % number of hospitalized individuals
initial.H3 = 3; % number of hospitalized individuals

initial.R1 = 1; % number of recovered individuals
initial.R2 = 1; % number of recovered individuals
initial.R3 = 1; % number of recovered individuals

end_time = 50; % end of simulation time span starting a 0

[t, y] = ode45(@(t, x) derivative(t, x, params), ...
[0 end_time], ...
[initial.S1;initial.S2;initial.S3; initial.E1;initial.E2;initial.E3; initial.I1;initial.I2;initial.I3; initial.D1;initial.D2;initial.D3 ; initial.H1;initial.H2;initial.H3; initial.R1;initial.R2;initial.R3], ...
[]);
% extract result vectors
outS1 = y(:,1);
outS2 = y(:,2);
outS3 = y(:,3);

outE1 = y(:,4);
outE2 = y(:,5);
outE3 = y(:,6);

outI1 = y(:,7);
outI2 = y(:,8);
outI3 = y(:,9);

outD1 = y(:,10);
outD2 = y(:,11);
outD3 = y(:,12);

outH1 = y(:,13);
outH2 = y(:,14);
outH3 = y(:,15);

outR1 = y(:,16);
outR2 = y(:,17);
outR3 = y(:,18);


xx = plot(t, outE1,'r','Linewidth',0.5);
hold on
yy = plot(t, outE2,'b','Linewidth',0.5);
hold on
zz = plot(t, outE3,'m','Linewidth',0.5);

legend([xx,yy,zz],'v=0','v=0.01','v=0.05');
% plot the results
%subplot(3, 2, 1);
%plot(t, outS);
%xlabel('t');
%ylabel('S(t)');

%subplot(3, 2, 2);
% plot(t, outE);
%xlabel('t');
%ylabel('E(t)');

%subplot(3, 2, 3);
 %plot(t, outI);
%xlabel('t');
%ylabel('I(t)');

%subplot(3, 2, 4);
 %plot(t, outR);
%xlabel('t');
%ylabel('R(t)');

 %subplot(3, 2, 5);
%hh = plot(t, outH);
%xlabel('t');
%ylabel('H(t)');

%subplot(3, 2, 6);
%dd = plot(t, outD);
%xlabel('t');
%ylabel('D(t)');


%legend([ss,ee,ii,rr,hh,dd],'S(t)','E(t)','I(t)','R(t)','H(t)','D(t)');


function f = derivative (~, x, params)
% Calculates the derivatives of the SIR model. The output is a list with
% the derivatives dS/dt, dI/dt and dR/dt at time t.

S1 = x(1);
S2 = x(2);
S3 = x(3);

E1 = x(4);
E2 = x(5);
E3 = x(6);

I1 = x(7);
I2 = x(8);
I3 = x(9);

D1 = x(10);
D2 = x(11);
D3 = x(12);

H1 = x(13);
H2 = x(14);
H3 = x(15);

R1 = x(16);
R2 = x(17);
R3 = x(18);

ds1 = params.a - params.bi*I1*S1 - params.bd*D1*S1 - params.bh*H1*S1 - params.a*S1 - params.v1*S1 ;
ds2 = params.a - params.bi*I2*S2 - params.bd*D2*S2 - params.bh*H2*S2 - params.a*S2 - params.v2*S2 ;
ds3 = params.a - params.bi*I3*S3 - params.bd*D3*S3 - params.bh*H3*S3 - params.a*S3 - params.v3*S3 ;

de1 = params.bi*I1*S1 + params.bd*D1*S1 + params.bh*H1*S1 - params.a*E1 - params.c*E1 - params.v1*E1;
de2 = params.bi*I2*S2 + params.bd*D2*S2 + params.bh*H2*S2 - params.a*E2 - params.c*E2 - params.v1*E2;
de3 = params.bi*I3*S3 + params.bd*D3*S3 + params.bh*H3*S3 - params.a*E3 - params.c*E3 - params.v1*E3;

di1 = params.c*E1 - params.r*I1 - params.u*I1 - params.T*I1 - params.a*I1;
di2 = params.c*E2 - params.r*I2 - params.u*I2 - params.T*I2 - params.a*I2;
di3 = params.c*E3 - params.r*I3 - params.u*I3 - params.T*I3 - params.a*I3;

dd1 = params.u*I1 - params.y*D1 - params.a*D1;
dd2 = params.u*I2 - params.y*D2 - params.a*D2;
dd3 = params.u*I3 - params.y*D3 - params.a*D3;

dh1 = params.T*I1 - params.z*H1 - params.u*H1 - params.a*H1;
dh2 = params.T*I2 - params.z*H2 - params.u*H2 - params.a*H2;
dh3 = params.T*I3 - params.z*H3 - params.u*H3 - params.a*H3;

dr1 = params.r * I1 - params.a * R1 + params.z*H1 + params.v1*S1 + params.v1*E1;
dr2 = params.r * I2 - params.a * R2 + params.z*H2 + params.v1*S2 + params.v1*E2;
dr3 = params.r * I3 - params.a * R3 + params.z*H3 + params.v1*S3 + params.v1*E3;

f = [ds1; ds2; ds3 ; de1; de2; de3 ; di1; di2; di3 ; dd1; dd2; dd3 ; dh1; dh2; dh3 ; dr1; dr2; dr3 ];
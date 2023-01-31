function Vaccination_plot
% Simulation of a deterministic SEIDHR model using a differential
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
params.v = 0.0; %vaccination rate
params.v2 = 0.05; %vaccination rate
params.v3 = 0.1; %vaccination rate


initial.S = 100; % number of susceptible individuals
initial.E = 9; % number of Exposed individuals
initial.I = 6; % number of infected individuals
initial.D = 2; % number of deceased individuals
initial.H = 3; % number of hospitalized individuals
initial.R = 1; % number of recovered individuals

end_time = 3; % end of simulation time span starting a 0

[t, y] = ode45(@(t, x) derivative1(t, x, params), ...
[0 end_time], ...
[initial.S;initial.E; initial.I;initial.D;initial.H;initial.R], ...
[]);
% extract result vectors
outS = y(:,1);
outE = y(:,2);
outI = y(:,3);
outD = y(:,4);
outH = y(:,5);
outR = y(:,6);
xx = plot(t, outS,'r','Linewidth',0.5);
hold on

[t, y] = ode45(@(t, x) derivative2(t, x, params), ...
[0 end_time], ...
[initial.S;initial.E; initial.I;initial.D;initial.H;initial.R], ...
[]);
% extract result vectors
outS2 = y(:,1);
outE2 = y(:,2);
outI2 = y(:,3);
outD2 = y(:,4);
outH2 = y(:,5);
outR2 = y(:,6);
yy = plot(t, outS2,'b','Linewidth',0.5);
title('Variation in Susceptible population by vaccination')
xlabel('Time')
 ylabel('Number of Individuals')
hold on

[t, y] = ode45(@(t, x) derivative3(t, x, params), ...
[0 end_time], ...
[initial.S;initial.E; initial.I;initial.D;initial.H;initial.R], ...
[]);
% extract result vectors
outS3 = y(:,1);
outE3 = y(:,2);
outI3 = y(:,3);
outD3 = y(:,4);
outH3 = y(:,5);
outR3 = y(:,6);

zz = plot(t, outS3,'g','Linewidth',0.5);

legend([xx,yy,zz],'vaccination rate = 0','vaccination rate = 0.05','vaccination rate = 0.1');
% plot the results



function f = derivative1 (~, x, params)
% Calculates the derivatives of the SEIDHR model. The output is a list with


S = x(1);
E = x(2);
I = x(3);
D = x(4);
H = x(5);
R = x(6);

ds = params.a - params.bi*I*S - params.bd*D*S - params.bh*H*S - params.a*S - params.v*S ;
de = params.bi*I*S + params.bd*D*S + params.bh*H*S - params.a*E - params.c*E - params.v*E;
di = params.c*E - params.r*I - params.u*I - params.T*I - params.a*I;
dd = params.u*I - params.y*D - params.a*D;
dh = params.T*I - params.z*H - params.u*H - params.a*H;
dr = params.r * I - params.a * R + params.z*H + params.v*S + params.v*E;

f = [ds; de; di; dd; dh; dr];


function f = derivative2 (~, x, params)


S = x(1);
E = x(2);
I = x(3);
D = x(4);
H = x(5);
R = x(6);

ds = params.a - params.bi*I*S - params.bd*D*S - params.bh*H*S - params.a*S - params.v2*S*5 ;
de = params.bi*I*S + params.bd*D*S + params.bh*H*S - params.a*E - params.c*E - params.v2*E;
di = params.c*E - params.r*I - params.u*I - params.T*I - params.a*I;
dd = params.u*I - params.y*D - params.a*D;
dh = params.T*I - params.z*H - params.u*H - params.a*H;
dr = params.r * I - params.a * R + params.z*H + params.v2*S + params.v2*E;

f = [ds; de; di; dd; dh; dr];



function f = derivative3 (~, x, params)

S = x(1);
E = x(2);
I = x(3);
D = x(4);
H = x(5);
R = x(6);

ds = params.a - params.bi*I*S - params.bd*D*S - params.bh*H*S - params.a*S - params.v3*S*10 ;
de = params.bi*I*S + params.bd*D*S + params.bh*H*S - params.a*E - params.c*E - params.v3*E;
di = params.c*E - params.r*I - params.u*I - params.T*I - params.a*I;
dd = params.u*I - params.y*D - params.a*D;
dh = params.T*I - params.z*H - params.u*H - params.a*H;
dr = params.r * I - params.a * R + params.z*H + params.v3*S + params.v3*E;

f = [ds; de; di; dd; dh; dr];
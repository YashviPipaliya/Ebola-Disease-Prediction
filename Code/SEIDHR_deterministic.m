function SEIDHR_deterministic
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
params.v = 0.0; %vaccination rate


initial.S = 50; % number of susceptible individuals
initial.E = 10; % number of Exposed individuals
initial.I = 8; % number of infected individuals
initial.D = 2; % number of deceased individuals
initial.H = 5; % number of hospitalized individuals
initial.R = 1; % number of recovered individuals

end_time = 100; % end of simulation time span starting a 0

[t, y] = ode45(@(t, x) derivative(t, x, params), ...
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

 plot the results
subplot(3, 2, 1);
plot(t, outS);
xlabel('t');
ylabel('S(t)');

subplot(3, 2, 2);
plot(t, outE);
xlabel('t');
ylabel('E(t)');

subplot(3, 2, 3);
plot(t, outI);
xlabel('t');
ylabel('I(t)');

subplot(3, 2, 4);
 plot(t, outR);
xlabel('t');
ylabel('R(t)');

subplot(3, 2, 5);
plot(t, outH);
xlabel('t');
ylabel('H(t)');

subplot(3, 2, 6);
dd = plot(t, outD);
xlabel('t');
ylabel('D(t)');


%legend([ss,ee,ii,rr,hh,dd],'S(t)','E(t)','I(t)','R(t)','H(t)','D(t)');


function f = derivative (~, x, params)
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
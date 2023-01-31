
function SEIRDH_STOC_run
% Simulation of the stochastic SEIDHR model

params.a = 0.00005; % host birth rate
params.bi = 0.5; % infection rate
params.bd = 0.6; % deceased contact rate
params.bh = 0.00016; % hospitalized contact rate
params.c = 0.1; % latency rate
params.u = 0.12; % pathogen-induced mortality rate
params.r = 0.07; % rate of recovery
params.t = 0.2; %mean rate to hospitalization
params.y = 0.33; % 1/burial time
params.z = 0.10; % recovery rate (hospitalized)
params.v = 0.0; %vaccination factor

initial.S = 100; % number of susceptible individuals
initial.E = 10; % number of Exposed individuals
initial.I = 8; % number of infected individuals
initial.D = 2; % number of deceased individuals
initial.H = 5; % number of hospitalized individuals
initial.R = 1; % number of recovered individuals

end_time = 100; % end of simulation time span starting a 0
run_count = 250; % number of runs
%54 300, 223, 58, 21, 53, 18 800

result.time = []; % collects the time results
result.S = []; % collects the S results
result.E = []; % collects the E results
result.I = []; % collects the I results
result.R = []; % collects the R results
result.H = []; % collects the H results
result.D = []; % collects the D results


% simulate several stochastic SIR models and collect data
for n=1:run_count
    out = SEIRDH_STOC (params, initial, end_time);
    result.time = [result.time out.time];
    result.S = [result.S out.S];
    result.E = [result.E out.E];
    result.I = [result.I out.I];
    result.R = [result.R out.R];
    result.H = [result.H out.H];
    result.D = [result.D out.D]; 
end

% extract unique times and the corresponding data
[time, m, ~] = unique(result.time);
S = result.S(m);
E = result.E(m);
I = result.I(m);
R = result.R(m);
H = result.H(m);
D = result.D(m);

% calculate running averages
N = 50; % number of samples in the average
j = 1;
for i=1:N:length(time)-N+1
    meanTime(j) = mean(time(i:i+N-1));
    meanS(j) = mean(S(i:i+N-1));
    meanE(j) = mean(E(i:i+N-1)); 
    meanI(j) = mean(I(i:i+N-1));
    meanR(j) = mean(R(i:i+N-1));
    meanH(j) = mean(H(i:i+N-1));
    meanD(j) = mean(D(i:i+N-1));   
    j = j + 1;
end

xx= plot (meanTime, meanS,'k','Linewidth',0.5);
xlabel('Time')
 ylabel('Number of Individuals')
hold on;
yy =plot (meanTime, meanE,'b','Linewidth',0.5);
hold on;
zz = plot (meanTime, meanI,'r','Linewidth',0.5);
hold on;
pp = plot (meanTime, meanR,'m','Linewidth',0.5);
hold on;
qq = plot (meanTime, meanH,'g','Linewidth',0.5);
hold on;
rr = plot (meanTime, meanD,'c','Linewidth',0.5);

legend([xx,yy,zz,pp,qq,rr],'S','E','I','R','H','D');

% plot result
%subplot(3, 2, 1);
%plot (meanTime, meanS);
%xlabel ('time');
%ylabel ('S');

%subplot(3, 2, 2);
%plot (meanTime, meanE);
%xlabel ('time');
%ylabel ('E');

%subplot(3, 2, 3);
%plot (meanTime, meanI);
%xlabel ('time');
%ylabel ('I');

%subplot(3, 2, 4);
%plot (meanTime, meanR);
%xlabel ('time');
%ylabel ('R');

%subplot(3, 2, 5);
%plot (meanTime, meanH);
%xlabel ('time');
%ylabel ('H ');


%subplot(3, 2, 6);
%plot (meanTime, meanD);
%xlabel ('time');
%ylabel ('D');



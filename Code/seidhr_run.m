function seifhr_run

% Simulation of the stochastic SIR model

 

params.a = 0.00005;

params.bi = 0.5;

params.bd = 0.6;

params.bh = 0.00016;

params.c = 0.1;

params.z = 0.10;

params.t = 0.2;

params.y = 0.33;

params.u = 0.12;

params.r = 0.07;

params.v = 0.0;

 

initial.S = 100;

initial.E = 10;

initial.I = 8;

initial.D = 2;

initial.H = 5;

initial.R = 1;

 

end_time = 100;

run_count = 250;

%54 300, 223, 58, 21, 53, 18 800

 

result.time = [];

result.S = [];

result.E = [];

result.I = [];

result.R = [];

result.H = [];

result.D = [];

 

 

for n=1:run_count

out = seidhr (params, initial, end_time);

result.time = [result.time out.time];

result.S = [result.S out.S];

result.E = [result.E out.E];

result.I = [result.I out.I];

result.R = [result.R out.R];

result.H = [result.H out.H];

result.D = [result.D out.D];

end

 

 [time, m, ~] = unique(result.time);

S = result.S(m);

E = result.E(m);

I = result.I(m);

R = result.R(m);

H = result.H(m);

D = result.D(m);

 

N = 50;

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


% plot result
subplot(3, 2, 1);
plot (meanTime, meanS);
xlabel ('time');
ylabel ('S');

subplot(3, 2, 2);
plot (meanTime, meanE);
xlabel ('time');
ylabel ('E');

subplot(3, 2, 3);
plot (meanTime, meanI);
xlabel ('time');
ylabel ('I');

subplot(3, 2, 4);
plot (meanTime, meanR);
xlabel ('time');
ylabel ('R');

subplot(3, 2, 5);
plot (meanTime, meanH);
xlabel ('time');
ylabel ('H ');


subplot(3, 2, 6);
plot (meanTime, meanD);
xlabel ('time');
ylabel ('D');




sigma = 0.1;
beta_i = 0.5;
beta_d = 0.6;
beta_h = 0.00016;
mu_e = 0.12;
mu = 0.00005;
delta = 0.33;
tau = 0.2;
gamma_hr = 0.10;
gamma_ir = 0.07;
y1 = (beta_i + beta_d.*mu_e)/(delta + mu);

y2 = beta_h.*tau/(gamma_hr + mu_e + mu);

y3 = (gamma_ir + tau + mu_e + mu).*(mu + sigma);
y4 = sigma.*(y1 + y2);
y = y4/y3;
line([-1,1],[y,y]);


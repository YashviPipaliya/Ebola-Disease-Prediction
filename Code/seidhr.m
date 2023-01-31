function result = seidhr (params, initial, end_time)

state = initial;

result.time = [];

result.S = []; % receives the S results

result.E = []; % receives the I results

result.I = [];

result.R = []; 

result.H = [];

result.D = [];

time = 0;

while (time < end_time && state.I > 0)
 
probs = probablities(state, params);

tau = exprnd(1/sum(probs));

time = time + tau;
which = process(probs);

 % using master equation parameters 

switch which

case 1

state.S = state.S - 1;

state.E = state.E + 1;

case 2

state.S = state.S - 1;

state.E = state.E + 1;

 

case 3

state.S = state.S - 1;

state.E = state.E + 1;

case 4

state.S = state.S - 1;

case 5

state.E = state.E - 1;

case 6

state.E = state.E - 1;

state.I = state.I + 1;

case 7

state.I = state.I - 1;

state.D = state.D + 1;

case 8

state.I = state.I - 1;

state.R = state.R + 1;

case 9

state.I = state.I - 1;

state.H = state.H + 1;

case 10

state.I = state.I - 1;

case 11

state.D = state.D - 1;

case 12

state.D = state.D - 1;

state.R = state.R + 1;

case 13

state.H = state.H - 1;

state.R = state.R + 1;

case 14

state.H = state.H - 1;

case 15

state.H = state.H - 1;

state.R = state.R + 1;

case 16

state.R = state.R - 1;

case 17

state.R = state.R + 1;

state.S = state.S - 1;

case 18

state.R = state.R + 1;

state.E = state.E - 1;

 

end

% store results

result.time = [result.time time];

result.S = [result.S state.S];

result.E = [result.E state.E];

result.I = [result.I state.I];

result.R = [result.R state.R];

result.H = [result.H state.H];

result.D = [result.D state.D];
end

 

function which = process (probs)
 
r = rand * sum(probs);

which = 1;

s = probs(1);

while (r > s)

    which = which + 1;

    s = s + probs(which);

end


function a = probablities (state, params)


a(1) = params.bi * (state.S * state.I);

a(2) = params.bd * (state.S * state.D);

a(3) = params.bh * (state.S * state.H);

a(4) = params.a * state.S;

a(5) = params.a * state.E;

a(6) = params.c * state.E;

a(7) = params.u * state.I;

a(8) = params.r * state.I;

a(9) = params.t * state.I;

a(10) = params.a * state.I;

a(11) = params.y * state.D;

a(12) = params.a * state.D;

a(13) = params.z * state.H;

a(14) = params.u * state.H;

a(15) = params.a * state.H;

a(16) = params.a * state.R;

a(17) = params.v * state.S;

a(18) = params.v * state.E;

 

 

 

 
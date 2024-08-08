clear
clc

% Assume that the information bits are i.i.d.
m = 3; % parity check bits
k = 2^m - 1 - m; % info bits
n = 2^m - 1; % code length
sim_err_1 = zeros(1, 11);
theo_err_1 = zeros(1, 11);

% Simulation
U1 = rand(1, 1e7) > 0.5; % info
C1 = Hamming_en(U1, m);
U_1 = reshape(U1, k, []);
for p=0:0.1:1 % different crossover probability
    R1 = bsc(C1, p);
    K1 = Hamming_de(R1, m);
    K_1 = reshape(K1, k, []);
    err_1 = sum(U_1==K_1, 1) ~= k; % error space in this transmission
    sim_err_1(1, int8(p/0.1+1)) = sum(err_1)/length(err_1);
end

% Theory
for p=0:0.1:1
    theo_err_1(1, int8(p/0.1+1)) = 1 - (1-p)^n - n*(1-p)^(n-1)*p;
end

figure
plot(0:0.1:1, theo_err_1)
hold on
scatter(0:0.1:1, sim_err_1)
legend('Theory', 'Simulation')
xlabel('Crossover probability')
ylabel('Error probability')
title('Information bits are i.i.d.')


% Assume that the information bits are not i.i.d.
U2 = rand(1, 1e7) > 0.2; % info
sim_err_2 = zeros(1, 11);
theo_err_2 = zeros(1, 11);

% Simulation
C2 = Hamming_en(U2, m);
U_2 = reshape(U2, k, []);
for p=0:0.1:1 % different crossover probability
    R2 = bsc(C2, p);
    K2 = Hamming_de(R2, m);
    K_2 = reshape(K2, k, []);
    err_2 = sum(U_2==K_2, 1) ~= k; % error space in this transmission
    sim_err_2(1, int8(p/0.1+1)) = sum(err_2)/length(err_2);
end

% Theory
for p=0:0.1:1
    theo_err_2(1, int8(p/0.1+1)) = 1 - (1-p)^n - n*(1-p)^(n-1)*p;
end

figure
plot(0:0.1:1, theo_err_2)
hold on
scatter(0:0.1:1, sim_err_2)
legend('Theory', 'Simulation')
xlabel('Crossover probability')
ylabel('Error probability')
title('Information bits are NOT i.i.d.')


% Fixed crossover probability p = 0.1 with different parity check bits
p = 0.1;
sim_err_4 = zeros(1, 5);
theo_err_4 = zeros(1, 5);
U4 = rand(1, 1e7) > 0.5;
for m=3:7
    k = 2^m - 1 - m; % info bits
    n = 2^m - 1; % code length

    C4 = Hamming_en(U4, m);

    R4 = bsc(C4, p);
    
    K4 = Hamming_de(R4, m);
    
    if mod(length(U4),k)
        U4 = [ U4, zeros(1, k-mod(length(U4),k)) ];
    end
    U_4 = reshape(U4, k, []);
    K_4 = reshape(K4, k, []);
    err_4 = sum(U_4==K_4, 1) ~= k;
    sim_err_4(1, m-2) = sum(err_4)/length(err_4);
    
    % Theory
    theo_err_4(1, m-2) = 1 - (1-p)^n - n*(1-p)^(n-1)*p;
end

figure
plot(3:7, theo_err_4)
hold on
scatter(3:7, sim_err_4)
legend('Theory', 'Simulation')
xlim([2,8])
ylim([0,1])
xlabel('Number of parity check bits')
ylabel('Error probability')
title('Fixed crossover probability p=0.1')

save('data.mat', 'sim_err_1','theo_err_1','sim_err_2','theo_err_2','sim_err_4','theo_err_4')

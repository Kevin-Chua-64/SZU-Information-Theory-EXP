clear
clc

load('data.mat')

% Assume that the information bits are i.i.d.
figure
plot(0:0.1:1, theo_err_1)
hold on
scatter(0:0.1:1, sim_err_1)
legend('Theory', 'Simulation')
xlabel('Crossover probability')
ylabel('Error probability')
title('Information bits are i.i.d.')

% Assume that the information bits are not i.i.d.
figure
plot(0:0.1:1, theo_err_2)
hold on
scatter(0:0.1:1, sim_err_2)
legend('Theory', 'Simulation')
xlabel('Crossover probability')
ylabel('Error probability')
title('Information bits are NOT i.i.d.')

% Different crossover probability under different number of parity check bits (theory)
theo_err_3 = zeros(5, 5);
for p=0.1:0.1:0.5
    for m=3:7
        k = 2^m - 1 - m; % info bits
        n = 2^m - 1; % code length

        theo_err_3(int8(p/0.1), m-2) = 1 - (1-p)^n - n*(1-p)^(n-1)*p;
    end
end

figure
plot(3:7, theo_err_3(1,:))
hold on
plot(3:7, theo_err_3(2,:))
hold on
plot(3:7, theo_err_3(3,:))
hold on
plot(3:7, theo_err_3(4,:))
hold on
plot(3:7, theo_err_3(5,:))
legend('p=0.1','p=0.2','p=0.3','p=0.4','p=0.5')
xlim([2,8])
ylim([0,1])
xlabel('Number of parity check bits')
ylabel('Error probability')
title('Different parity check bits under different crossover probability')

% Fixed crossover probability p = 0.1 with different parity check bits
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

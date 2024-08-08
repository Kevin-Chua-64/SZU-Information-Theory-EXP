clear
clc

Q_test = [0.5  0.25 0    0.25;
          0    1    0    0;
          0    0    1    0;
          0.25 0    0.25 0.5]; % p(r) = {4/30, 11/30, 11/30, 4/30}, C = log2(2.5)
%%%%%%%%%% 3.1 %%%%%%%%%%
Q1 = [0.8, 0.2;
      0.3, 0.7];
% probability distribution
P1_Y_X = Q1; % P(Y|X)
% for recording the values of x1 and I(X;Y)
x1_1 = zeros(999, 1);
I1 = zeros(999, 1);
i=1;
for m = 0.001:0.001:0.999
    % probability
    P1_X = [m, 1-m]; % P(X)
    x1_1(i) = m;
    P1_Y = P1_X * P1_Y_X; % P(Y)
    P1_XY = P1_Y_X .* repmat(P1_X', 1, 2); % P(XY)
    
    % entropy
    H1_Y = sum(-P1_Y .* log2(P1_Y), 'all'); % H(Y)
    H1_Y_X = sum(-P1_XY .* log2(P1_Y_X), 'all'); % H(Y|X)
    I1(i) = H1_Y - H1_Y_X; % I(X;Y)
    i=i+1;
end

figure
plot(x1_1, I1)
xlabel('x_1')
ylabel('I(X;Y)')
title('3.1 Average mutual information various with x_1')
hold on

[I1_max, index] = max(I1); % optimum
% label the optimum point
x_text = ['x_1 = ', num2str(x1_1(index))];
y_text = ['I(X;Y) = ', num2str(I1_max)];
max_text = char(x_text, y_text);
plot(x1_1(index), I1_max, 'k.', 'markersize',20)
hold on
text(x1_1(index)-0.06, I1_max-0.015, max_text)


%%%%%%%%%% 3.2 %%%%%%%%%%
Q2 = [0.8,  0.15, 0.05;
      0.15, 0.15, 0.7;
      0.6,  0.3,  0.1];
% probability distribution
P2_Y_X = Q2; % P(Y|X)
% for recording the values of x1, x2, and I(X;Y)
x2_1 = zeros(999, 1);
x2_2 = zeros(999, 1);
I2 = zeros(999, 999);
i=1; j=1;
for m = 0.001:0.001:0.999
    for n = 0.001:0.001:0.999
        if m+n<=1
            % probability
            P2_X = [m, n, 1-m-n]; % P(X)
            x2_1(i) = m;
            x2_2(j) = n;
            P2_Y = P2_X * P2_Y_X; % P(Y)
            P2_XY = P2_Y_X .* repmat(P2_X', 1, 3); % P(XY)

            % entropy
            H2_Y = sum(-P2_Y .* log2(P2_Y), 'all'); % H(Y)
            H2_Y_X = sum(-P2_XY .* log2(P2_Y_X), 'all'); % H(Y|X)
            I2(i, j) = H2_Y - H2_Y_X; % I(X;Y)
        else
            I2(i, j) = NaN;
        end
        j = j+1;
    end
    i=i+1; j=1;
end

figure
mesh(x2_1, x2_2, I2')
xlabel('x_1')
ylabel('x_2')
zlabel('I(X;Y)')
title('3.2 Average mutual information various with x_1 and x_2')
hold on

[I2_max, index_1] = max(I2);
[I2_max, index_2] = max(I2_max);
index_1 = index_1(index_2);
% label the optimum point
x_text = ['x_1 = ', num2str(x2_1(index_1))];
y_text = ['x_2 = ', num2str(x2_2(index_2))];
z_text = ['I(X;Y) = ', num2str(I2_max)];
max_text = char(x_text, y_text, z_text);
plot3(x2_1(index_1), x2_2(index_2), I2_max, 'k.', 'markersize',20)
hold on
text(x2_1(index_1), x2_2(index_2), I2_max+0.08, max_text)


%%%%%%%%%% 3.3 %%%%%%%%%%
Q3 = load('data3.3.mat').p;
% probability distribution
P3_Y_X = Q3; % P(Y|X)

[xsize, ysize] = size(Q3);
P3_X = ones(xsize, 1)/xsize; % initial P(X)
I3_L = 0; I3_U = 1;

% loop
k=0;
while 1
    % determine beta
    beta3 = exp(diag( log2( P3_Y_X ./ (P3_X' * P3_Y_X + eps) + eps ) * P3_Y_X' ));
    % update IL, IU, and P(X)
    I3_L = log(P3_X' * beta3);
    I3_U = log(max(beta3));
    P3_X = diag(beta3 ./ (P3_X' * beta3) * P3_X');
    k=k+1;
        
    if I3_U - I3_L < 1e-7 % convergence
        break
    end
end
P3_X
figure
bar(P3_X)
xlabel('Index of the input variable')
ylabel('Probability distribution')
title('3.3 Optimum input distribution')
hold on

% channel capacity
info_text = char(['Channel capacity: ', num2str(I3_L), ' bit/sym'], ['Number of iterations: ', num2str(k)]);
text(3, 0.45, info_text)


%%%%%%%%%% 3.4 %%%%%%%%%%
Q4 = load('data3.4.mat').p;
% probability distribution
P4_Y_X = Q4; % P(Y|X)

[xsize, ysize] = size(Q4);
P4_X = ones(xsize, 1)/xsize; % initial P(X)
I4_L = 0; I4_U = 1;

% loop
k=0;
while 1
    % determine beta
    beta4 = exp(diag( log2( P4_Y_X ./ (P4_X' * P4_Y_X + eps) + eps ) * P4_Y_X' ));
    % update IL, IU, and P(X)
    I4_L = log(P4_X' * beta4);
    I4_U = log(max(beta4));
    P4_X = diag(beta4 ./ (P4_X' * beta4) * P4_X');
    k=k+1;
        
    if I4_U - I4_L < 1e-7 % convergence
        break
    end
end
figure
bar(P4_X)
xlabel('Index of the input variable')
ylabel('Probability distribution')
title('3.4 Optimum input distribution')
hold on

% channel capacity
info_text = char(['Channel capacity: ', num2str(I4_L), ' bit/sym', '     ', 'Number of iterations: ', num2str(k)]);
text(10, 0.13, info_text)


%%%%%%%%%% 3.5 %%%%%%%%%%
Q5 = load('data3.5.mat').p;
% probability distribution
P5_Y_X = Q5; % P(Y|X)

% iterative algorithm
[xsize, ysize] = size(Q5);
P5_X_1 = ones(xsize, 1)/xsize; % initial P(X)
I5_L = 0; I5_U = 1;

% loop
k=0;
while 1
    % determine beta
    beta5_1 = exp(diag( log2( P5_Y_X ./ (P5_X_1' * P5_Y_X + eps) + eps ) * P5_Y_X' ));
    % update IL, IU, and P(X)
    I5_L = log(P5_X_1' * beta5_1);
    I5_U = log(max(beta5_1));
    P5_X_1 = diag(beta5_1 ./ (P5_X_1' * beta5_1) * P5_X_1');
    k=k+1;
        
    if I5_U - I5_L < 1e-7 % convergence
        break
    end
end
P5_X_1
figure
bar(P5_X_1)
xlabel('Index of the input variable')
ylabel('Probability distribution')
title('3.5 Optimum input distribution evaluated by iterative algorithm')
hold on

% channel capacity
info_text = char(['Channel capacity: ', num2str(I5_L), ' bit/sym'], ['Number of iterations: ', num2str(k)]);
text(0, 0.325, info_text)

% linear equation-based method
if det(P5_Y_X) == 0 % check the singularity
    warning('This transition probability matrix is singular!')
end

A = diag(log2(P5_Y_X + eps) * P5_Y_X');
beta5_2 =(P5_Y_X) \ A; % A\b for INV(A)*b for higher accuracy
% capacity
C5_2 = log2(sum(2 .^ beta5_2));

P5_Y_2 = 2 .^ (beta5_2 - C5_2); % P(Y)
P5_X_2 = P5_Y_X' \ P5_Y_2; % A\b for INV(A)*b for higher accuracy
P5_X_2

figure
bar(P5_X_2)
xlabel('Index of the input variable')
ylabel('Probability distribution')
title('3.5 Optimum input distribution evaluated by linear equation-based method')
hold on

% channel capacity
info_text = char(['Channel capacity: ', num2str(C5_2), ' bit/sym']);
text(0, 0.33, info_text)

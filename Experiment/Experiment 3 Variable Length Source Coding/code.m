clear
clc

load('3_2.mat')
load('2_extended.mat')
load('3_extended.mat')
load('4_extended.mat')

figure
plot(1:4, [avg_len_const, extend_2_avg_len_const, extend_3_avg_len_const, extend_4_avg_len_const], 'marker','.', 'markersize',15)
hold on
plot(1:4, [avg_len_Shannon, extend_2_avg_len_Shannon, extend_3_avg_len_Shannon, extend_4_avg_len_Shannon], 'marker','.', 'markersize',15)
hold on
plot(1:4, [avg_len_Fano, extend_2_avg_len_Fano, extend_3_avg_len_Fano, extend_4_avg_len_Fano], 'marker','.', 'markersize',15)
hold on
plot(1:4, [avg_len_Huffman, extend_2_avg_len_Huffman, extend_3_avg_len_Huffman, extend_4_avg_len_Huffman], 'marker','.', 'markersize',15)
legend('constant length code', 'Shannon code', 'Fano code', 'Huffman code', 'Location','best')
xticks(1:4)
ylim([3,5.5])
title('Average coding length under different coding and extended times')
xlabel('Extended times')
ylabel('Average coding length (code/sym)')

figure
plot(1:4, [eff_const, extend_2_eff_const, extend_3_eff_const, extend_4_eff_const], 'marker','.', 'markersize',15)
hold on
plot(1:4, [eff_Shannon, extend_2_eff_Shannon, extend_3_eff_Shannon, extend_4_eff_Shannon], 'marker','.', 'markersize',15)
hold on
plot(1:4, [eff_Fano, extend_2_eff_Fano, extend_3_eff_Fano, extend_4_eff_Fano], 'marker','.', 'markersize',15)
hold on
plot(1:4, [eff_Huffman, extend_2_eff_Huffman, extend_3_eff_Huffman, extend_4_eff_Huffman], 'marker','.', 'markersize',15)
legend('constant length code', 'Shannon code', 'Fano code', 'Huffman code', 'Location','best')
xticks(1:4)
ylim([0.25,0.55])
title('Coding efficiency under different coding and extended times')
xlabel('Extended times')
ylabel('Coding efficiency')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Coding without extension')
fprintf('\nConstant length code\n')
disp(['The average coding length: ', num2str(avg_len_const), ' code/sym'])
disp(['The coding efficiency: ', num2str(eff_const*100), '%'])

fprintf('\nShannon code\n')
disp(['The average coding length: ', num2str(avg_len_Shannon), ' code/sym'])
disp(['The coding efficiency: ', num2str(eff_Shannon*100), '%'])

fprintf('\nFano code\n')
disp(['The average coding length: ', num2str(avg_len_Fano), ' code/sym'])
disp(['The coding efficiency: ', num2str(eff_Fano*100), '%'])

fprintf('\nHuffman code\n')
disp(['The average coding length: ', num2str(avg_len_Huffman), ' code/sym'])
disp(['The coding efficiency: ', num2str(eff_Huffman*100), '%'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n--------------------------------------------------\n\n')
disp('2 times extended coding')
fprintf('\nConstant length code\n')
disp(['The average coding length: ', num2str(extend_2_avg_len_const), ' code/sym'])
disp(['The coding efficiency: ', num2str(extend_2_eff_const*100), '%'])

fprintf('\nShannon code\n')
disp(['The average coding length: ', num2str(extend_2_avg_len_Shannon), ' code/sym'])
disp(['The coding efficiency: ', num2str(extend_2_eff_Shannon*100), '%'])

fprintf('\nFano code\n')
disp(['The average coding length: ', num2str(extend_2_avg_len_Fano), ' code/sym'])
disp(['The coding efficiency: ', num2str(extend_2_eff_Fano*100), '%'])

fprintf('\nHuffman code\n')
disp(['The average coding length: ', num2str(extend_2_avg_len_Huffman), ' code/sym'])
disp(['The coding efficiency: ', num2str(extend_2_eff_Huffman*100), '%'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n--------------------------------------------------\n\n')
disp('3 times extended coding')
fprintf('\nConstant length code\n')
disp(['The average coding length: ', num2str(extend_3_avg_len_const), ' code/sym'])
disp(['The coding efficiency: ', num2str(extend_3_eff_const*100), '%'])

fprintf('\nShannon code\n')
disp(['The average coding length: ', num2str(extend_3_avg_len_Shannon), ' code/sym'])
disp(['The coding efficiency: ', num2str(extend_3_eff_Shannon*100), '%'])

fprintf('\nFano code\n')
disp(['The average coding length: ', num2str(extend_3_avg_len_Fano), ' code/sym'])
disp(['The coding efficiency: ', num2str(extend_3_eff_Fano*100), '%'])

fprintf('\nHuffman code\n')
disp(['The average coding length: ', num2str(extend_3_avg_len_Huffman), ' code/sym'])
disp(['The coding efficiency: ', num2str(extend_3_eff_Huffman*100), '%'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n--------------------------------------------------\n\n')
disp('4 times extended coding')
fprintf('\nConstant length code\n')
disp(['The average coding length: ', num2str(extend_4_avg_len_const), ' code/sym'])
disp(['The coding efficiency: ', num2str(extend_4_eff_const*100), '%'])

fprintf('\nShannon code\n')
disp(['The average coding length: ', num2str(extend_4_avg_len_Shannon), ' code/sym'])
disp(['The coding efficiency: ', num2str(extend_4_eff_Shannon*100), '%'])

fprintf('\nFano code\n')
disp(['The average coding length: ', num2str(extend_4_avg_len_Fano), ' code/sym'])
disp(['The coding efficiency: ', num2str(extend_4_eff_Fano*100), '%'])

fprintf('\nHuffman code\n')
disp(['The average coding length: ', num2str(extend_4_avg_len_Huffman), ' code/sym'])
disp(['The coding efficiency: ', num2str(extend_4_eff_Huffman*100), '%'])

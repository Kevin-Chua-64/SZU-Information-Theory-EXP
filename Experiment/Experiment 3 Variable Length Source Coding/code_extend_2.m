clear
clc

text = load('orderlist.mat').orderList;
%%%%%%%%%% 3.3 %%%%%%%%%%
% 2 times extended coding
extend_2_count = zeros(27, 27);
for i=1:length(text)-1
    extend_2_count(text(i), text(i+1)) = extend_2_count(text(i), text(i+1)) + 1;
end
extend_2_pro = extend_2_count ./ (length(text)-1);
H_S = 1.4;

% reshape the probalility matrix and delete the symbols with 0 probability
extend_2_pro = reshape(extend_2_pro, [], 1);
extend_2_pro(extend_2_pro==0) = [];
% descending order
extend_2_pro = sort(extend_2_pro, 'descend');
% constant length code
extend_2_avg_len_const = ceil(log2(length(extend_2_pro))) / 2;
extend_2_eff_const = H_S/extend_2_avg_len_const/log2(2);
% Shannon code
extend_2_Shannon = SBE(extend_2_pro);
extend_2_avg_len_Shannon = strlength(extend_2_Shannon)*extend_2_pro / 2;
extend_2_eff_Shannon = H_S/extend_2_avg_len_Shannon/log2(2);
% Fano code
extend_2_Fano = fano(extend_2_pro');
extend_2_avg_len_Fano = strlength(extend_2_Fano)*extend_2_pro / 2;
extend_2_eff_Fano = H_S/extend_2_avg_len_Fano/log2(2);
% Huffman code
[sym, extend_2_avg_len_Huffman] = huffmandict(1:length(extend_2_pro), extend_2_pro);
extend_2_avg_len_Huffman = extend_2_avg_len_Huffman / 2;
extend_2_eff_Huffman = H_S/extend_2_avg_len_Huffman/log2(2);

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

save('2_extended.mat', 'extend_2_avg_len_const', 'extend_2_eff_const', 'extend_2_avg_len_Shannon', 'extend_2_eff_Shannon','extend_2_avg_len_Fano', 'extend_2_eff_Fano', 'extend_2_avg_len_Huffman', 'extend_2_eff_Huffman')

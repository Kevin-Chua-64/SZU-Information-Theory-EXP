clear
clc

text = load('orderlist.mat').orderList;
%%%%%%%%%% 3.3 %%%%%%%%%%
% 3 times extended coding
extend_3_count = zeros(27, 27, 27);
for i=1:length(text)-2
    extend_3_count(text(i), text(i+1), text(i+2)) = extend_3_count(text(i), text(i+1), text(i+2)) + 1;
end
extend_3_pro = extend_3_count ./ (length(text)-2);
H_S = 1.4;

% reshape the probalility matrix and delete the symbols with 0 probability
extend_3_pro = reshape(extend_3_pro, [], 1);
extend_3_pro(extend_3_pro==0) = [];
% descending order
extend_3_pro = sort(extend_3_pro, 'descend');
% constant length code
extend_3_avg_len_const = ceil(log2(length(extend_3_pro))) / 3;
extend_3_eff_const = H_S/extend_3_avg_len_const/log2(2);
% Shannon code
extend_3_Shannon = SBE(extend_3_pro);
extend_3_avg_len_Shannon = strlength(extend_3_Shannon)*extend_3_pro / 3;
extend_3_eff_Shannon = H_S/extend_3_avg_len_Shannon/log2(2);
% Fano code
extend_3_Fano = fano(extend_3_pro');
extend_3_avg_len_Fano = strlength(extend_3_Fano)*extend_3_pro / 3;
extend_3_eff_Fano = H_S/extend_3_avg_len_Fano/log2(2);
% Huffman code
[sym, extend_3_avg_len_Huffman] = huffmandict(1:length(extend_3_pro), extend_3_pro);
extend_3_avg_len_Huffman = extend_3_avg_len_Huffman / 3;
extend_3_eff_Huffman = H_S/extend_3_avg_len_Huffman/log2(2);

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

save('3_extended.mat', 'extend_3_avg_len_const', 'extend_3_eff_const', 'extend_3_avg_len_Shannon', 'extend_3_eff_Shannon','extend_3_avg_len_Fano', 'extend_3_eff_Fano', 'extend_3_avg_len_Huffman', 'extend_3_eff_Huffman')

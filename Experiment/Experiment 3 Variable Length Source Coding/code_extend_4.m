clear
clc

text = load('orderlist.mat').orderList;
%%%%%%%%%% 3.3 %%%%%%%%%%
% 4 times extended coding
extend_4_count = zeros(27, 27, 27, 27);
for i=1:length(text)-3
    extend_4_count(text(i), text(i+1), text(i+2), text(i+3)) = extend_4_count(text(i), text(i+1), text(i+2), text(i+3)) + 1;
end
extend_4_pro = extend_4_count ./ (length(text)-3);
H_S = 1.4;

% reshape the probalility matrix and delete the symbols with 0 probability
extend_4_pro = reshape(extend_4_pro, [], 1);
extend_4_pro(extend_4_pro==0) = [];
% descending order
extend_4_pro = sort(extend_4_pro, 'descend');
% constant length code
extend_4_avg_len_const = ceil(log2(length(extend_4_pro))) / 4;
extend_4_eff_const = H_S/extend_4_avg_len_const/log2(2);
% Shannon code
extend_4_Shannon = SBE(extend_4_pro);
extend_4_avg_len_Shannon = strlength(extend_4_Shannon)*extend_4_pro / 4;
extend_4_eff_Shannon = H_S/extend_4_avg_len_Shannon/log2(2);
% % Fano code
extend_4_Fano = fano(extend_4_pro');
extend_4_avg_len_Fano = strlength(extend_4_Fano)*extend_4_pro / 4;
extend_4_eff_Fano = H_S/extend_4_avg_len_Fano/log2(2);
% Huffman code
[sym, extend_4_avg_len_Huffman] = huffmandict(1:length(extend_4_pro), extend_4_pro);
extend_4_avg_len_Huffman = extend_4_avg_len_Huffman / 4;
extend_4_eff_Huffman = H_S/extend_4_avg_len_Huffman/log2(2);

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

save('4_extended.mat', 'extend_4_avg_len_const', 'extend_4_eff_const', 'extend_4_avg_len_Shannon', 'extend_4_eff_Shannon','extend_4_avg_len_Fano', 'extend_4_eff_Fano', 'extend_4_avg_len_Huffman', 'extend_4_eff_Huffman')

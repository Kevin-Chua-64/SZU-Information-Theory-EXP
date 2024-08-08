clear
clc

text = load('orderlist.mat').orderList;
%%%%%%%%%% 3.2 %%%%%%%%%%
% descending order
letter_count = zeros(27, 1);
for i=1:length(text)
    letter_count(text(i)) = letter_count(text(i)) + 1;
end
pro_space = letter_count ./ length(text);
pro_space_de = sort(pro_space, 'descend');
H_S = 1.4;

% constant length code
avg_len_const = ceil(log2(27));
eff_const = H_S/avg_len_const/log2(2);

% Shannon code
Shannon = SBE(pro_space_de);
avg_len_Shannon = strlength(Shannon)*pro_space_de;
eff_Shannon = H_S/avg_len_Shannon/log2(2);

% Fano code
Fano = fano(pro_space_de');
avg_len_Fano = strlength(Fano)*pro_space_de;
eff_Fano = H_S/avg_len_Fano/log2(2);

% Huffman code
[sym, avg_len_Huffman] = huffmandict(1:27, pro_space_de);
eff_Huffman = H_S/avg_len_Huffman/log2(2);

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

save('3_2.mat', 'avg_len_const', 'eff_const', 'avg_len_Shannon', 'eff_Shannon', 'avg_len_Fano', 'eff_Fano', 'avg_len_Huffman', 'eff_Huffman')

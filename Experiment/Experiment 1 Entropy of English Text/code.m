clear
clc

% read the data
file = fopen('English text data.txt');
str = fscanf(file, '%c');
fclose(file);

% pre-processing
str = lower(str);
str = str(( isletter(str) | str==' ' ));
text = abs(str) - 95;
text(text==-63) = 1; % 1 for space

%%%%%%%%%% 3.2 %%%%%%%%%%
letter_count = zeros(27, 1);

% loop and count
for i=1:length(text)
    letter_count(text(i)) = letter_count(text(i)) + 1;
end
pro_space = letter_count ./ length(text);

% entropy
H1 = 0;
for i=1:27
    if pro_space(i) ~= 0
        tem = -pro_space(i) .* log2(pro_space(i));
        H1 = H1 + tem;
    end
end

%%%%%%%%%% 3.3 %%%%%%%%%%
joint_count = zeros(27, 27);
for i=1:length(text)-1
    joint_count(text(i), text(i+1)) = joint_count(text(i), text(i+1)) + 1;
end
joint_pro_space = joint_count ./ (length(text)-1);

% entropy
H2 = 0;
for i=1:27
    for j=1:27
        if joint_pro_space(i, j) ~= 0
            tem = -joint_pro_space(i, j) .* log2(joint_pro_space(i, j));
            H2 = H2 + tem/2;
        end
    end
end

%%%%%%%%%% 3.4 %%%%%%%%%%
cond_count = repmat(letter_count, 1, 27);
cond_pro_space = joint_count ./ cond_count;

% entropy
H_cond = 0;
for i=1:27
    for j=1:27
        if cond_pro_space(i, j) ~= 0
            tem = -joint_pro_space(i, j) .* log2(cond_pro_space(i, j));
            H_cond = H_cond + tem;
        end
    end
end

%%%%%%%%%% 3.5 %%%%%%%%%%
joint_3_count = zeros(27, 27, 27);
for i=1:length(text)-2
    joint_3_count(text(i), text(i+1), text(i+2)) = joint_3_count(text(i), text(i+1), text(i+2)) + 1;
end
joint_3_pro_space = joint_3_count ./ (length(text)-2);

% entropy
H3 = 0;
for i=1:27
    for j=1:27
        for k=1:27
            if joint_3_pro_space(i, j, k) ~= 0
                tem = -joint_3_pro_space(i, j, k) .* log2(joint_3_pro_space(i, j, k));
                H3 = H3 + tem/3;
            end
        end
    end
end

%%%%%%%%%% 3.6 %%%%%%%%%%
joint_4_count = zeros(27, 27, 27, 27);
for i=1:length(text)-3
    joint_4_count(text(i), text(i+1), text(i+2), text(i+3)) = joint_4_count(text(i), text(i+1), text(i+2), text(i+3)) + 1;
end
joint_4_pro_space = joint_4_count ./ (length(text)-3);

% entropy
H4 = 0;
for i=1:27
    for j=1:27
        for k=1:27
            for m=1:27
                if joint_4_pro_space(i, j, k, m) ~= 0
                    tem = -joint_4_pro_space(i, j, k, m) .* log2(joint_4_pro_space(i, j, k, m));
                    H4 = H4 + tem/4;
                end
            end
        end
    end
end

% chain rule
if round(2*H2, 4) == round(H_cond + H1, 4)
    disp('Chain rule is verified')
end
% extreme
H0 = log2(27);
disp('Extreme entropy')
disp(H0)
if (H0>H1 && H0>H2 && H0>H3 && H0>H4)
    disp('Extreme property verified')
end
% independence bound
if H_cond < H1
    disp('Independence bound verified')
end

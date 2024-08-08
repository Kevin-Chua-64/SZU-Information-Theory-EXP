clear
clc

%%%%%%%%%% 3.2 %%%%%%%%%%
% Original audio signal
[sig, Fs] = audioread('audio.wav');
figure
plot(sig)
title('Original signal')

% AR model LPC
coeff_a = lpc(sig, 12);
err_sig = filter(coeff_a, 1, sig);
figure
plot(err_sig)
title('Error signal')

% PDF
[pro, d] = histcounts(sig, 128, 'Normalization', 'probability');
[err_pro, d] = histcounts(err_sig, d, 'Normalization', 'probability');
figure
plot(d(1:end-1), pro)
hold on
plot(d(1:end-1), err_pro)
hold on
title('PDF')
legend('Original signal', 'Error signal')
xlim([-1,1])
ylim([0,0.5])

% entropy
pro_ = pro((pro~=0));
E = sum(-pro_ .* log2(pro_));
err_pro_ = err_pro((err_pro~=0));
E_err = sum(-err_pro_ .* log2(err_pro_));
text(0.1, 0.35, char(['Original signal entropy: ', num2str(E)], [], ['Error signal entropy:     ', num2str(E_err)]))


%%%%%%%%%% 3.3 %%%%%%%%%%
% DCT and IDCT
sub = load('subimage.mat').X;
sub_Y = dct(sub);
sub_X = idct(sub_Y);


%%%%%%%%%% 3.4 %%%%%%%%%%
% Load and preprocess
img = imread('Mona Lisa.jpg');
img = rgb2gray(img);
img_mat = double(img);

% Devide into 8*8 subimages and perform 2-D DCT
[img_xx, img_yy] = size(img_mat);
img_x = img_xx / 8;
img_y = img_yy / 8;
img_dct2 = zeros(img_xx, img_yy);
for i=1:img_x
    for j=1:img_y
        img_dct2( (i-1)*8+1:i*8, (j-1)*8+1:j*8 ) = dct2(img_mat( (i-1)*8+1:i*8, (j-1)*8+1:j*8 ));
    end
end

% Compression -> threshold k=20,50,100,300
[img_th_20, CR_th_20, NMSE_th_20, SNR_th_20] = threshold(img_mat, img_dct2, 20);
[img_th_50, CR_th_50, NMSE_th_50, SNR_th_50] = threshold(img_mat, img_dct2, 50);
[img_th_100, CR_th_100, NMSE_th_100, SNR_th_100] = threshold(img_mat, img_dct2, 100);
[img_th_300, CR_th_300, NMSE_th_300, SNR_th_300] = threshold(img_mat, img_dct2, 300);

figure
set(gcf,'Units','normalized', 'Position',[0.05 0.3 0.9 0.5]);
sgtitle('Compression with different thresholds')
subplot(1,5,1)
imshow(img)
title('Original image')
subplot(1,5,2)
imshow(img_th_20)
title('k = 20')
xlabel(char(['CR = ', num2str(CR_th_20)], ['NMSE = ', num2str(NMSE_th_20)], ['SNR = ', num2str(SNR_th_20), 'dB']))
subplot(1,5,3)
imshow(img_th_50)
title('k = 50')
xlabel(char(['CR = ', num2str(CR_th_50)], ['NMSE = ', num2str(NMSE_th_50)], ['SNR = ', num2str(SNR_th_50), 'dB']))
subplot(1,5,4)
imshow(img_th_100)
title('k = 100')
xlabel(char(['CR = ', num2str(CR_th_100)], ['NMSE = ', num2str(NMSE_th_100)], ['SNR = ', num2str(SNR_th_100), 'dB']))
subplot(1,5,5)
imshow(img_th_300)
title('k = 300')
xlabel(char(['CR = ', num2str(CR_th_300)], ['NMSE = ', num2str(NMSE_th_300)], ['SNR = ', num2str(SNR_th_300), 'dB']))

% Compression -> top left elements 1,3,6,10
[img_ele_1, CR_ele_1, NMSE_ele_1, SNR_ele_1] = top_left(img_mat, img_dct2, 1);
[img_ele_3, CR_ele_3, NMSE_ele_3, SNR_ele_3] = top_left(img_mat, img_dct2, 3);
[img_ele_6, CR_ele_6, NMSE_ele_6, SNR_ele_6] = top_left(img_mat, img_dct2, 6);
[img_ele_10, CR_ele_10, NMSE_ele_10, SNR_ele_10] = top_left(img_mat, img_dct2, 10);

figure
set(gcf,'Units','normalized', 'Position',[0.05 0.3 0.9 0.5]);
sgtitle('Compression with different number of top left triangle elements')
subplot(1,5,1)
imshow(img)
title('Original image')
subplot(1,5,2)
imshow(img_ele_1)
title('e = 1')
xlabel(char(['CR = ', num2str(CR_ele_1)], ['NMSE = ', num2str(NMSE_ele_1)], ['SNR = ', num2str(SNR_ele_1), 'dB']))
subplot(1,5,3)
imshow(img_ele_3)
title('e = 3')
xlabel(char(['CR = ', num2str(CR_ele_3)], ['NMSE = ', num2str(NMSE_ele_3)], ['SNR = ', num2str(SNR_ele_3), 'dB']))
subplot(1,5,4)
imshow(img_ele_6)
title('e = 6')
xlabel(char(['CR = ', num2str(CR_ele_6)], ['NMSE = ', num2str(NMSE_ele_6)], ['SNR = ', num2str(SNR_ele_6), 'dB']))
subplot(1,5,5)
imshow(img_ele_10)
title('e = 10')
xlabel(char(['CR = ', num2str(CR_ele_10)], ['NMSE = ', num2str(NMSE_ele_10)], ['SNR = ', num2str(SNR_ele_10), 'dB']))

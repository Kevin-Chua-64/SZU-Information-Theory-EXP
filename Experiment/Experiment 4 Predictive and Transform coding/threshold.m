function [output_img, CR, NMSE, SNR] = threshold(img, img_dct2, k)
    [img_xx, img_yy] = size(img_dct2);
    img_x = img_xx / 8;
    img_y = img_yy / 8;
    output_img = zeros(img_xx, img_yy);
    % Threshold
    img_dct2((abs(img_dct2) < k)) = 0;
    % IDCT
    for i=1:img_x
        for j=1:img_y
            output_img( (i-1)*8+1:i*8, (j-1)*8+1:j*8 ) = idct2(img_dct2( (i-1)*8+1:i*8, (j-1)*8+1:j*8 ));
        end
    end
    
    % Compression rate
    CR = sum(img_dct2==0, 'all') / (img_xx*img_yy);
    % NMSE
    NMSE = sum((img - output_img).^2, 'all') / (img_xx*img_yy);
    % SNR
    SNR = sum(img.^2, 'all') / sum((img - output_img).^2, 'all');
    SNR = 10*log10(SNR);
    
    % Convert to image form
    output_img = mat2gray(output_img);
end

function [output_img, CR, NMSE, SNR] = top_left(img, img_dct2, e)
    % e = (1+diag_e)*diag_e/2
    % , where e is the number of the elements
    % diag_e is the number of diagonal rows
    diag_e = (sqrt(1+8*e)-1)/2;
    [img_xx, img_yy] = size(img_dct2);
    img_x = img_xx / 8;
    img_y = img_yy / 8;
    output_img = zeros(img_xx, img_yy);
    % Choose elements and IDCT
    for i=1:img_x
        for j=1:img_y
            img_dct2( (i-1)*8+1:i*8, (j-1)*8+1:j*8 ) = fliplr(triu( fliplr(img_dct2( (i-1)*8+1:i*8, (j-1)*8+1:j*8 )), 8-diag_e) );
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

function C = Hamming_de(R, m)
    % R is the receive codeword with arbitrary length
    % m is the number parity check bits
    
    k = 2^m - 1 - m; % info bits
    n = 2^m - 1; % code length
    % check length
    if mod(length(R),n)
        error('Wrong input receive codeword length')
    end
    
    % parity-check matrix H, and generator matrix G
    [H, G] = hammgen(m);
    H = [ H(: , m+1:end), H(: , 1:m) ];
    G = [ G(: , m+1:end), G(: , 1:m)];
    
    % decode
    C = zeros(1, length(R)/n*k);
    for i=1:length(R)/n
        r = R( (i-1)*n+1 : i*n );
        s = mod(r*H', 2); % syndrome vector
        index = ismember(H',s, 'row')'; % 1-bit error pattern
        c = mod(r+index, 2); % 1-bit correction
        c = c(1:k); % extract first k bits as info bits
        C( (i-1)*k+1 : i*k ) = c;
    end
end

function C = Hamming_en(U, m)
    % U is the information sequence vector with arbitrary length
    % m is the number parity check bits
    
    k = 2^m - 1 - m; % info bits
    n = 2^m - 1; % code length
    % padding
    if mod(length(U),k)
        U = [ U, zeros(1, k-mod(length(U),k)) ];
    end
    
    % parity-check matrix H, and generator matrix G
    [H, G] = hammgen(m);
    H = [ H(: , m+1:end), H(: , 1:m) ];
    G = [ G(: , m+1:end), G(: , 1:m)];
    
    % encode
    C = zeros(1, length(U)/k*n);
    for i=1:length(U)/k
        u = U( (i-1)*k+1 : i*k );
        c = mod(u*G, 2);
        C( (i-1)*n+1 : i*n ) = c;
    end

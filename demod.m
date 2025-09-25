function [z,symbol,bitH,bitL] = demod(y)
    if real(y) >= 0 && imag(y) >= 0
        z = 1 + 1j;
        symbol=0;
        bitH=0;
        bitL=0;
    elseif real(y) < 0 && imag(y) >= 0
        z = -1 + 1j;
        symbol=2;
        bitH=1;
        bitL=0;
    elseif real(y) < 0 && imag(y) < 0
        z = -1 - 1j;
        symbol=3;
        bitH=1;
        bitL=1;
    else
        z = 1 - 1j;
        symbol=1;
        bitH=0;
        bitL=1;
    end
    z=z/sqrt(2);
end


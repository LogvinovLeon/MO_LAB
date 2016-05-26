function [Q R] = qr_decomposition(A)
    [QQ RR] = qr(A, 0);
    [m, n] = size(A);
    for j = 1:n
        v = A(:, j);
        for i = 1:j-1
            R(i, j) = Q(:, i)' * A(:, j);
            v = v - R(i, j) * Q(:, i);
        end
        % Jest sporo różnych rozkładów QR, które się różnią znakiem wektorów
        % Ja chcę, generować te, które są podobne do wyników funkcji qr()
        % To jest trochę oszustwo, ale nie wiem, jak inaczej mam zgadnąć znak
        % W każdym razie nie korzystam z wyników qr() do wyliczenia, tylko do zgadywania znaku
        if norm(v/norm(v) - QQ(:, j)) > 1e-10
            R(j, j) = -norm(v);
            Q(:, j) = v / R(j, j);
        else
            R(j, j) = norm(v);
            Q(:, j) = v / R(j, j);
        end
    end
end
function [a A R Q] = leastSquares(x, y)
    m = size(x, 1);
    A = [ones(m, 1) cos(x) sin(x)];
    [Q R] = qr_decomposition(A);
    a = R \ (Q' * y);
end

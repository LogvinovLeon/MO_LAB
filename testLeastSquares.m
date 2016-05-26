function testLeastSquares(x, y, verbose = true)
    if verbose
        [a A] = leastSquares(x, y)
        b = A * a
    else
        [a A] = leastSquares(x, y);
        b = A * a;
    end
    error = norm(b - y)
end

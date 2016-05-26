format long
clear ; close all; clc

fprintf('Test 1...\n')
fprintf('Znalezienie prostej przechodzącej przez 3 punkty\n')
x = unifrnd(0, 2 * pi, 3, 1)
y = unifrnd(0, 2 * pi, 3, 1)
testLeastSquares(x, y)
fprintf('Test 1 finished. Press enter to continue.\n');
pause;clc

fprintf('Test 2...\n')
fprintf('Dla punktów leżących na ustalonej krzywej\n')
m = 5
x = unifrnd(0, 2 * pi, m, 1)
y = -ones(m, 1) + 2 * cos(x) + 0.1*sin(x)
testLeastSquares(x, y)
fprintf('Test 2 finished. Press enter to continue.\n');
pause;clc

fprintf('Test 3...\n')
fprintf('Dla zaburzonych punktów na krzywej\n')
m = 5
x = linspace(0, 2 * pi, m)'
eps = unifrnd(-1e-3, 1e-3, m, 1)
y = -ones(m, 1) + 2 * cos(x) + 0.1*sin(x) + eps
testLeastSquares(x, y)
fprintf('Test 3 finished. Press enter to continue.\n');
pause;clc

fprintf('Test 4...\n')
fprintf("Dla 'złych' punktów (bardzo blisko siebie)\n")
for m = logspace(1, 4, 4) * 2
    for eps = logspace(-4, -1, 4)
        x = ones(m, 1) + unifrnd(-eps, eps, m, 1);
        y = -ones(m, 1) + 2 * cos(x) + 0.1*sin(x);
        fprintf("m = %f eps = %f\n", m, eps)
        testLeastSquares(x, y, false)
        [a A R Q] = leastSquares(x, y);
        octave_error = norm(A\y - [-1;2;0.1])
    end
end
fprintf('Test 4 finished. Press enter to continue.\n');
pause;clc

fprintf('Test 5...\n')
fprintf('Sprawdzenie, że Q oraz R są rozkładem QR oraz, że Q jest ortogonalna\n')
m = 20
eps = 1e-7
x = ones(m, 1) + unifrnd(-eps, eps, m, 1)
y = -ones(m, 1) + 2 * cos(x) + 0.1*sin(x);
[a A R Q] = leastSquares(x, y);
fprintf("Q * R - A\n")
norm(Q * R - A)
fprintf("Q\' * Q - eye(3)\n")
norm(Q' * Q - eye(3))
fprintf("Test 5 finished. Press enter to continue.\n");
pause;clc

fprintf('Test 6...\n')
fprintf('Zbadanie poprawności rozkładu QR oraz porównania wyników do wyników wbudowanej funkcji qr()\n')
m = 5
x = unifrnd(0, 2 * pi, m, 1);
y = -ones(m, 1) + 2 * cos(x) + 0.1*sin(x);
[a A R Q] = leastSquares(x, y);
Q
R
[QQ RR] = qr(A)
QQ(:, 1:3) - Q
RR(1:3, 1:3) - R
fprintf('Test 6 finished. Press enter to continue.\n');
pause;clc
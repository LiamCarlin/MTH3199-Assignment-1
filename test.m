% Plot test_function03 over a suitable range
x = linspace(-50, 100, 1000);
[f, df] = test_function03(x);

figure;
plot(x, f, 'b-', 'LineWidth', 1.5);
hold on;
yyaxis right
plot(x, df, 'r--', 'LineWidth', 1);
yyaxis left
xlabel('x');
ylabel('f(x)');
yyaxis right
ylabel('df/dx');
grid on;
hold off;

%Example sigmoid function
function [f_val,dfdx] = test_function03(x)
a = 27.3; b = 2; c = 8.3; d = -3;
H = exp((x-a)/b);
dH = H/b;
L = 1+H;
dL = dH;
f_val = c*H./L+d;
dfdx = c*(L.*dH-H.*dL)./(L.^2);
end
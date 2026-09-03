%Root finding function via Newton's method
%INPUTS:
%   fun: the function we are computing the root of
%   Note that fun(x) should output [f,dfdx], where dfdx is the derivative of f
%   (see test_func01 below for example)
%   x0: initial guess for Newton's method
%   dxtol: termination threshold (stop when interval abs(x_{i+1}-x_i) < dxtol)
%   ftol: termination threshold (stop when abs(f(x_{i}))<ftol
%   max_iter: maximum iteration limit
%   dxmax: threshold for checking for a divide by zero error: 
%   terminate when abs(x_{i+1}-x_i) > dxmax, where dxmax is a very large number
%OUTPUTS
%   x: estimate for root of fun
%   exit_flag: an integer indicating whether or not the solver succeeded
function [x, exit_flag] = newton_solver(fun,x0,dxtol,ftol,max_iter,dxmax)
    x = x0;
    for i = 1:max_iter
        [fval, dfdx] = fun(x);

        if abs(fval) < ftol
            exit_flag = 1;
            return
        end

        x_new = x - fval / dfdx;

        if abs(x_new - x) > dxmax
            exit_flag = -1;
            return
        end

        if abs(x_new - x) < dxtol
            x = x_new;
            exit_flag = 2;
            return
        end

        x = x_new;
    end
    exit_flag = 0;
    disp("Did not converge within tolerance")
end
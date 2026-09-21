%Function that computes the bounding box of an oval
%INPUTS:
%theta: rotation of the oval. theta is a number from 0 to 2*pi.
%x0: horizontal offset of the oval
%y0: vertical offset of the oval
%egg_params: a struct describing the hyperparameters of the oval
%OUTPUTS:
%x_range: the x limits of the bounding box in the form [x_min,x_max]
%y_range: the y limits of the bounding box in the form [y_min,y_max]
function [x_range,y_range] = compute_bounding_box(x0,y0,theta,egg_params)

    % single-input, single-output functions: dx/ds and dy/ds
    dxds_fun = @(s) egg_wrapper1(s, x0, y0, theta, egg_params, 1);
    dyds_fun = @(s) egg_wrapper1(s, x0, y0, theta, egg_params, 2);

    % find every s in [0,1] where the tangent is horizontal/vertical
    s_x = find_all_roots(dxds_fun);   
    s_y = find_all_roots(dyds_fun);   

    % convert those s values into actual coordinates
    V_x = egg_func(s_x, x0, y0, theta, egg_params);
    V_y = egg_func(s_y, x0, y0, theta, egg_params);

    % the min/max over all candidates gives the box
    x_range = [min(V_x(1,:)), max(V_x(1,:))];
    y_range = [min(V_y(2,:)), max(V_y(2,:))];

    
end

%Wrapper: returns one component of G
function out = egg_wrapper1(s, x0, y0, theta, egg_params, which_component)
    [~, G] = egg_func(s, x0, y0, theta, egg_params);
    out = G(which_component, :);
end


%Finds all roots of fun on s in [0,1] by finding sign changes,
%then refining each bracket with bisection_solver
function s_roots = find_all_roots(fun)
    N = 200;                         
    s_grid = linspace(0, 1, N);
    f_grid = fun(s_grid);
    s_roots = [];

    for i = 1:N-1
        if f_grid(i) == 0
            s_roots(end+1) = s_grid(i);
        elseif f_grid(i)*f_grid(i+1) < 0 % checks if there is a change in sign 
            s_roots(end+1) = bisection_solver(fun, s_grid(i), s_grid(i+1), 1e-14, 1e-14, 100);
        end
    end
end
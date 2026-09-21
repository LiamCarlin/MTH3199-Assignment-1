%Function that computes the collision time for a thrown egg
%INPUTS:
%traj_fun: a function that describes the [x,y,theta] trajectory
% of the egg (takes time t as input)
%egg_params: a struct describing the hyperparameters of the oval
%y_ground: height of the ground
%x_wall: position of the wall
%OUTPUTS:
%t_ground: time that the egg would hit the ground
%t_wall: time that the egg would hit the wall
function [t_ground,t_wall] = collision_func(traj_fun, egg_params, y_ground, x_wall)

    % gap functions: zero at the moment of contact
    ground_gap = @(t) ground_gap_fun(t, traj_fun, egg_params, y_ground);
    wall_gap   = @(t) wall_gap_fun(t, traj_fun, egg_params, x_wall);

    t_ground = first_crossing(ground_gap);
    t_wall   = first_crossing(wall_gap);

end

% distance from the bottom of the egg to the ground (positive = above)
function out = ground_gap_fun(t, traj_fun, egg_params, y_ground)
    [x0, y0, theta] = traj_fun(t);
    [~, y_range] = compute_bounding_box(x0, y0, theta, egg_params);
    out = y_range(1) - y_ground;
end

% distance from the right of the egg to the wall (negative = left of wall)
function out = wall_gap_fun(t, traj_fun, egg_params, x_wall)
    [x0, y0, theta] = traj_fun(t);
    [x_range, ~] = compute_bounding_box(x0, y0, theta, egg_params);
    out = x_range(2) - x_wall;
end

% march forward in time to find the first sign change, then bisect
function t_root = first_crossing(fun)
    dt = 0.01;        % time step for the scan 
    t_max = 50;         

    t_prev = 0;
    f_prev = fun(t_prev);

    while t_prev < t_max
        t_next = t_prev + dt;
        f_next = fun(t_next);

        if f_prev*f_next < 0
            t_root = bisection_solver(fun, t_prev, t_next, 1e-12, 1e-12, 100);
            return
        elseif f_next == 0
            t_root = t_next;
            return
        end

        t_prev = t_next;
        f_prev = f_next;
    end


end
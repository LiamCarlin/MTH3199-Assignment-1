function video_example()
    % system parameters 
    egg_params = struct();
    egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
    traj_fun = @egg_trajectory01;
    y_ground = 0;
    x_wall   = 30;

    % find when and what the egg hits
    [t_ground, t_wall] = collision_func(traj_fun, egg_params, y_ground, x_wall);
    [t_hit, hit_type] = min([t_ground, t_wall]);   % 1 = ground, 2 = wall
    hit_names = {'ground', 'wall'};

    % timing 
    fps = 30;
    t_list = [0:1/fps:t_hit, t_hit];             
    s_list = linspace(0, 1, 500);

    % precompute the center's path (for the trail) and axis limits 
    [x_path, y_path, ~] = traj_fun(t_list);
    pad = 2*max(egg_params.a, egg_params.b);
    x_lim = [min(x_path) - pad, x_wall + 0.15*x_wall];
    y_lim = [y_ground - 0.12*(max(y_path) - y_ground), max(y_path) + pad];

    writerObj = VideoWriter('egg_animation.mp4', 'MPEG-4');
    writerObj.FrameRate = fps;
    open(writerObj);

    fig1 = figure(1); clf
    set(fig1, 'Position', [100 100 1000 600], 'Color', 'w');
    hold on; box on; grid on
    set(gca, 'FontSize', 12, 'GridAlpha', 0.15);
    axis equal; xlim(x_lim); ylim(y_lim);
    xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$y$', 'Interpreter', 'latex', 'FontSize', 14);
    title('Flying Egg', 'FontSize', 15);

    % ground and wall
    y_top = y_lim(2);
    ground_line = plot(x_lim, [y_ground y_ground], 'k-', 'LineWidth', 2.5, ...
                       'DisplayName', 'Ground');
    wall_line   = plot([x_wall x_wall], [y_ground y_top], '-', ...
                       'Color', [0.5 0.1 0.1], 'LineWidth', 2.5, 'DisplayName', 'Wall');
 

    % objects that get updated every frame 

    box_plot = plot(NaN, NaN, '--', 'Color', [0 0.45 0.74], 'LineWidth', 1.5, ...
                    'DisplayName', 'Bounding box');
    egg_plot = fill(NaN, NaN, [0.85 0.85 0.85], 'EdgeColor', 'k', ...
                    'LineWidth', 1.5, 'DisplayName', 'Egg');
    center_plot = plot(NaN, NaN, 'k+', 'MarkerSize', 10, 'LineWidth', 1.5, ...
                       'HandleVisibility', 'off');
    contact_plot = plot(NaN, NaN, 'o', 'MarkerSize', 10, ...
                        'MarkerFaceColor', [0.85 0.1 0.1], 'MarkerEdgeColor', 'k', ...
                        'DisplayName', 'Contact point');
    time_text = text(x_lim(1) + 1, y_lim(2) - 1.5, '', 'FontSize', 13, ...
                     'FontWeight', 'bold', 'VerticalAlignment', 'top');


    %  fly the egg until the collision 
    for k = 1:length(t_list)
        t = t_list(k);
        [x0, y0, theta] = traj_fun(t);
        V = egg_func(s_list, x0, y0, theta, egg_params);
        [x_range, y_range] = compute_bounding_box(x0, y0, theta, egg_params);

        set(egg_plot, 'xdata', V(1,:), 'ydata', V(2,:));
        set(center_plot, 'xdata', x0, 'ydata', y0);
        set(box_plot, 'xdata', [x_range(1) x_range(2) x_range(2) x_range(1) x_range(1)], ...
                      'ydata', [y_range(1) y_range(1) y_range(2) y_range(2) y_range(1)]);
        
        drawnow;
        writeVideo(writerObj, getframe(fig1));
    end

    % mark the contact point
    if hit_type == 1
        [~, idx] = min(V(2,:));      % lowest point on the egg
    else
        [~, idx] = max(V(1,:));      % rightmost point on the egg
    end
    set(contact_plot, 'xdata', V(1,idx), 'ydata', V(2,idx));
    set(time_text, 'String', sprintf(['t = %.2f s  |  hit the %s at (%.2f, %.2f), ' ...
                   '\\theta = %.2f rad'], t_hit, hit_names{hit_type}, ...
                   V(1,idx), V(2,idx), theta));
    drawnow;

    % freeze in place for 2 seconds 
    frame = getframe(fig1);
    for k = 1:2*fps
        writeVideo(writerObj, frame);
    end

    close(writerObj);
end



%Example parabolic trajectory
function [x0,y0,theta] = egg_trajectory01(t)
x0 = 7*t + 8;
y0 = -6*t.^2 + 20*t + 6;
theta = 5*t;
end
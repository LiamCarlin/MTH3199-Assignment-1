%example of how to test the bounding box function
function bounding_box_test()
    %set the oval hyper-parameters
    egg_params = struct();
    egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;

    %specify the position and orientation of the egg
    x0 = 5; y0 = 5; theta = pi/6;

    %set up the axis
    hold on; axis equal; axis square
    axis([0,10,0,10])

    %plot the origin of the egg frame
    plot(x0,y0,'ro','markerfacecolor','r');

    %compute the perimeter of the egg
    [V_list, G_list] = egg_func(linspace(0,1,100),x0,y0,theta,egg_params);

    %plot the perimeter of the egg
    plot(V_list(1,:),V_list(2,:),'k');
    
    %compute the bounding box of the egg
    [x_range,y_range] = compute_bounding_box(x0,y0,theta,egg_params)

    
    box_x = [x_range(1), x_range(2), x_range(2), x_range(1), x_range(1)];
    box_y = [y_range(1), y_range(1), y_range(2), y_range(2), y_range(1)];
    plot(box_x, box_y, 'c-', 'linewidth', 1.5);
    hold on; box on; grid on
    set(gca, 'FontSize', 12, 'GridAlpha', 0.2);

    % egg body 
    fill(V_list(1,:), V_list(2,:), [0.85 0.85 0.85], 'EdgeColor', 'k','LineWidth', 1.5, 'DisplayName', 'Egg');

    % bounding box
    plot(box_x, box_y, '--', 'Color', [0 0.45 0.74], 'LineWidth', 1.5,'DisplayName', 'Bounding box');

    % egg center
    plot(x0, y0, 'k+', 'MarkerSize', 10, 'LineWidth', 1.5,'DisplayName', 'Center $(x_0, y_0)$');

    % axes: equal scaling, with padding around the box
    pad = 0.15 * max(diff(x_range), diff(y_range));
    axis equal
    xlim([x_range(1)-pad, x_range(2)+pad]);
    ylim([y_range(1)-pad, y_range(2)+pad]);

    xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$y$', 'Interpreter', 'latex', 'FontSize', 14);
    title(sprintf('Egg with Bounding Box ($\\theta = %.2f$ rad)', theta), 'Interpreter', 'latex', 'FontSize', 14);
end
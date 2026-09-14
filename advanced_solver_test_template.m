% Collect errors, filter them, fit a line, and plot.
function advanced_solver_test_template()
    num_trials = 1000;
    % These starting guesses also bracket the root for bisection.
    guess_list1 = linspace(15,39,num_trials);
    guess_list2 = linspace(15,39,num_trials);

    filter_list = [1e-15, 1e-2, 1e-14, 1e-2, 2];

    dxtol = 1e-14;
    ftol = 1e-14;
    max_iter = 200;
    dxmax = 1e7;
    x_root = fzero(@test_func03,[23,30]);

    my_recorder = input_recorder();
    f_record = my_recorder.generate_recorder_fun(@test_func03);
    x_current_list = [];
    x_next_list = [];
    index_list = [];
    failed_guesses = [];

    % Uncomment for Fzero and Newton
     did_fail = false(size(guess_list1));

    % Uncomment for Bisection or secant
    % did_fail = true(num_trials, num_trials);

     for n = 1:length(guess_list1)
         my_recorder.clear_input_list();
         x0 = guess_list1(n);
     
         % Newton
         % [x, exit_flag] = newton_solver(f_record,x0,dxtol,ftol,max_iter,dxmax);
         % input_list = my_recorder.get_input_list();
         % if exit_flag ~= 1 && exit_flag ~= 2
         %     failed_guesses(end+1) = x0;
         %     did_fail(n) = true;
         % end
         % solver_name = 'Newton';
     
         % Bisection
         % bisection_solver(f_record, x_left, x_right, dxtol, ftol, max_iter);
         % input_list = my_recorder.get_input_list();
         % input_list = input_list(3:end); 
         % solver_name = 'Bisection';
     
         % Secant
         % secant_solver(f_record,x0,guess_list2(n),dxtol,ftol,max_iter,dxmax);
         % input_list = my_recorder.get_input_list();
         % input_list = [x0,input_list(1:4:end)]; % four calls per step.
         % solver_name = 'Secant';
     
         % fzero
         % [x,fval,exit_flag,output] = fzero(f_record,x0);
         % input_list = my_recorder.get_input_list();
         % x0 = guess_list1(n);
         % 
         % try
         %     [x, fval, exit_flag] = fzero(@test_func03, x0);
         %     did_fail(n) = (exit_flag ~= 1);
         % catch
         %     did_fail(n) = true;
         % end
         % solver_name = 'fzero';
     
         x_current_list = [x_current_list,input_list(1:end-1)];
         x_next_list = [x_next_list,input_list(2:end)];
         index_list = [index_list,1:length(input_list)-1];
     
     end

    

    % Newton Solver Inital S/F Guesses

     % x_plot = linspace(min(guess_list1)-1, max(guess_list1)+1, 500);
     % y_plot = test_func03(x_plot);
     % 
     % figure;
     % plot(x_plot, y_plot, 'k-', 'LineWidth', 2);
     % hold on;
     % 
     % plot(guess_list1(~did_fail), test_func03(guess_list1(~did_fail)), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 3);
     % 
     % plot(guess_list1(did_fail), test_func03(guess_list1(did_fail)), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 3);
     % 
     % yline(0, 'k:');
     % 
     % plot(x_root, test_func03(x_root), 'mo', 'MarkerFaceColor', 'm', 'MarkerSize', 10);
     % 
     % xlabel('x');
     % ylabel('f(x)');
     % title('Newton Method Successes and Fails for Initial Guesses');
     % 
     % legend('Sigmoid function', 'Newton converged', 'Newton failed', 'f(x) = 0', 'Root', 'Location', 'southoutside');

    
    % Fzero Solver Initial S/F Guesses

     % x_plot = linspace(min(guess_list1)-1, max(guess_list1)+1, 500);
     % y_plot = test_func03(x_plot);
     % 
     % figure
     % plot(x_plot, y_plot, 'k-', 'LineWidth', 2)
     % hold on
     % 
     % plot(guess_list1(~did_fail), test_func03(guess_list1(~did_fail)), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 5)
     % 
     % plot(guess_list1(did_fail), test_func03(guess_list1(did_fail)), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 5)
     % 
     % yline(0, 'k--', 'LineWidth', 1.5)
     % 
     % plot(x_root, test_func03(x_root), 'mo', 'MarkerFaceColor', 'm', 'MarkerSize', 10)
     % 
     % xlabel('Function input x', 'FontSize', 14)
     % ylabel('Function output f(x)', 'FontSize', 14)
     % title('fzero Successes and failures for Initial Guesses')
     % 
     % legend('Sigmoid function', 'fzero converged', 'fzero failed', 'f(x) = 0', 'Root', 'Location', 'southoutside', 'FontSize', 12)


    % Bisection Solver Initial S/F Guesses
    % Uncomment for Bisection diagram and comment out upper loop
     % 
     % for row = 1:num_trials
     %     for col = 1:num_trials
     %         x_left = guess_list1(col);
     %         x_right = guess_list2(row);
     % 
     %         [~, exit_flag] = bisection_solver(@test_func03, x_left, x_right, dxtol, ftol, max_iter);
     % 
     %         did_fail(row, col) = (exit_flag ~= 1);
     %     end
     % end
     % 
     % figure
     % hold on
     % 
     % % Find the row/column of every failed and successful trial.
     % [fail_row, fail_col] = find(did_fail);
     % [success_row, success_col] = find(~did_fail);
     % 
     % % Plot every individual trial.
     % h_fail = plot(guess_list1(fail_col), guess_list2(fail_row), 'r.', 'MarkerSize', 5);
     % 
     % h_success = plot(guess_list1(success_col), guess_list2(success_row), 'g.', 'MarkerSize', 5);
     % 
     % % Root-location lines and required root point.
     % xline(x_root, 'k--')
     % yline(x_root, 'k--')
     % h_root = plot(x_root, x_root, 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 8);
     % 
     % xlabel('Initial left guess')
     % ylabel('Initial right guess')
     % title('Bisection Method Initial Guess Convergence')
     % 
     % legend([h_fail h_success h_root], 'Failure', 'Success', 'Root', 'Location', 'eastoutside')
     % 
     % return



    % Uncomment for Secant diagram
    % for row = 1:num_trials
    %     for col = 1:num_trials
    %         x0 = guess_list1(col);
    %         x1 = guess_list2(row);
    % 
    %         [~, exit_flag] = secant_solver(@test_func03, x0, x1, dxtol, ftol, max_iter, dxmax);
    % 
    %         did_fail(row, col) = (exit_flag ~= 1 && exit_flag ~= 2);
    %     end
    % end
    % 
    % 
    % % Secant Solver Initial S/F Guesses
    % 
    % figure
    % hold on
    % 
    % [fail_row, fail_col] = find(did_fail);
    % [success_row, success_col] = find(~did_fail);
    % 
    % h_fail = plot(guess_list1(fail_col), guess_list2(fail_row),'r.', 'MarkerSize', 5);
    % 
    % h_success = plot(guess_list1(success_col), guess_list2(success_row),'b.', 'MarkerSize', 5);
    % 
    % xline(x_root, 'k--')
    % yline(x_root, 'k--')
    % 
    % h_root = plot(x_root, x_root, 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 8);
    % 
    % xlabel('Initial guess, x0')
    % ylabel('Initial guess, x1')
    % title('Secant Method: Sigmoid Initial Guess Convergence')
    % 
    % legend([h_fail h_success h_root], 'Failure', 'Success', 'Root', 'Location', 'eastoutside')
    % 
    % return





    error_list0 = abs(x_current_list-x_root);
    error_list1 = abs(x_next_list-x_root);
    [x_regression,y_regression] = filter_errors(error_list0,error_list1,index_list,filter_list);

    [p,k] = generate_error_fit(x_regression,y_regression);

    figure;
    loglog(error_list0,error_list1,'o','MarkerSize',2);

    hold on;
    loglog(x_regression,y_regression,'bo','MarkerFaceColor','b','MarkerSize',2);

    fit_line_x = 10.^[-16:.01:1];
    fit_line_y = k*fit_line_x.^p;
    loglog(fit_line_x,fit_line_y,'k-','LineWidth',2);
    axis([1e-16 1e2 1e-16 1e2]);
    xlabel('Current iteration error');
    ylabel('Next iteration error');
    title(sprintf('%s Convergence: %d Trials',solver_name,length(guess_list1)));
    set(gca,'FontSize',12);
    legend('Raw error data','Filtered error data', sprintf('Fit: p = %.3f, k = %.4f',p,k),'Location','southoutside');
    fprintf('%s: p = %.6f, k = %.6f\n',solver_name,p,k);


end

%Definition of the test function and its derivative (as a single function):
%This definition uses the function keyword
%when passing this function as an argument to a solver,
%you'll need to use the handle operator
%ex. solver(@test_func01,x_guess)
function [fval,dfdx] = test_func01(x)
    fval = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
    dfdx = 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
end

function [f_val, dfdx] = test_func02(x)
f_val = (x - 37.879).^2;
dfdx = 2*(x - 37.879);
end

%Example sigmoid function
function [f_val,dfdx] = test_func03(x)
a = 27.3; b = 2; c = 8.3; d = -3;
H = exp((x-a)/b);
dH = H/b;
L = 1+H;
dL = dH;
f_val = c*H./L+d;
dfdx = c*(L.*dH-H.*dL)./(L.^2);
end

% Filter

function [x_regression,y_regression] = filter_errors(error_list0,error_list1,index_list,filter_list)
    x_regression = [];
    y_regression = [];
    for n = 1:length(index_list)
        if error_list0(n)>filter_list(1) && error_list0(n)<filter_list(2) && ...
           error_list1(n)>filter_list(3) && error_list1(n)<filter_list(4) && ...
           index_list(n)>filter_list(5)
            x_regression(end+1) = error_list0(n);
            y_regression(end+1) = error_list1(n);
        end
    end
end

% regression function
function [p,k] = generate_error_fit(x_regression,y_regression)
    Y = log(y_regression)';
    X1 = log(x_regression)';
    X2 = ones(length(X1),1);
    coeff_vec = regress(Y,[X1,X2]);
    p = coeff_vec(1);
    k = exp(coeff_vec(2));
end

